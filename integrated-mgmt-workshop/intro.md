Integrated Management Workshop: Introduction and setting up the lab environment
===============================================================================

In this part of the workshop, we will set up the lab environment. This is TBD

Environment
-----------

-   Red Hat Satellite v6.8

-   3 x Red Hat Enterprise Linux clients v7.9

Exercise
--------

#### 1\. Logging into the Ansible Automation Platform

-   Use a web browser on your computer to access the Ansible Tower GUI via the link found in the Environment above. And use the following username and password to login: admin / ansible123 

![](https://lh3.googleusercontent.com/qPZKoTY_llCgALI1Y4E1Y9jpXx9BPiLlcRoZeevtMfZnRq256WKil3RSbKa6RWgXd8Xkl9RZsAOvShmZISoGg1yvxZ2UIYfVMUUCnNnZix4xQF1GVBSa-TKktg1Mvb_W95lHgqiN)

-   Once you're in Tower you will be able to see a dashboard

#### 2\. Creating a new Project

-   Now we will start configuring an Ansible project. Under the 'Resource' heading select 'Projects' then select the green + to create a new project.

![](https://lh3.googleusercontent.com/RxrkFJh-s7P6vbiEuxn6gKojmyKZ-DQ_G_jaDnP5-UJjXAWn7dCRuTIcjmF0RFn0QS4cmv1UlTfLVjADwtP6bWECb-Vfm4sTodv_DRQ4_QqbBofphOsyR42mA576wyqCmhEHLhDC)

-   Fill out the details required to setup this project in Ansible Tower

-   NAME: Automated Smart Management

-   SCM TYPE: Git

-   SCM URL: <https://github.com/willtome/automated-smart-management>

-   SCM BRANCH: smart_mgmt

![](https://lh3.googleusercontent.com/oGrCPUY6H0Baa1Ycwik2J41nMrWEv9meRqLTJXC4qqwox91nZ4ZBXdIDIfWbj6-Ar3v3vtu9lPUgDu8Kx51Lj5u-rTTb5eCQ8HP-PSoKiGXEHYqoWwWFZWMukYnHhn8EAWhv1LRs)

-   You can now click save. *Note: The 'Automated Smart Management' project signal that with a green dot icon that it was able to retrieve the project from GIT.*

#### 3\. Create a Template in Ansible Tower.

This step demonstrates the creation of templates. You will be working with several templates as the workshop progresses but you will only need to focus on creating two templates as part of getting the lab environment setup.

-   Now we will start configuring an Ansible template. Under the 'Resource' heading select 'Templates' then select the green + to create a new template. Choose 'job template' from the selection.

![](https://lh4.googleusercontent.com/JgLSt5o5w8vSyw1wiYv-2Umwd6VC148TtE_Q_OECaTlO6QAQWHWTZJeydUclZI4V3jCX3qu6zN9TfwcM8xncWQjncuhK8QsMrXX0IDgl7JYDLLVIM3lbUtMBwgaePJ0imoYJpE1n)

-   Fill out the details required to setup your first template in Ansible Tower

-   NAME: Server_Register

-   JOB TYPE: Run

-   INVENTORY: Workshop Inventory

-   PROJECT: Automated Smart Management

-   PLAYBOOK: server_register.yml

-   CREDENTIALS: Workshop Credential

-   EXTRA VARIABLES: PREFIX: node

#### ![](https://lh3.googleusercontent.com/vVVoFVJniG-Nvx9nNpmXLqP2sVDBSMtKvifB9XL7PfUcfKYt977z0iz23eCrM7d7sBt85ijXMq74GBlk-C-QOIEhdZs9t9iXJ8Ac33Arxo-BJCoBi6D8LsksaUWsXHMAB-ZMHlrt)

-   You can now click save.

-   You will need to create another job template. Follow the same instructions above to draft a template with the following values

-   NAME: Configure_Satellite

-   JOB TYPE: Run

-   INVENTORY: Workshop Inventory

-   PROJECT: Automated Smart Management

-   PLAYBOOK: configure_satellite.yml

-   CREDENTIALS: Satellite *Note: You will need to select the credential type from the drop down menu at the top of the prompt. From there you can select 'Satellite'*

![](https://lh4.googleusercontent.com/sfrQ8HRnJkr1czup1rIfYrTOPRMLehQT2FDS0WysBKZ70clGud--kvzf-fhPJZBn7NeMDV6S0Z8CXWRz9JyVeUdChnPTrHNQvVsWVbp7KdC8h8VCTsCqNRlSY7DVlObKhTVg8x2P)

-   You can now click save. 

#### 4\. Launch jobs in Ansible using the Templates that you have created.

-   Select Templates and click on the ![](https://lh4.googleusercontent.com/gzrvCZUQ1OL1alwQW-3Qh4docaalU8LfaEYFYKw2xfXejbS9e6wan9oYMVrqPW9sUACav4GV8ChXdlFEzcb3XyeCh24HhHGCyEs-4iKHDJL8eYJTtuxV-9RB7LbXjQRWMp_jvLdE)to launch 'Configure_Satellite' Job.

This template is setting up a content view in Satellite. You can view this by clicking Content -> Content Views -> RHEL7

Further, this template configures foreman rake as well as creates lifecycle environments and their activation keys.

![](https://lh6.googleusercontent.com/rKJMG2Rh8l9Jk790n4xx2UJwqf4Zq8bekgBc-j8Ad5zG-bc6T2qkR8wPEe97QADGJtVvpqlxv0wCG2VYuSOK_QkyXIaox8V_riuvZdTn0HD-GtYDTJDWQoMeHhHGURbLpYmNgz0a)

When complete, you will see a successful status on Ansible Tower 'Job's

-   Next you will need to run the 'Server_Register' job. 

-   Select Templates and click on the ![](https://lh4.googleusercontent.com/gzrvCZUQ1OL1alwQW-3Qh4docaalU8LfaEYFYKw2xfXejbS9e6wan9oYMVrqPW9sUACav4GV8ChXdlFEzcb3XyeCh24HhHGCyEs-4iKHDJL8eYJTtuxV-9RB7LbXjQRWMp_jvLdE)to launch 'Server_' Job.

This template registers hosts in your inventory to Satellite, sets repositories, installs the katello agent, and registers subscription. *Note: You may see the job fail for a single node during register subscription mangler. This is expected and can be remediated by selecting the ![](https://lh4.googleusercontent.com/gzrvCZUQ1OL1alwQW-3Qh4docaalU8LfaEYFYKw2xfXejbS9e6wan9oYMVrqPW9sUACav4GV8ChXdlFEzcb3XyeCh24HhHGCyEs-4iKHDJL8eYJTtuxV-9RB7LbXjQRWMp_jvLdE)at the top of the job and relanching 'all failed'.

When complete, you will see a successful status on Ansible Tower 'Job's

![](https://lh4.googleusercontent.com/6iQlI_L8g3tuIvhSsP8pansIgMixWqt5MEaLgf2M_Fm8ho7TWr5vbPvx9H2ne6otjeD2QQhShczaa9JXSmhIuY9sz7uLtB0QF-sEYm-Z0IS9TSgEoSP3A-l-2mlTDA4jio2e6Rhf)

#### 5\. Login to Satellite and validate your Environment

![](https://lh4.googleusercontent.com/xQc7AudiblHnV7vKVFv0_055wfoeODtDltSS1_C6yV_ppF3rmfN_B78dw-Lo-OvN2ey5aE20UkuxnqYPgtmwQ0pqDdXuHqZZ4yI1rV0_E8PaFeLJHBuTR2FngYQwtutxRzpOSrEe)

-   Use a web browser on your computer to access the Ansible Tower GUI via the link found in the Environment above. And use the following username and password to login: admin / ansible123

-   Once you have logged in you will see a dashboard.

-   Click on Hosts -> All Hosts to validate that all three RHEL server nodes are loaded into Satellite. 

![](https://lh6.googleusercontent.com/_TeRjA3Yk4WUBTBz0XC7JTCSTVg8WKk_0mcFsWvQ59SB3KpxHzIWbGOxAVwvYgHg3onLuQDlhoEv7bcgRQQBCl9AhuZdfoWgHbVu_fMPxx4v9RJiAckvydwMQM_H37ucoYLfCO2D)

-   Click on Content -> Content Views -> RHEL7 to verify that all DEV, QA and Prod environments are accounted for.

![](https://lh4.googleusercontent.com/AWbPrWmlXnm6ALxRs45Q-7LGnyA9muQiM_wWRqBUcU3OUwg1c26OML0YGywUL_5eivJK7F5e1NlwCvKDrIBDr8qflTut1KNIUsOUuQgpl6dkpHJ3mFjsKh3sg01NP5CJYn3HHGQa)

#### 6\. End Lab

-   You have finished the lab.

  __ _       _     _     _
 / _(_)_ __ (_)___| |__ | |
| |_| | '_ \| / __| '_ \| |
|  _| | | | | \__ \ | | |_|
|_| |_|_| |_|_|___/_| |_(_)
