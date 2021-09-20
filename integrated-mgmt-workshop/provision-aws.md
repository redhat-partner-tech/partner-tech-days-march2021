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

> **NOTE**: The following instructions assume a RHEL family variant, however, all commands (other than package installation commands) *should* work on other Linux variants and Macs, assuming the same tools outlined as installed via dnf/yum, are provisioned utilizing installation tools native to those operating systems.

- use yum for RHEL7/CentOS7, dnf for RHEL8/Fedora
```
$ sudo dnf install vim git python3 expect
```
**RHEL family --> Set default python version via alternatives for provisioner to utilize correct python runtime**
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

Create directory named "smrtmgmt01" which will hold the python virtual env, in addition to log and var directories

```
$ cd ~
$ export PYVENV_PROJDIR="smrtmgmt01"
$ mkdir -p ~/$PYVENV_PROJDIR/deploy_logs
$ mkdir ~/$PYVENV_PROJDIR/deploy_vars
```

Upgrade user python libraries pip and setuptools, create python virtual env, and deploy pip libraries to project python virtual env

```
$ python3 -m pip install --user --upgrade pip setuptools
$ python3 -m pip venv $PYVENV_PROJDIR
$ source ~/$PYVENV_PROJDIR/bin/activate
(smrtmgmt01) $ python3 -m pip install --upgrade pip setuptools
(smrtmgmt01) $ python3 -m pip install wheel
(smrtmgmt01) $ python3 -m pip install ansible==2.10.5 \
    requests==2.26.0 \
    yamllint==1.19.0 \
    boto3==1.16.59 \
    boto==2.49.0 \
    awscli==1.18.219 \
    netaddr==0.8.0 \
    passlib==1.7.4 \
    tox==3.22.0 \
    pywinrm==0.4.2 \
    requests-credssp==1.2.0
```

 clone provisioner

```
(smrtmgmt01) $ mkdir -p ~/github/redhat-partner-tech
(smrtmgmt01) $ cd ~/github/redhat-partner-tech
(smrtmgmt01) $ git clone https://github.com/redhat-partner-tech/ansible-workshops.git

(smrtmgmt01) $ vim ~/$PYVENV_PROJDIR/deploy_vars/smart_mgmt_wkshop_vars.yml
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
- Move zip file to "ansible-workshops" folder and rename to manifest.zip<br>
`$ mv ~/manifest_sm-mgmt-wkshop_20210128T182529Z.zip ~/github/redhat-partner-tech/ansible-workshops/provisioner/manifest.zip`

**Test AWS Credentials**
```
(smrtmgmt01) $ aws sts get-caller-identity
```
or
```
(smrtmgmt01) $ aws ec2 describe-regions --region us-east-1
```

**Finally, run the provisioner**
```
(smrtmgmt01) $ cd ~/github/redhat-partner-tech/ansible-workshops
(smrtmgmt01) $ export ANSIBLE_CONFIG=provisioner/ansible.cfg
(smrtmgmt01) $ export AWS_MAX_ATTEMPTS=10
(smrtmgmt01) $ export AWS_RETRY_MODE=standard
(smrtmgmt01) $ unbuffer ansible-playbook ./provisioner/provision_lab.yml -e @~/smrtmgmt01/deploy_vars/smart_mgmt_wkshop_vars.yml -vvv | tee ~/smrtmgmt01/deploy_logs/mgmtlab-deploy-$(date +%Y-%m-%d.%H%M).log
```
When you are ready to exit the python virtual env, deactivate the env
```
(smrtmgmt01) $ deactivate
$
```

**Teardown the workshop deployment**
```
$ cd ~
$ export PYVENV_PROJDIR="smrtmgmt01"
$ python3 -m pip venv $PYVENV_PROJDIR
$ source ~/$PYVENV_PROJDIR/bin/activate
(smrtmgmt01) $ cd ~/github/redhat-partner-tech/ansible-workshops
(smrtmgmt01) $ unbuffer ansible-playbook teardown_lab.yml -e @~/smrtmgmt01/deploy_vars/smart_mgmt_wkshop_vars.yml -e debug_teardown=true -vvv | tee ~/smrtmgmt01/deploy_logs/mgmtlab-teardown-$(date +%Y-%m-%d.%H%M).log
(smrtmgmt01) $ deactivate
$
```


