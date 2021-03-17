Integrated Management Workshop: Configuring the lab environment
==============================================================

Objective
---------

In this part of the workshop we will set up the lab environment. This exercise will require you to launch (4) pre-configured playbooks. 

-   Setup and configure Satellite with the proper lifecycle environments, content views, activation keys. 
-   Populate Ansible Tower with an inventory source, add templates, as well as an additional project.
-   Register servers to the Satellite installation - RHEL7
-   Register servers to the Satellite installation - CentOS

Environment
---------
* Ansible Automation Platform URL<br>
    * *Example: https://student1.smrtmgmt013.mw01.redhatpartnertech.net*
* Ansible Automation Platform login/password 
* Satellite URL<br> 
    * *Example: https://student1-sat.smrtmgmt013.mw01.redhatpartnertech.net (Note the -sat added to the URL)*
* Satellite login/password (same as above)



Exercise
--------

#### 1\. Logging into the Ansible Automation Platform (AAP)

-   Use a web browser on your computer to access the AAP GUI via the link found in the Environment above. And use the following username and password to login: *admin / <password_set_in_deploy_vars>* 

![](https://lh3.googleusercontent.com/qPZKoTY_llCgALI1Y4E1Y9jpXx9BPiLlcRoZeevtMfZnRq256WKil3RSbKa6RWgXd8Xkl9RZsAOvShmZISoGg1yvxZ2UIYfVMUUCnNnZix4xQF1GVBSa-TKktg1Mvb_W95lHgqiN)

-   Upon successful login, you will be able to see the Ansible Tower dashboard.

-   Use the side pane menu on the left to select **Projects** and review the two projects named **Automated Management** and **Fact Scan**. These projects, along with the Workshop Inventory (**Inventories** -> **Workshop Inventory**) have been set up for you during the provisioning of the lab environment.

- *Temporary Steps:* 
    - *From the navigation section on the left side of the Automation Platform homepage, select* ***Projects*** 
    - *Select the project named **Automated Management***
    - *Update the SCM URL to: https://github.com/redhat-partner-tech/automated-smart-management.git*
    - *Set SCM branch set to be blank*
    - *Save*

-   Two **Templates** named **SETUP / Satellite** and **SETUP / Tower** are also preconfigured. We will need to launch each of these.

![](https://lh4.googleusercontent.com/kz6l-YuNoKknP6nX7nJTooAmVa91z4up4CoE6c2L2UW2cvJpaOaKXs9vVr62IPN8zA1Od5ADmsX-6K-PNEgKUzFiESAiFW0IqZae94Gd7rS1kt8qm_CrfWbAEHYoQ1FEsglCRFVL)

#### 2\. Launch Ansible job templates

This step demonstrates the execution of job templates. You will be working with several templates as the workshop progresses but you will only need to focus on launching three templates as part of getting the lab environment setup.

-   Select **Templates** and click ![](https://lh4.googleusercontent.com/gzrvCZUQ1OL1alwQW-3Qh4docaalU8LfaEYFYKw2xfXejbS9e6wan9oYMVrqPW9sUACav4GV8ChXdlFEzcb3XyeCh24HhHGCyEs-4iKHDJL8eYJTtuxV-9RB7LbXjQRWMp_jvLdE)to launch **SETUP / Satellite** job.

You will be taken to the **Jobs** dashboard where you will be able to follow each task executed as part of the playbook. This will take approximately 25 mins to complete.

![](https://lh3.googleusercontent.com/L3sFy0yfpkcmKvUy1elRQIPbNM7XnCI1HgF5tzi6adwmfDDIbwAl864N0GGchTeGQV6sgCCr5ZoCMtXEKMr3hrEynmkpnMWrh5LtOGbXCxvHyruKbzLRLkhaKxCDa4owY_nnqhQw)

When complete, you will see a successful status as well as a play recap at the bottom of the screen.

-   Next you will need to run the **SETUP / Tower** job template. 

-   Select **Templates** and click on the![](https://lh4.googleusercontent.com/gzrvCZUQ1OL1alwQW-3Qh4docaalU8LfaEYFYKw2xfXejbS9e6wan9oYMVrqPW9sUACav4GV8ChXdlFEzcb3XyeCh24HhHGCyEs-4iKHDJL8eYJTtuxV-9RB7LbXjQRWMp_jvLdE)to launch.

![](https://lh4.googleusercontent.com/MGisqVAxZlFK4AP9RZ1YsNFv1QdqLr5Y53FAIjyZbsp7khmC9xLCZpDxvpgTMU2qj4jqEJCE-r-KIz6YqIaY2h-Iex4b0OZZ6qHJmpk4K6wW_amI1aWjUs7jzbSrnHN6co1oCMZS)

When complete, you will see a successful status as well as a play recap at the bottom of the screen.

-   Navigate back to **Templates** on the left side pane.

The **SETUP / Tower** job will create multiple job templates that will be useful throughout the remainder of this workshop. This includes the **SERVER / Register - RHEL7 template**. 

![](https://lh4.googleusercontent.com/xy3fDRQ0LUC9SY1aHlk-hWwdDEDx-UH7nygw3cUb_8SQYSjGLeYpS5juGvl9CjSHB7MvJRShpOVOYMAUNPKfi5C6SPUXHWfGUjaMaax9enjWNS5nbpCM0Fai8hFb4QpJwZypNr4k)

-   Run the **SERVER / Register - RHEL7** job template by clicking the![](https://lh4.googleusercontent.com/gzrvCZUQ1OL1alwQW-3Qh4docaalU8LfaEYFYKw2xfXejbS9e6wan9oYMVrqPW9sUACav4GV8ChXdlFEzcb3XyeCh24HhHGCyEs-4iKHDJL8eYJTtuxV-9RB7LbXjQRWMp_jvLdE)to launch.

-   You will be presented with a survey. Fill this out as follows:

-   Server Name or Pattern: node

-   Choose Environment: Dev

![](https://lh4.googleusercontent.com/DnlOvimZgX8NLFLrgF_loVlkmouWED1-g5BDS5kqDLPeyJvESWt6yY56GGWtCyhM2LVVpkI3D2CkZE7uTG1wD-YiULTCfZSUxxkZU5CilIzxxUNsEwuV1tGQ67Fz2mkONAlEcsgA)

-   Select **Next** to Launch the job template.

![](https://lh5.googleusercontent.com/4dJWGCBg3UYWvsrLMe36j19O2aC5DU2Fo3HW7fyFj8dTVwxrenYa7t7VvvyaXxIBMY4YRfcwL1z5yhZxIbBoe9eVd4o-q0AtpVArgQdMDmAqpV6w4zeDpbe2xobrQ23N4UIk-nlC)

![](https://lh4.googleusercontent.com/AvmmXeKsqMJY7UqF-YkXcc5f1MrdsyzmaRS3DhzDKGCjk33eJSKOmrCYQg-2C_EGb6y0IZdW2k5fTkLDvA4xQOotFbUpivtl3EAZr4vAMyNSaXSYpBtjPB8Woxoo8FuqvqmfxhMK)

Now, we can login to Satellite to perform verification.

#### 3\. Login to Satellite and validate your Environment

 ![](https://lh4.googleusercontent.com/xQc7AudiblHnV7vKVFv0_055wfoeODtDltSS1_C6yV_ppF3rmfN_B78dw-Lo-OvN2ey5aE20UkuxnqYPgtmwQ0pqDdXuHqZZ4yI1rV0_E8PaFeLJHBuTR2FngYQwtutxRzpOSrEe)

-   Use a web browser on your computer to access the Satellite GUI via the link found in the Environment above. And use the following username and password to login: *admin / <password_set_in_deploy_vars>*

-   Once you have logged in you will see the main Monitor page.

-   Click on **Hosts** -> **All Hosts** to validate that all three RHEL server nodes are loaded into Satellite. 

![](https://lh6.googleusercontent.com/_TeRjA3Yk4WUBTBz0XC7JTCSTVg8WKk_0mcFsWvQ59SB3KpxHzIWbGOxAVwvYgHg3onLuQDlhoEv7bcgRQQBCl9AhuZdfoWgHbVu_fMPxx4v9RJiAckvydwMQM_H37ucoYLfCO2D)

-   Click on **Content** -> **Content Views** -> **RHEL7** to verify that all Dev, QA and Prod environments are accounted for.

![](https://lh4.googleusercontent.com/AWbPrWmlXnm6ALxRs45Q-7LGnyA9muQiM_wWRqBUcU3OUwg1c26OML0YGywUL_5eivJK7F5e1NlwCvKDrIBDr8qflTut1KNIUsOUuQgpl6dkpHJ3mFjsKh3sg01NP5CJYn3HHGQa)

#### 4\. Register CentOS nodes to Satellite

- Now, run the **SERVER / Register - CENTOS7** job template (similar to **SERVER / Register - RHEL7** job in above Step 2)
- Repeat Step 3 to verify CentOS 7 nodes are now registered/added to Satellite

#### 5\. End of exercise

-   You have finished this exercise
-   Continue to [Exercise 1: Compliance / Vulnerability Management](https://github.com/redhat-partner-tech/partner-tech-days-march2021/blob/main/integrated-mgmt-workshop/exercises/2-compliance/openscap-exercise.md), OR [Return to the main workshop page](https://github.com/redhat-partner-tech/partner-tech-days-march2021/tree/main/integrated-mgmt-workshop)
