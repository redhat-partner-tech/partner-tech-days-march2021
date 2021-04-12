Intergated Management Workshop: CentOS/RHEL migration and upgrade
-----------------------------------------------------------------
   (Work In Progress)
-----------------------------------------------------------------

**Introduction**<br>
This use-case will focus on conversion and migration from older CentOS versions to RHEL 8.3 (latest version as of Feb 2020). While we only show this process for a few systems, it can be scaled to a larger number of physical, virtual or cloud hosts using content repos provided by [Red Hat Satellite](https://www.redhat.com/en/technologies/management/satellite) (included in [Red Hat Smart Management](https://www.redhat.com/en/technologies/management/smart-management)). The upgrade process will be driven with automation built and run using [Ansible Automation Platform](https://www.redhat.com/en/technologies/management/ansible).

**Environment**
- Satellite 6.8, Ansible Automation Platform 2.9
- 2x CentOS 7 instances 
- 3x RHEL 7  instances

**Upgrade Scenario**
- Exercise: Convert CentOS 7 to RHEL 7, then upgrade to RHEL 8
    - Covers CentOS 7 to RHEL 7 conversion
    - RHEL 7 to RHEL 8 upgrade

Overview
-----------------------------------------------------------------

**Summary**<br>
- The first step involves making a backup of the instance data (in case of a fallback or restore is needed. Better safe than sorry.)
- Second, we will use a tool called Convert2RHEL. There are many sources of information on this handly utility, here are a few key ones:
    - [How to convert from CentOS or Oracle Linux to RHEL](https://access.redhat.com/articles/2360841) (Jan 2021)
    - [Converting from CentOS to RHEL with Convert2RHEL and Satellite](https://www.redhat.com/en/blog/converting-centos-rhel-convert2rhel-and-satellite) (March 2020)
    - [Convert2RHEL: How to update RHEL-like systems in place to subscribe to RHEL](https://www.redhat.com/en/blog/convert2rhel-how-update-rhel-systems-place-subscribe-rhel) (Jan 2020)
- Lastly, we will perform an in-place upgrade RHEL 7 to 8 (WIP)

Things to consider if doing this in dev/test/stage-beta/prod:
- Commercial and/or in-house developed application version(s) support with the host OS
- Bootloader changes
- Network connection and network time synchonizations


| **A Note about using Satellite vs. Ansible Automation Platform for this...**<br>  | 
| ------------- | 
| Out of the box, Satellite 6 supports [RHEL systems roles](https://access.redhat.com/articles/3050101) (a collection of Ansible Roles) for a limited set of administration tasks. An Ansible Automation Platform subscription is need to execute more complex Ansible jobs, such as OS conversions and upgrades. Using these two solutions together ensures you have the best tool for the job for:<br>- Content Management (Satellite)<br>- OS Patching & Standardized Operating Environments (Satellite)<br>- Provisioning: OS, Infra Services and Applications/Other (Satellite and/or Ansible Automation Platform)<br>- Configuration of Infra and Apps (Ansible Automation Platform)<br><br>Reference: [Scope of Support for Ansible Components included with Red Hat Satellite 6](https://access.redhat.com/articles/3616041) |


Ok, let's get started...  

Exercise:
-----------------------------------------------------------------
**Fork Automated Smart Management repo to individual GitHub account**
Before we begin, you'll need to fork the Automated Smart Management repo into your personal GitHub account.  If you do not have an individual GitHub account, you will need to create one to proceed. Utilization of a source code management (SCM) system is central to the "infrastructure as code" concepts put forth in this lab exercise, and in this case, GitHub is our SCM.

Once logged into [GitHub](https://github.com) navigate to the [Red Hat Partner Tech repo for Automated Smart Management](https://github.com/redhat-partner-tech/automated-smart-management) repo. Next, on the Automated Smart Management repo page, in the top, upper right of the page, click "Fork".  This will create a "forked" Automated Smart Management repo in your personal GitHub account.

[Switch to your cloned repo](https://github.com/your-github-username/automated-smart-management) and in the following files:

`group_vars/control/inventories.yml`

`group_vars/control/job_templates.yml`

`inventory/inventory_centos7_dev.aws_ec2.yml`

`inventory/inventory_rhel7_dev.aws_ec2.yml`

...make these edits (instructor will provide values):
- EC2_NAME_PREFIX ==> value of 'ec2_name_prefix' variable in workshop deployment vars file
- STUDENT_NAME_WITH_NUM ==> student name assigned to individual student, ie. student2 or student14
- WRKSHP_DNS_ZONE ==> value of 'workshop_dns_zone' variable in workshop deployment vars file

Note that in the file `refresh_route53_dns.yml` (student1 appears, DO NOT change)

The EC2 region primarily used is us-east-1 and this variable can be found throughout the repo as ==> ec2_region: us-east-1

If the workshop is deployed to some other region than us-east-1, change the region name to reflect where the the workshop is deployed.

**Login to your Satellite & AAP UI's**
- [Satellite 6.8 UI](https://www.example.com)
- [Ansible Automation Platform 2.9 UI](https://www.example.com)

**Steps:**<br>
1. Login to Ansible Tower, From the Dashboard main menu item, click [Hosts]
    - Here, you will see we have CentOS Nodes in Ansible Inventory

2. Switch "Automated Management" project to point to:
    - SCM URL: https://github.com/your-github-username/automated-smart-management.git
    - SCM BRANCH: main (if you didn't create a new branch to work with, otherwise, use branch name created)
    - Save and refresh project.

3. Edit template SETUP / Satellite and include "Workshop Credential" with "Satellite Credential"
    For extra_vars box:
    - add ==> refresh_satellite_manifest: no
    - check "PROMPT ON LAUNCH"
    - Save template

4. Run the first two SETUP job templates and Publish RHEL7_Dev CV
    - SETUP / Satellite **** NOTE!!! ***** change refresh_satellite_manifest: no to yes (this one takes a while, ~45-50 minutes)
    - SETUP / Tower
    - SATELLITE / RHEL - Publish Content View
      - env: Dev
      - Content View: RHEL7

5. Take CentOS node snapshot (or even RHEL nodes, too!)
    - template CONVERT2RHEL / 01 - Take node snapshot

6. Register RHEL7 nodes to Satellite
    - template SERVER / RHEL7 - Register
      - keep rhel7 limit on inventory group
      - server name or pattern: node
      - choose env: Dev

7. Register CentOS7 nodes to Satellite
    - template SERVER / CentOS7 - Register
      - keep centos7 limit inventory group
      - server name or pattern: node
      - choose env: Dev

8. Query Satellite to get node-related details, set EC2 instance tags based on these details
    - template EC2 / Set instance tags based on Satellite(Foreman) facts

9. Update inventories via dynamic sources
    - template TOWER / Update inventories via dynamic sources
	  - Select "CentOS7" for Inventory To Update
      - select "Dev" for Choose Environment

    - template TOWER / Update inventories via dynamic sources
	  - Select "RHEL7" for Inventory To Update
      - select "Dev" for Choose Environment

10. Upgrade CentOS nodes to latest
    - template CONVERT2RHEL / 02 - Upgrade OS to latest release

11. convert2rhel process
    - template CONVERT2RHEL / 03 - convert2rhel
      - choose LE group to convert CentOS7_Dev
      - choose LE target RHEL7_Dev
      - with some pre-config, any combo is possible

12. Query Satellite to get node-related details, set EC2 instance tags based on these details
    - template EC2 / Set instance tags based on Satellite(Foreman) facts

13. Refresh/update inventories
    - repeat step 9.

> **EXTRA CREDIT**: Create a workflow template incorporating the above standalone templates into a complete CentOS to RHEL conversion workflow!