## Provision

***The below instructions are steps that originated from:***<br>
*- https://github.com/ansible/workshops/tree/devel/provisioner*<br>
*- https://github.com/ansible/workshops/blob/devel/docs/setup.md*


**Requirements:**
- RHEL 8 instance, registered using RHSM (We used a VM in this example)
- Active Satellite and Ansible Subscriptions
    - As a Red Hat Partner, you can obtain via NFR or eval/developer
- Active public domain name
- DNS setup via AWS Route53 

**Steps:**
 
OS Config -- Repo Setup + needed software tools install (including Ansible)
```
# subscription-manager register
# subscription-manager list --available
# subscription-manager remove --all
# subscription-manager attach --pool=8a85f99a72fe8ddb017305ae33c15130
# subscription-manager list --consumed

# subscription-manager repos --disable=*
# subscription-manager repos --enable=rhel-8-for-x86_64-baseos-rpms --enable=rhel-8-for-x86_64-appstream-rpms --enable=ansible-2-for-rhel-8-x86_64-rpms
# subscription-manager repos --list-enabled

# dnf install vim git python3 expect ansible
# pip3 install boto boto3 netaddr passlib 

# mkdir /root/smrtmgmt01/deploy_logs
# mkdir /root/smrtmgmt01/deploy_vars
# mkdir /root/github
# mkdir /root/github/ansible
# cd /root/github/ansible
# git clone https://github.com/ansible/workshops/
# cd workshops/
# git checkout smart_mgmt
 
# vim /root/smrtmgmt01/deploy_vars/smart_mgmt_wkshop_vars.yml
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
admin_password: redhat!!

# Sets the Route53 DNS zone to use for Amazon Web Services
workshop_dns_zone: mw01.redhatpartnertech.net

# automatically installs Tower to control node
towerinstall: true
create_cluster: false
ansible_workshops_url: https://github.com/ansible/workshops
ansible_workshops_version: smart_mgmt

# IBM Community Grid - defaults to true if you don't tell the provisioner
ibm_community_grid: false
```

**Setup DNS** 
- You will need to setup DNS via AWS route53
- Use AWS Public Hosted zone
- Example: mw01.redhatpartnertech.net
- Reference: https://github.com/ansible/workshops/tree/devel/provisioner#dns

**Manifest**
- Login to https://access.redhat.com --> Subscriptions --> Subscription Allocation
- Satellite 6.8, added # of Ansible subs, download .zip, move to provisioner VM
- Then on Provisioner VM, move zip file to default "provisioner" folder and rename
```# mv /home/mikew/manifest_sm-mgmt-wkshop_20210128T182529Z.zip /root/github/will/workshops/provisioner/manifest.zip```

**AWS Keys/Credentials**
- [Walkthrough Steps](https://github.com/ansible/workshops/blob/devel/docs/aws-directions/AWSHELP.md)
- Reference: https://docs.aws.amazon.com/general/latest/gr/aws-access-keys-best-practices.html
```# cd ~/
# mkdir .aws
# cd .aws
# vim credentials 
# cat credentials
[default]
aws_access_key_id = AKIAIDA7I6XT....
aws_secret_access_key = GP7nC7Oq+tP8akFWqO....

#
```

**AWS CLI setup**
```
# which python3
        # python3 -m pip --user install awscli (use this to install as a "user")
# python3 -m pip install awscli
# aws s3 ls (to test that AWS Credentials are setup correctly above)
```
***** Set python correctly for provisioner to run right *****
```
# which python
/usr/bin/which: no python in (/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin)
# alternatives --list | grep -i python
python              	auto  	/usr/libexec/no-python
python3             	auto  	/usr/bin/python3.6
# alternatives --set python /usr/bin/python3
# alternatives --list | grep -i python
python              	manual	/usr/bin/python3
python3             	auto  	/usr/bin/python3.6
# python --version
Python 3.6.8
```

**Finally, run the provisioner**
```
# cd /root/github/will/workshops/provisioner
# unbuffer ansible-playbook provision_lab.yml -e @/root/deploy_vars/smart_mgmt_wkshop_vars.yml -vvv | tee /root/deploy_logs/mgmtlab-deploy-$(date +%Y-%m-%d.%H%M).log
```

**Teardown**
```
# cd /root/github/will/workshops/provisioner
# unbuffer ansible-playbook teardown_lab.yml -e @/root/deploy_vars/smart_mgmt_wkshop_vars.yml -e debug_teardown=true -vvv | tee /root/deploy_logs/mgmtlab-teardown-$(date +%Y-%m-%d.%H%M).log
```


