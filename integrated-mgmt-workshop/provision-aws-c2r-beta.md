## Use Ansible to Provision Workshop on AWS
**(convert2rhel exercise beta)**

*The below instructions are steps that originated from:*<br>
*- https://github.com/ansible/workshops/tree/devel/provisioner*<br>


**Requirements:**
- System with git, python3, expect(unbuffer utility), ansible
- Active public domain name (from AWS or other DNS registrar)
- AWS Account
- DNS setup (Hosted Zone) via AWS Route53

> **NOTE**: Configuring the AWS Hosted Zone to utilize domains registered via other DNS registrars outside of AWS is beyond the scope of these instructions. Many howto documents covering the process can be found via an online search.

**Steps:**
 
OS Config -- software tools install & config (including Ansible)

> **NOTE**: The following instructions assume a RHEL family variant, however, all commands (other than package installation commands) *should* work on other Linux variants and Macs, assuming the same tools outlined as installed via dnf/yum are provisioned utilizing installation tools native to those operating systems.

- use yum for RHEL7/CentOS7, dnf for RHEL8/Fedora
```
$ sudo dnf install vim git python3 expect ansible
$ python3 -m pip install --user --upgrade pip setuptools
$ python3 -m pip install --user wheel
$ python3 -m pip install --user boto boto3 netaddr passlib 

$ mkdir -p ~/smrtmgmt01/deploy_logs
$ mkdir ~/smrtmgmt01/deploy_vars
$ mkdir -p ~/github/ansible
$ cd ~/github/ansible
$ git clone https://github.com/heatmiser/workshops.git
$ cd workshops
$ git checkout tip

$ vim ~/smrtmgmt01/deploy_vars/smart_mgmt_wkshop_vars.yml
```

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
admin_password: redhat$$!!

# Sets the AWS Route53 DNS Hosted zone to use
workshop_dns_zone: subdom.redhatpartnertech.net

# automatically installs Tower to control node
towerinstall: true
create_cluster: false

# IBM Community Grid - defaults to true if you don't tell the provisioner
ibm_community_grid: false

# select rhel7 or rhel8 client nodes
rhel: rhel7

# choice of centos6 or centos7 nodes
# refer to https://wiki.centos.org/Cloud/AWS for available minor releases
# comment out one, uncomment the other
# select centos6 client node version
#centos6: centos68
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
- Move zip file to default "provisioner" folder and rename<br>
`$ mv ~/manifest_sm-mgmt-wkshop_20210128T182529Z.zip ~/github/ansible/workshops/provisioner/manifest.zip`

**AWS Keys/Credentials**
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

**AWS CLI setup**
```
$ python3 -m pip install --user awscli
$ # now test AWS Credentials are configured correctly via above steps
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
$ cd ~/github/ansible/workshops/provisioner
$ unbuffer ansible-playbook provision_lab.yml -e @~/smrtmgmt01/deploy_vars/smart_mgmt_wkshop_vars.yml -vvv | tee ~/smrtmgmt01/deploy_logs/mgmtlab-deploy-$(date +%Y-%m-%d.%H%M).log
```

[Have fun with the C2R lab!!!](https://github.com/redhat-partner-tech/partner-tech-days-march2021/blob/main/integrated-mgmt-workshop/exercises/4-convert2rhel/upgrade-exercise.md)

**Teardown**
```
$ cd ~/github/ansible/workshops/provisioner
$ unbuffer ansible-playbook teardown_lab.yml -e @~/smrtmgmt01/deploy_vars/smart_mgmt_wkshop_vars.yml -e debug_teardown=true -vvv | tee ~/smrtmgmt01/deploy_logs/mgmtlab-teardown-$(date +%Y-%m-%d.%H%M).log
```
