Exercise: CentOS/RHEL migration and upgrade
-----------------------------------------------------------------

From an overall process perspective, we start with converting CentOS 7 to RHEL 7, then upgrading to RHEL 8. While this will be done in the exercise in an easy, automated fashion, let's walkthrough the process.

- The first step involves making a backup of the instance data (in case of a fallback or restore is needed. Better safe than sorry.)
- Second, we will use a tool called Convert2RHEL. There are many sources of information on this handly utility, here are a few key ones:
    - [How to convert from CentOS or Oracle Linux to RHEL](https://access.redhat.com/articles/2360841) (Jan 2021)
    - [Converting from CentOS to RHEL with Convert2RHEL and Satellite](https://www.redhat.com/en/blog/converting-centos-rhel-convert2rhel-and-satellite) (March 2020)
    - [Convert2RHEL: How to update RHEL-like systems in place to subscribe to RHEL](https://www.redhat.com/en/blog/convert2rhel-how-update-rhel-systems-place-subscribe-rhel) (Jan 2020)
- Lastly, we will perform an in-place upgrade RHEL 7 to 8

Sounds easy? But there are some things to consider
- Commercial and/or in-house developed application version(s) support with the host OS
- Bootloader changes
- Network connection and network time synchoniztions


**A Note about using Satellite vs. Ansible Automation Platform for this...**
bluerb

Let's get started...  

===

**Login to your Satellite & AAP UI's**
- [Satellite 6.8 UI](https://www.example.com)
- [Ansible Automation Platform 2.9 UI](https://www.example.com)

Within the AAP UI, click on 'Hosts', then xxxx
You will see





