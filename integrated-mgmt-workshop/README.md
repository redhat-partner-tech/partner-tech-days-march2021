Intergated Management Workshop: CentOS/RHEL migration and upgrade
-----------------------------------------------------------------

**Introduction**<br>
This use-case will focus on conversion and migration from older CentOS versions to RHEL 8.3 (latest version as of Feb 2020). While we only show this process for a few systems, it can be scaled to a larger number of physical, virtual or cloud hosts using content repos provided by [Red Hat Satellite](https://www.redhat.com/en/technologies/management/satellite) (included in [Red Hat Smart Management](https://www.redhat.com/en/technologies/management/smart-management)). The upgrade process will be driven with automation built and run using [Ansible Automation Platform](https://www.redhat.com/en/technologies/management/ansible).

**Environment**
- Satellite 6.8, Ansible Automation Platform 2.9
- 2x CentOS 7 instances 
- 2x RHEL 7  instances

**Upgrade Scenario**
- Exercise: Convert CentOS 7 to RHEL 7, then upgrade to RHEL 8
    - Covers CentOS 7 to RHEL 7 conversion
    - RHEL 7 to RHEL 8 upgrade

Overall Process
-----------------------------------------------------------------

**Summary**<br>
- The first step involves making a backup of the instance data (in case of a fallback or restore is needed. Better safe than sorry.)
- Second, we will use a tool called Convert2RHEL. There are many sources of information on this handly utility, here are a few key ones:
    - [How to convert from CentOS or Oracle Linux to RHEL](https://access.redhat.com/articles/2360841) (Jan 2021)
    - [Converting from CentOS to RHEL with Convert2RHEL and Satellite](https://www.redhat.com/en/blog/converting-centos-rhel-convert2rhel-and-satellite) (March 2020)
    - [Convert2RHEL: How to update RHEL-like systems in place to subscribe to RHEL](https://www.redhat.com/en/blog/convert2rhel-how-update-rhel-systems-place-subscribe-rhel) (Jan 2020)
- Lastly, we will perform an in-place upgrade RHEL 7 to 8

Things to consider if doing this in dev/test/stage-beta/prod:
- Commercial and/or in-house developed application version(s) support with the host OS
- Bootloader changes
- Network connection and network time synchoniztions


**A Note about using Satellite vs. Ansible Automation Platform for this...**<br>
Out of the box, Satellite 6 supports [RHEL systems roles](https://access.redhat.com/articles/3050101) (a collection of Ansible Roles) for a limited set of administration tasks [1]. An Ansible Automation Platform subscription is need to execute more complex Ansible jobs, such as OS conversions and upgrades. Using these two solutions together ensures you have the best tool for the job for:
- Content Management (Satellite)
- OS Patching & Standardized Operating Environments (Satellite)
- Provisioning (OS, Infra Services and Applications/Other (Satellite and/or Ansible Automation Platform)
- Configuration of Infra and Apps (Ansible Automation Platform)

[1, Scope of Support for Ansible Components included with Red Hat Satellite 6](https://access.redhat.com/articles/3616041)


Ok, now, let's get started...  

Exercise:
-----------------------------------------------------------------

**Login to your Satellite & AAP UI's**
- [Satellite 6.8 UI](https://www.example.com)
- [Ansible Automation Platform 2.9 UI](https://www.example.com)

Within the AAP UI, click on 'Hosts', then xxxx
You will see


