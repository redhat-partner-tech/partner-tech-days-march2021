## Use Ansible to Provision Workshop on AWS

*The below instructions are steps that originated from:*<br>
*- https://github.com/ansible/workshops/tree/devel/provisioner*<br>



**Requirements:**
- RHEL 8 instance, registered using RHSM (We used a VM in this example)
- Active Satellite and Ansible Subscriptions
    - As a Red Hat Partner, you can obtain via NFR or eval/developer
- Active public domain name
- AWS Account
- DNS setup via AWS Route53 

**Setup DNS:** 
- You will need to setup DNS via AWS route53
- Use AWS Public Hosted zone
- Example: subdom.redhatpartnertech.net
- Reference: https://github.com/ansible/workshops/tree/devel/provisioner#dns

**Steps:**
OS Config -- Repo Setup + needed software tools install (including Ansible)

```
$ sudo subscription-manager register
$ sudo subscription-manager list --available
$ sudo subscription-manager remove --all
$ sudo subscription-manager attach --pool=8a85f99a72fe8d...
$ sudo subscription-manager list --consumed

$ sudo subscription-manager repos --disable=*
$ sudo subscription-manager repos --enable=rhel-8-for-x86_64-baseos-rpms --enable=rhel-8-for-x86_64-appstream-rpms --enable=ansible-2-for-rhel-8-x86_64-rpms
$ sudo subscription-manager repos --list-enabled

$ sudo dnf install vim git python3 expect ansible
```

Set default python version via alternatives for provisioner to utilize correct python runtime

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

$ python3 -m pip install --user --upgrade pip setuptools
$ python3 -m pip install --user wheel
$ python3 -m pip install --user boto boto3 netaddr passlib awscli
```

Create log and var directories and clone provisioner

```
$ mkdir -p ~/smrtmgmt01/deploy_logs
$ mkdir ~/smrtmgmt01/deploy_vars
$ mkdir -p ~/github/ansible
$ cd ~/github/ansible
$ git clone https://github.com/ansible/workshops.git

$ vim ~/smrtmgmt01/deploy_vars/smart_mgmt_wkshop_vars.yml
```
Please modify the following variables below to match your unique configuration.
- ec2_region: (a single ec2 region, ex. us-east-1; us-east-2)
- ec2_name_prefix: (a single unique name for your workshop, ex. smrtmgmt01; smrtmgmtvendor)
- admin_password: (a strong password 15+ characters, ex. Ansible=2021!!!)
- workshop_dns_zone: (setup in your route53 configuration, ex. subdom.redhatpartnertech.net)

All remaining variables LEAVE AS IS
```
---
# region where the nodes will live
ec2_region: us-east-1

# name prefix for all the VMs
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

# Sets the Route53 DNS zone to use for Amazon Web Services
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

# this will install VS Code web on all control nodes
code_server: true

# Enable AWS IAM integration with control(tower) node and workshop nodes
tower_node_aws_api_access: true
```

**Manifest**
- Login to https://access.redhat.com --> Subscriptions --> Subscription Allocations, then [New Subscription Allocation]
- Name it, then select type: Satellite 6.8, then click [Create]
- Once created, select the Subscriptions tab, then click [Add Subscriptions] to add # of Red Hat Ansible Automation subs
- Click [Export Manifest] to download .zip file, then move to provisioner VM
- On Provisioner VM, move zip file to default "provisioner" folder and rename<br>
```$ mv ~/manifest_sm-mgmt-wkshop_20210128T182529Z.zip ~/github/ansible/workshops/provisioner/manifest.zip```

**AWS Keys/Credentials - credentials file or via environment variables**
- [Walkthrough Steps](https://github.com/ansible/workshops/blob/devel/docs/aws-directions/AWSHELP.md)
- Reference: https://docs.aws.amazon.com/general/latest/gr/aws-access-keys-best-practices.html

**via credentials file**
```
$ cd ~/
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
$ aws ec2 describe-regions --region us-east-1
```

**Finally, run the provisioner**
```
$ cd ~/github/ansible/workshops/provisioner
$ unbuffer ansible-playbook provision_lab.yml -e @~/smrtmgmt01/deploy_vars/smart_mgmt_wkshop_vars.yml -vvv | tee ~/smrtmgmt01/deploy_logs/mgmtlab-deploy-$(date +%Y-%m-%d.%H%M).log
```

**Teardown**
```
$ cd ~/github/ansible/workshops/provisioner
$ unbuffer ansible-playbook teardown_lab.yml -e @~/smrtmgmt01/deploy_vars/smart_mgmt_wkshop_vars.yml -e debug_teardown=true -vvv | tee ~/smrtmgmt01/deploy_logs/mgmtlab-teardown-$(date +%Y-%m-%d.%H%M).log
```


