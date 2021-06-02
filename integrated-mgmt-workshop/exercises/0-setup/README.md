Integrated Management Workshop: Configuring the Lab Environment
==============================================================

Objective
---------
The objective of this exercise is to setup the lab environemnt. This exercise will require you to launch (5) playbooks. The playbooks accomplish the following:

-   Setup and configure Satellite with the proper lifecycle environments, content views, activation keys.
-   Populate Ansible Tower with an inventory source, add templates, as well as an additional project.
-   Publish RHEL7 dev content view in Satellite 
-   Register servers to the Satellite installation - RHEL7
-   Register servers to the Satellite installation - CentOS7

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
    ![](https://lh6.googleusercontent.com/1RmTzC-yEReCousl3x8N7YyxQFvOnCK76hmhVjCMePsSRbHA6GcXbIjoZI3hSxSCPmw7CF0JEgg0VXO_MlgIfFIV1oUbdBepyHGG0rKbHwx-ElNuhoyx4cS3OcSdX4ZLEsVSMRbW)
    - *Set SCM branch to "main"*
    - *Set the following SCM Update Options*
      - DELETE ON UPDATE
      - UPDATE REVISION ON LAUNCH
    - *Save*

#### 2\. Launch Ansible job templates

This step demonstrates the execution of job templates. You will be working with various templates as the workshop progresses, however, this step utilizes seven templates to initialize the lab environment configuration.

-   Two **Templates** named **SETUP / Satellite** and **SETUP / Tower** are the initial jobs templates you need to launch.

![](https://lh4.googleusercontent.com/kz6l-YuNoKknP6nX7nJTooAmVa91z4up4CoE6c2L2UW2cvJpaOaKXs9vVr62IPN8zA1Od5ADmsX-6K-PNEgKUzFiESAiFW0IqZae94Gd7rS1kt8qm_CrfWbAEHYoQ1FEsglCRFVL)

-   Select **Templates** and click ![](https://lh4.googleusercontent.com/gzrvCZUQ1OL1alwQW-3Qh4docaalU8LfaEYFYKw2xfXejbS9e6wan9oYMVrqPW9sUACav4GV8ChXdlFEzcb3XyeCh24HhHGCyEs-4iKHDJL8eYJTtuxV-9RB7LbXjQRWMp_jvLdE)to launch **SETUP / Satellite** job. When prompted be sure to change ```refresh_satellite_manifest: false```  to  ```refresh_satellite_manifest: true```


You will be taken to the **Jobs** dashboard where you will be able to follow each task executed as part of the playbook. This will take approximately 35 mins to complete.

> **NOTE** Please allow the **SETUP / Satellite** job to run to completion before proceeding to execution of the next template.

![](https://lh3.googleusercontent.com/WbOAiB0vNeUUT9on7xURXGfOwygQy1q9BuTpm2cQJqgmVW3GA_jbQjAOcIlTRD2JcgunpAhv-6735OQ2xOqt3CJb3e5kc7YaEM1i9IyI10Gh3_3gvRjHXFQZrJmf0LUwL1O-y7pB)

When complete, you will see a successful status as well as a play recap at the bottom of the screen.

Next you will need to run the **SETUP / Tower** job template. 

-   Select **Templates** and click on the![](https://lh4.googleusercontent.com/gzrvCZUQ1OL1alwQW-3Qh4docaalU8LfaEYFYKw2xfXejbS9e6wan9oYMVrqPW9sUACav4GV8ChXdlFEzcb3XyeCh24HhHGCyEs-4iKHDJL8eYJTtuxV-9RB7LbXjQRWMp_jvLdE)to launch.

![](https://lh4.googleusercontent.com/MGisqVAxZlFK4AP9RZ1YsNFv1QdqLr5Y53FAIjyZbsp7khmC9xLCZpDxvpgTMU2qj4jqEJCE-r-KIz6YqIaY2h-Iex4b0OZZ6qHJmpk4K6wW_amI1aWjUs7jzbSrnHN6co1oCMZS)

-   Navigate back to **Templates** on the left side pane.

The **SETUP / Tower** job will create multiple job templates that will be useful throughout the remainder of this workshop. 

![](https://lh4.googleusercontent.com/xy3fDRQ0LUC9SY1aHlk-hWwdDEDx-UH7nygw3cUb_8SQYSjGLeYpS5juGvl9CjSHB7MvJRShpOVOYMAUNPKfi5C6SPUXHWfGUjaMaax9enjWNS5nbpCM0Fai8hFb4QpJwZypNr4k)

Now that we have several more templates at our disposal we will need to run three more of these in order to complete setup.

Run the **SATELLITE / RHEL - Publish Content View** job template by clicking the![](https://lh4.googleusercontent.com/gzrvCZUQ1OL1alwQW-3Qh4docaalU8LfaEYFYKw2xfXejbS9e6wan9oYMVrqPW9sUACav4GV8ChXdlFEzcb3XyeCh24HhHGCyEs-4iKHDJL8eYJTtuxV-9RB7LbXjQRWMp_jvLdE)to launch. When prompted by the survey for the content view to publish, from the drop down menu, select **RHEL7**
-   Select **Next** to Launch the job template.

![](https://lh6.googleusercontent.com/KE_X9CneGR3P5gFh6qH9YSSO2SZpOvPFZAOOH5VndphvanoTbLtNntNmxouNR1llj8KzGQ5a7WrptVLV3XEbcLPBRme3DfkNhyHrY1RfZU-oDjfpl9sGPN2ixxJPMruwFWI3e7sh)

Next, run the **SERVER / RHEL7 - Register** job template by clicking the![](https://lh4.googleusercontent.com/gzrvCZUQ1OL1alwQW-3Qh4docaalU8LfaEYFYKw2xfXejbS9e6wan9oYMVrqPW9sUACav4GV8ChXdlFEzcb3XyeCh24HhHGCyEs-4iKHDJL8eYJTtuxV-9RB7LbXjQRWMp_jvLdE)to launch.

-   You will be presented with a survey. Fill this out as follows:

![](https://lh4.googleusercontent.com/DnlOvimZgX8NLFLrgF_loVlkmouWED1-g5BDS5kqDLPeyJvESWt6yY56GGWtCyhM2LVVpkI3D2CkZE7uTG1wD-YiULTCfZSUxxkZU5CilIzxxUNsEwuV1tGQ67Fz2mkONAlEcsgA)

-   Select **Next** to Launch the job template.

![](https://lh5.googleusercontent.com/4dJWGCBg3UYWvsrLMe36j19O2aC5DU2Fo3HW7fyFj8dTVwxrenYa7t7VvvyaXxIBMY4YRfcwL1z5yhZxIbBoe9eVd4o-q0AtpVArgQdMDmAqpV6w4zeDpbe2xobrQ23N4UIk-nlC)

![](https://lh4.googleusercontent.com/AvmmXeKsqMJY7UqF-YkXcc5f1MrdsyzmaRS3DhzDKGCjk33eJSKOmrCYQg-2C_EGb6y0IZdW2k5fTkLDvA4xQOotFbUpivtl3EAZr4vAMyNSaXSYpBtjPB8Woxoo8FuqvqmfxhMK)

Run the **SERVER / CentOS7 - Register** job template by clicking the![](https://lh4.googleusercontent.com/gzrvCZUQ1OL1alwQW-3Qh4docaalU8LfaEYFYKw2xfXejbS9e6wan9oYMVrqPW9sUACav4GV8ChXdlFEzcb3XyeCh24HhHGCyEs-4iKHDJL8eYJTtuxV-9RB7LbXjQRWMp_jvLdE)to launch.

-   You will be presented with a survey. Fill this out as follows:

![](https://lh6.googleusercontent.com/uCAS6XSZw_ySbF6v10vzgSSk50JIb4_CwnSEGpRcGpnMrxT7vvpUH9tNaewHm_Uo2Qn3L0lEKmjbw1WV3B3oMtMO8ffQ7sOwvEXGEckN9JCNhW8MCsW7uNGvypZo27x4c6BE98EW)

-   Select **Next** to Launch the job template.

![](https://lh5.googleusercontent.com/ohbhAl_wU1qzxVqMHwQnPOV02TpYKQIscd1pwgbWHvM4t7V80KttxHL0PPFl5L4H1ZZZcJqGrmgq_2EIE2bODH-HPEawZFJauqjvRogeStGxPn0j1BbONLJtqRRV6En-Fl2Dj7Wo)

![](https://lh5.googleusercontent.com/j9c1se4WyVKaM3O-nsaNNn7uLPpOpPM3mjMLSl1YzcwNfVWsZ3wDw-ipUA-RQgdJLCSkPAzyW6kvCJpEDeuoXZBgtyTs0dJ5GpfmbvaZJAfgP4RPPvDyc3w_4EaWAQBtTJrt_Nu4)

Run the **EC2 / Set instance tags based on Satellite(Foreman) facts** job template by clicking the![](https://lh4.googleusercontent.com/gzrvCZUQ1OL1alwQW-3Qh4docaalU8LfaEYFYKw2xfXejbS9e6wan9oYMVrqPW9sUACav4GV8ChXdlFEzcb3XyeCh24HhHGCyEs-4iKHDJL8eYJTtuxV-9RB7LbXjQRWMp_jvLdE)to launch.

![](https://lh3.googleusercontent.com/Yf90jgaCEAMMIuNSb011O4ERVnLkX9fZWx-u5Yb__EDpAsUyWnlkB8CKqiA6E-SMU5-gKEarM0Zv_Crcu7PMFujTT87MJnW0r8xDE1qWbY41eExFILWZt_1VaghLzjbff5yh0L87)

Run the **TOWER / Update inventories via dynamic sources** job template by clicking the![](https://lh4.googleusercontent.com/gzrvCZUQ1OL1alwQW-3Qh4docaalU8LfaEYFYKw2xfXejbS9e6wan9oYMVrqPW9sUACav4GV8ChXdlFEzcb3XyeCh24HhHGCyEs-4iKHDJL8eYJTtuxV-9RB7LbXjQRWMp_jvLdE)to launch.

-   You will be presented with a survey. Fill this out as follows:

![](https://lh4.googleusercontent.com/9UjqYL0nQ1RFXE78TH74XhNzjUwjE1Ykacdet6tNsOHK7dxgLqPd89xdpxNH-EWax7_FgcfyVvrHhRRd2KUSMAw0QeKBWF6Hgn3tOI5Q0ieITIw8oTil_-6znURdcHbPOLxcAuOH)

-   Select **Next** to Launch the job template.

Run the **TOWER / Update inventories via dynamic sources** job template by clicking the![](https://lh4.googleusercontent.com/gzrvCZUQ1OL1alwQW-3Qh4docaalU8LfaEYFYKw2xfXejbS9e6wan9oYMVrqPW9sUACav4GV8ChXdlFEzcb3XyeCh24HhHGCyEs-4iKHDJL8eYJTtuxV-9RB7LbXjQRWMp_jvLdE)to launch.

-   You will be presented with a survey. Fill this out as follows:

![](https://lh3.googleusercontent.com/GfcutEe2BcUlOSa1jYuMeFl_e7AmENRpRXLmaKfKhmYvfBdIOc7BoSzyBTmzukbYpkMGEgpEmsTAEikynb8Zot3Rmvn9wYiqMWfV3sDo8mDQpqfnRGmgdAdYOY_eXU624OgejcAq)

-   Select **Next** to Launch the job template.

Now, we can login to Satellite to perform verification.

#### 3\. Login to Satellite and validate your Environment

 ![](https://lh4.googleusercontent.com/xQc7AudiblHnV7vKVFv0_055wfoeODtDltSS1_C6yV_ppF3rmfN_B78dw-Lo-OvN2ey5aE20UkuxnqYPgtmwQ0pqDdXuHqZZ4yI1rV0_E8PaFeLJHBuTR2FngYQwtutxRzpOSrEe)

-   Use a web browser on your computer to access the Satellite GUI via the link found in the Environment above. And use the following username and password to login: *admin / <password_set_in_deploy_vars>*. Once you have logged in you will see the main Monitor page.

-   Click on **Hosts** -> **All Hosts** to validate that all six RHEL and CentOS server nodes are loaded into Satellite. 

![](https://lh6.googleusercontent.com/pUeAvPVvl3DeR_Y_9ZsFM3fj1JStBiOLI2SA-M967wepoYBAALwh2pHuRXs8bD5H6oT2DNSZBQOfE-CLh2-7n8B1oPeaFlv6yjbgThxAnSDAYPctYu1xXd667SyEzkqJFqC3S-ES)

-   Click on **Content** -> **Content Views** -> **RHEL7** to verify that all Dev, QA and Prod environments are accounted for.

![](https://lh4.googleusercontent.com/AWbPrWmlXnm6ALxRs45Q-7LGnyA9muQiM_wWRqBUcU3OUwg1c26OML0YGywUL_5eivJK7F5e1NlwCvKDrIBDr8qflTut1KNIUsOUuQgpl6dkpHJ3mFjsKh3sg01NP5CJYn3HHGQa)

#### 4\. End of exercise

-   You have finished this exercise
-   Continue to [Exercise 1: Compliance / Vulnerability Management](https://github.com/redhat-partner-tech/partner-tech-days-march2021/blob/main/integrated-mgmt-workshop/exercises/1-compliance/openscap-exercise.md), OR [Return to the main workshop page](https://github.com/redhat-partner-tech/partner-tech-days-march2021/tree/main/integrated-mgmt-workshop)
