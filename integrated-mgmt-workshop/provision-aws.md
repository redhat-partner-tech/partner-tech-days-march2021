## Use Ansible to Provision Workshop on AWS

*The below instructions are steps that originated from:*<br>
*- https://github.com/ansible/workshops/tree/devel/provisioner*<br>



**Requirements:**
- System with git, python3, expect(unbuffer utility)
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
$ python3 -m venv $PYVENV_PROJDIR
$ source ~/$PYVENV_PROJDIR/bin/activate
(smrtmgmt01) $ python3 -m pip install --upgrade pip setuptools
(smrtmgmt01) $ python3 -m pip install wheel
(smrtmgmt01) $ python3 -m pip install ansible-core==2.11.5 \
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
(smrtmgmt01) $ mkdir -p ~/github/ansible
(smrtmgmt01) $ cd ~/github/ansible
(smrtmgmt01) $ git clone https://github.com/ansible/workshops.git

(smrtmgmt01) $ vim ~/$PYVENV_PROJDIR/deploy_vars/smart_mgmt_wkshop_vars.yml
```
Please modify the following variables below to match your unique configuration.
- ec2_region: (a single ec2 region, ex. us-east-1; us-east-2)
- ec2_name_prefix: (a single unique name for your workshop, ex. smrtmgmt01; smrtmgmtvendor)
- provision_mode: `workshop` or `playground` (`workshop` completes Satellite IAC roll out; products, repos, CV, LE, Act Keys, manifest publishing, etc. takes longer to deploy, however, saves major time for workshop attendees because it's already completed prior to beginning exercises)
- offline_token: token to authenticate calls to Red Hat's APIs, generate token at https://access.redhat.com/management/api
- redhat_username / redhat_password: Red Hat account name and password, used for authorized access to registry.redhat.io
- admin_password: (a strong password 15+ characters, ex. Ansible=2021!!!)
- workshop_dns_zone: (setup in your route53 configuration, ex. subdom.redhatpartnertech.net)


All remaining variables LEAVE AS IS!!!
```
---
# region where the nodes will live
ec2_region: us-east-2

# name prefix for all the VMs
ec2_name_prefix: smrtmgmt01

# creates student_total of workbenches for the workshop
student_total: 1

# Set the right workshop type, like network, rhel or f5...or smart_mgmt :)
#workshop_type: rhel
workshop_type: smart_mgmt
#workshop_type: windows

# workshop or playground
provision_mode: workshop

# Generate offline token to authenticate the calls to Red Hat's APIs
# 
offline_token: "eyJhbGci...9Kx7DU"

# Required for podman authentication to registry.redhat.io
redhat_username: myredhatacct@redhat.com
redhat_password: Xtr4Sup3rS3cr3tP4ssw0rd?!

#####OPTIONAL VARIABLES

# turn DNS on for control nodes, and set to type in valid_dns_type
dns_type: aws

# Sets the Route53 DNS zone to use for Amazon Web Services
workshop_dns_zone: subdom.redhatpartnertech.net

# password for Ansible control node
admin_password: Ansible=2021!!!

# install control node
controllerinstall: true

# IBM Community Grid - defaults to true if you don't tell the provisioner
ibm_community_grid: false

# select rhel7 or rhel8 client nodes
rhel: rhel7
# choice of centos7 nodes
# refer to https://wiki.centos.org/Cloud/AWS for available minor releases
# select centos7 client node version
centos7: centos78

# deploy HA Ansible Tower cluster
#create_cluster: false

# Install automation hub node?
automation_hub: false

# this will install VS Code web on all control nodes
code_server: false

# this will change the location of lab guide
# ansible_workshops_url: https://github.com/ansible/workshops
# ansible_workshops_version: smart_mgmt

# Enable AWS IAM integration with control node and workshop nodes
tower_node_aws_api_access: true

# default vars for ec2 AMIs (ec2_info) are located in:
# provisioner/roles/manage_ec2_instances/defaults/main/main.yml
# select ec2_info AMI vars can be overwritten via ec2_xtra vars, e.g.:
#ec2_xtra:
#  satellite:
#    owners: 012345678910
#    filter: Satellite*
#    username: ec2-user
#    os_type: linux
#    size: r5a.xlarge
```

**Manifest**
- Login to https://access.redhat.com --> Subscriptions --> Subscription Allocations, then [New Subscription Allocation]
- Name it, then select type: Satellite 6.8, then click [Create]
- Once created, select the Subscriptions tab, then click [Add Subscriptions] to add # of Red Hat Ansible Automation subs
- Click [Export Manifest] to download .zip file
- Move zip file to "workshops/provisioner" folder and rename<br>
`$ mv ~/manifest_sm-mgmt-wkshop_20210128T182529Z.zip ~/github/ansible/workshops/provisioner/manifest.zip`

**Test AWS Credentials**
```
(smrtmgmt01) $ aws sts get-caller-identity
```
or
```
(smrtmgmt01) $ aws ec2 describe-regions --region us-east-1
```

**Build Ansible workshops provisioner collection**
```
(smrtmgmt01) $ cd ~/github/ansible/workshops
(smrtmgmt01) $ ansible-galaxy install --force -r requirements.yml
(smrtmgmt01) $ ansible-galaxy collection build --verbose --output-path build/
(smrtmgmt01) $ ansible-galaxy collection install --verbose build/*.tar.gz
```

**Finally, set some related environment variables and run the provisioner via ansible-playbook**
```
(smrtmgmt01) $ ANSIBLE_CONFIG=provisioner/ansible.cfg
(smrtmgmt01) $ AWS_MAX_ATTEMPTS=10
(smrtmgmt01) $ AWS_RETRY_MODE=standard
```
> **NOTE**: Utilizing `unbuffer` utility to handle `ansible-playbook` is not required, however, provides a convenient method to monitor console while simultaneously writing to log file
```
(smrtmgmt01) $ unbuffer ansible-playbook ./provisioner/provision_lab.yml -e @~/$PYVENV_PROJDIR/deploy_vars/smart_mgmt_wkshop_vars.yml | tee ~/$PYVENV_PROJDIR/deploy_logs/mgmtlab-deploy-$(date +%Y-%m-%d.%H%M).log
```

Unfamiliar with Python virtual environments (venv)?  Remember, the Python venv was "activated" earlier in the process via this command:
* `$ source ~/$PYVENV_PROJDIR/bin/activate`

"Step out" of the venv by deactivating it:
```
(smrtmgmt01) $ deactivate
$
```

**Teardown**
> **NOTE**: If you exited the Python venv for other tasks and need to return later to teardown the lab environment, activate the project venv and proceed.
```
$ export PYVENV_PROJDIR="smrtmgmt01"
$ source ~/$PYVENV_PROJDIR/bin/activate
(smrtmgmt01) $ cd ~/github/ansible/workshops
(smrtmgmt01) $ ANSIBLE_CONFIG=provisioner/ansible.cfg
(smrtmgmt01) $ AWS_MAX_ATTEMPTS=10
(smrtmgmt01) $ AWS_RETRY_MODE=standard
(smrtmgmt01) $ unbuffer ansible-playbook teardown_lab.yml -e @~/$PYVENV_PROJDIR/deploy_vars/smart_mgmt_wkshop_vars.yml -e debug_teardown=true | tee ~/$PYVENV_PROJDIR/deploy_logs/mgmtlab-teardown-$(date +%Y-%m-%d.%H%M).log
(smrtmgmt01) $ deactivate
$
```
