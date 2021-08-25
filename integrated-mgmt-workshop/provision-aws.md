## Use Ansible to Provision Workshop on AWS

*The below instructions are steps that originated from:*<br>
*- https://github.com/ansible/workshops/tree/devel/provisioner*<br>



**Requirements:**
- System with git, python3, expect(unbuffer utility), ansible
- Active public domain name (from AWS or other DNS registrar)
- AWS Account
- DNS setup (Hosted Zone) via AWS Route53

**Setup DNS:** 
- You will need to setup DNS via AWS route53
- Use AWS Public Hosted zone
- Example: subdom.redhatpartnertech.net
- Reference: https://github.com/ansible/workshops/tree/devel/provisioner#dns

**Steps:**
 
OS Config -- software tools install & config (including Ansible)

> **NOTE**: The following instructions assume a RHEL family variant, however, all commands (other than package installation commands) *should* work on other Linux variants and Macs, assuming the same tools outlined as installed via dnf/yum are provisioned utilizing installation tools native to those operating systems.

- use yum for RHEL7/CentOS7, dnf for RHEL8/Fedora
```
$ sudo dnf install vim git python3 expect
$ python3 -m pip install --user --upgrade pip setuptools
$ python3 -m pip install --user wheel
$ python3 -m pip install --user ansible==2.10.5
$ python3 -m pip install --user requests
$ python3 -m pip install --user yamllint==1.19.0
$ python3 -m pip install --user boto3==1.16.59
$ python3 -m pip install --user boto==2.49.0
$ python3 -m pip install --user awscli==1.18.219
$ python3 -m pip install --user netaddr==0.8.0
$ python3 -m pip install --user passlib==1.7.4
$ python3 -m pip install --user tox==3.22.0
$ python3 -m pip install --user pywinrm==0.4.2
$ python3 -m pip install --user requests-credssp
```

Create log and var directories and clone provisioner

```
$ mkdir -p ~/smrtmgmt01/deploy_logs
$ mkdir ~/smrtmgmt01/deploy_vars
$ mkdir -p ~/github/redhat-partner-tech
$ cd ~/github/redhat-partner-tech
$ git clone https://github.com/redhat-partner-tech/ansible-workshops.git

$ vim ~/smrtmgmt01/deploy_vars/smart_mgmt_wkshop_vars.yml
```
Please modify the following variables below to match your unique configuration.
- ec2_region: (a single ec2 region, ex. us-east-1; us-east-2)
- ec2_name_prefix: (a single unique name for your workshop, ex. smrtmgmt01; smrtmgmtvendor)
- admin_password: (a strong password 15+ characters, ex. Ansible=2021!!!)
- workshop_dns_zone: (setup in your route53 configuration, ex. subdom.redhatpartnertech.net)

All remaining variables LEAVE AS IS!!!
```
---
# region where the nodes will live
ec2_region: us-east-1

# name prefix for all the VMs, plus subdomain name prepended to workshop_dns_zone
ec2_name_prefix: smrtmgmt01

# creates student_total of workbenches for the workshop
student_total: 1

# Set the right workshop type, like network, rhel or f5 (see above)
#workshop_type: rhel
workshop_type: smart_mgmt

#####OPTIONAL VARIABLES

# turn DNS on for control nodes, and set to type in valid_dns_type
dns_type: aws

# password for Ansible control node
admin_password: Ansible=2021!!!

# Sets the AWS Route53 DNS Hosted zone to use
workshop_dns_zone: subdom.redhatpartnertech.net

# automatically installs Tower to control node
towerinstall: true
create_cluster: false

# IBM Community Grid - defaults to true if you don't tell the provisioner
ibm_community_grid: false

# select rhel7 or rhel8 client nodes
rhel: rhel7

# choice of centos7 nodes
# refer to https://wiki.centos.org/Cloud/AWS for available minor releases
# select centos7 client node version
centos7: centos78

# this will install VS Code web on all control nodes, uncomment if you want it
#code_server: true

# Enable AWS IAM integration with control(tower) node and workshop nodes
tower_node_aws_api_access: true
```

**Setup DNS** 
- You will need to setup DNS via AWS Route53
- Use AWS Public Hosted zone
- Example: subdom.redhatpartnertech.net
- Reference: https://github.com/ansible/workshops/tree/devel/provisioner#dns

**Manifest**
- Login to https://access.redhat.com --> Subscriptions --> Subscription Allocations, then [New Subscription Allocation]
- Name it, then select type: Satellite 6.8, then click [Create]
- Once created, select the Subscriptions tab, then click [Add Subscriptions] to add # of Red Hat Ansible Automation subs
- Click [Export Manifest] to download .zip file
- Move zip file to "workshops" folder and rename<br>
`$ mv ~/manifest_sm-mgmt-wkshop_20210128T182529Z.zip ~/github/ansible/workshops/manifest.zip`

**AWS Keys/Credentials - credentials file or via environment variables**
- [Walkthrough Steps](https://github.com/ansible/workshops/blob/devel/docs/aws-directions/AWSHELP.md)
- Reference: https://docs.aws.amazon.com/general/latest/gr/aws-access-keys-best-practices.html

**via credentials file**
```
$ cd ~
$ mkdir .aws
$ cd .aws
$ vim credentials 
$ cat credentials
[default]
aws_access_key_id = AKIAIDA7I6XT....
aws_secret_access_key = GP7nC7Oq+tP8akFWqO....
$
```

- or if you don't want keys/creds in a file...

**via environment variables**
```
$ export AWS_ACCESS_KEY_ID="AKIAIDA7I6XT...."
$ export AWS_SECRET_ACCESS_KEY="GP7nC7Oq+tP8akFWqO...."
$
```

**Test AWS Credentials**
```
$ aws sts get-caller-identity
```
or
```
$ aws ec2 describe-regions --region us-east-1
```
*** Set default python version via alternatives for provisioner to utilize correct python runtime ***
- "alternatives" utility used when several programs fulfilling the same or similar functions are installed on a single system at the same time, in this case, `python`
```
$ which python
/usr/bin/which: no python in (/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin)
$ alternatives --list | grep -i python
python              	auto  	/usr/libexec/no-python
python3             	auto  	/usr/bin/python3.6
$ alternatives --set python /usr/bin/python3
$ alternatives --list | grep -i python
python              	manual	/usr/bin/python3
python3             	auto  	/usr/bin/python3.6
$ python --version
Python 3.6.8
```

**Finally, run the provisioner**
```
$ cd ~/github/redhat-partner-tech/ansible-workshops
$ export ANSIBLE_CONFIG=provisioner/ansible.cfg
$ export AWS_MAX_ATTEMPTS=10
$ export AWS_RETRY_MODE=standard
$ unbuffer ansible-playbook ./provisioner/provision_lab.yml -e @~/smrtmgmt01/deploy_vars/smart_mgmt_wkshop_vars.yml -vvv | tee ~/smrtmgmt01/deploy_logs/mgmtlab-deploy-$(date +%Y-%m-%d.%H%M).log
```

**Teardown**
```
$ cd ~/github/ansible/workshops
$ unbuffer ansible-playbook teardown_lab.yml -e @~/smrtmgmt01/deploy_vars/smart_mgmt_wkshop_vars.yml -e debug_teardown=true -vvv | tee ~/smrtmgmt01/deploy_logs/mgmtlab-teardown-$(date +%Y-%m-%d.%H%M).log
```


