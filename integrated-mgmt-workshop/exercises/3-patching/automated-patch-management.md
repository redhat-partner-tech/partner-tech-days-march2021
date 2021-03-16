Integrated Management Workshop: Automating Patch Management
===========================================================

In this part of the workshop, we will learn how to leverage the use of workflows in Ansible Tower to orchestrate patch management for several linux servers . Automating patch management reduces human error and improves configuration and patch accuracy. Additionally, automation provides capabilities to reduce the manual input associated with identifying, testing and patching systems. 

Environment
-----------

-   Red Hat Satellite v6.8

-   3 x Red Hat Enterprise Linux clients v7.9

-   2 x CentOS v7.8

Pre-requisites 
---------------

-   Exercise 0 : Lab Setup

-   Organization to be used = Default Organization

-   Location to be used = Default Location

-   A content view = RHEL7

-   Lifecycle environments = Dev, QA, Prod

-   SSH access to RHEL clients (node1, node2, node3) which has been registered to Satellite

Exercise
--------

#### 1\. Logging into the Ansible Automation Platform

-   Use a web browser on your computer to access the Ansible Tower GUI via the link found in the Environment above. And use the following username and password to login: admin / ansible123

![](https://lh5.googleusercontent.com/EBIf_BZxQc4PRn7QSESaQ5Z9sJ3HBMWCBMi-emrz421t_RF7puh2Evrhblke3i9cUEH6fkqWdKvTgvmHB5oWUGkDT2D8Cs65FIdpTf_si9bg_nbqEvLQjV4vWB3Ui-JCDbyyDXII)

-   Once you're in Tower you will be able to see a dashboard

![](https://lh6.googleusercontent.com/eMeUqr6L3P_O-YjRDLfxJ5FSKze9wypgTW9gbotRkU1wjBrZ7O8NGAxZ86yvTsb6yuc8BeMqCGSy0RUeRSKyD7U2C1yHkp86kDTARExzcMz-7MgQGpJMnMp__iOYZi2hObQyPNUK)

#### 2\. Creating a new Patching Workflow

-   Now we will start configuring a workflow that encompasses publishing a content view, promoting a content view, a fact scan, as well as a server patching. The goal is to publish a new content view and promote our rhel7_DEV environment to QA.

-   Start by clicking "Templates" from the left side pane menu, and then click on the GREEN +  icon to create a "Workflow Template".

-   Create the name "Satellite / Patching Workflow" and click save (there are no other options necessary to select on this page).

-   From the template, select the blue 'Workflow Visualizer' button to start creating your workflow. This will open a blank workflow.

![](https://lh5.googleusercontent.com/9-aMtjHlxDWDbBuudPzmzk5GSOB1yfHE7BEHOQTmKZnam-bwDUmQEwVQ_wzYWYZEicuMS0TH7M2KmNkfJ0L9I8ZG9POVpmXBoaTkNhmw3AzDMJvDg4sIUFcTDUT92MNzoEl56QFF)

-   Select Start to add a node. From the drop-down menu select inventory sync and click on "satellite_source". This sets up the inventory you will use in your workflow. You may leave the default remaining selections and click 'select'

-   Select Start again to add a second node. From the drop-down menu select template and click on 'Satellite / Publish Content View'. A survey is attached to this template so you will need to select 'prompt' at the bottom and select the correct content view for the servers we will patch. Select the 'RHEL7' content view and click 'next'. You will then need to 'confirm' the preview.

This step in the workflow adds your first job template which runs a playbook called 'satellite_publish.yml'

-   Add another node to the workflow by hovering over your 'satellite_source' inventory node and select the GREEN + icon to generate another node called 'Server / Fact Scan'. This is what will scan the nodes in our Satellite inventory to check for package updates and errata.

At this point your workflow should resemble the following:

![](https://lh5.googleusercontent.com/cus0Z_VD33f_uFiOEdzD9aFY1g9OoLTqnZ8MAvo_2wvlUJ0ZvtFHE_-1wQZI4Xj5xGtypizrbqOTLBiXsN8U41lL7B4qDnIznkgWAQsxKWrqVgqgD6ZUFPEzueUU0fP106UpHL5A)

-   There are two more nodes to add to this workflow.  Hover the Publish Content View node and select the GREEN +. Then click on 'Satellite / Promote Content View'. There is a survey attached that requires variables for content view, current lifecycle environment, and next lifecycle environment. For the purpose of this lab we're going to promote Dev to QA. 

-   Select RHEL7 for 'Content View'

-   Select RHEL7_Dev for 'Current Lifecycle Environment'

-   Select RHEL7_QA for 'Next Lifecycle Environment'

                       Click 'next'. You will then need to 'confirm' the preview.

-   Add the last node by hovering over 'Satellite / Promote Content' and selecting the GREEN +. Then click on 'Server / Patch' template. This template also has a survey attached. You will need to select 'Prompt' and from the drop-down menu select the environment you would like to patch. Choose 'RHEL7_Dev'. The 'Check' drop-down is a selection that tells server_patch.yml whether or not to apply updates to the servers in our inventory. Since we want to apply the patches, we will select 'No'. Click 'Next' at the bottom of the window and them select 'Confirm'. Click 'select' from the menu on the right to save the node.

-   Before we can finish the workflow we need to link 'Server / Fact Scan' to 'Server / Patch' and coverage on success. Hover over 'Server / Fact Scan' and click on the BLUE chain icon. Then click to the right of the 'Server / Patch' node to link. You will be promoted on the right side pane menu to to Run 'On Success'. Click 'Save'

Your workflow should resemble the following:

![](https://lh4.googleusercontent.com/Jm7pLtYP-HmZJ8HhT19IbvAklenw6MNJZBhBwl-7BuAExJj4S2p8Z-LlhGzUuSbVP529YTMZPuBvpUXnVFoo5yoix2GOqnKSEEajowTLzNXtYsMue6Mq6Jh8rRXA7nKKstPr0QOM)

You can now save and exit the workflow template.

#### 3\. Logging into Satellite 

-   Use a web browser on your computer to access the Satellite GUI via the link found in the Environment above

![](https://lh5.googleusercontent.com/7Bt_ynJlxhLW9GKz-OmDVSMrB2WJLg8q9ZcKu4p-JoKmY3U5GFrgZOoFlhROuN7EeRM2uBwxyuNMLn4qfHuvUk-p0eMiXPfhV73YsMRdHrgiS8yu_RUnfmntOTAbvXOWJfQfzOZc)

-   Once you're in Satellite, you'll be able to see a dashboard.

![](https://lh4.googleusercontent.com/haE5LMLOZpytAxs9Jk0AQRYRMeF5I-YRFIw-2oeS5H7jeMDFi5cNn6UHBc3z39w6CZrwNskZuIFCub6c4QPwPCBZS59NxTv18Ydt7M2iA8x1sch8g35h8E7686BUsXiVaDITcEC7)

#### 4\. Exploring the Satellite host configuration

-   Hover over 'Hosts' and select 'Content Hosts'. Observe the multiple security, bug fix, enhancements and package updates available for each server. Further, take note of the life cycle environment 

![](https://lh4.googleusercontent.com/dvuXHm8c3VJkstDuDQmIynABPWpe2ne8wklZOsJBJogBhCyI-otxwNlUm6IpV6idRst5YhwO0-ftnFDQdy-OmmxCoSd2KpIu5OhZckya3U4eolhQchKpRoH0n7diiPOIZPngl3NW)

-   Navigate to 'Content' and select 'Content Views'. Since the servers that we are working with are RHEL7 select the 'RHEL_7' content view. We need to publish a new content view version. Fortunately, we set that up as part of our workflow! (Note: your content view version may differ from this example, that is OK)

![](https://lh6.googleusercontent.com/T5Df-Qo6GcSaUapZoZ5hsr92KWFlEMWtRs4XmuiJQUAcAISsD27D7GqJ9nmM5wOZHFpNylkWNGRZZaGFHSlJEKlCKxBAQlULxdigYXUAVvfG_pUQumnElyIOfNBkDrn50N6m4VTh)

#### 5\. Navigate back to Ansible and let's launch the workflow job

-   Click on Templates to locate the Patching Workflow template. You can either click on the rocketship to the right of the template or select the template and select LAUNCH. (they do the same thing). 

-   Observe the job kicking off in Ansible. 

![](https://lh4.googleusercontent.com/zYbow9VVhN6NbKBG24TVuaEZZficvaRDYeluLqdA73LSo-VpTdW-iQosnYxb_HGZpuZDIrFlrpwdChXn-utl-Nk3LZbWBOHKqGDaeZwIsu2S5gNEFPFyGPwgieKNqhMGfoEE3duc)

#### 6\. Navigate back to Satellite to examine smart automation

-   Click on 'Content' then 'Content Hosts' and select RHEL7. Notice the new content view version.

-   Navigate to Hosts > All Hosts and select node1.example.com. Select the 'content' tab under Details. Notice that the Installable errata has decreased. This indicates that we have applied our updates.

![](https://lh5.googleusercontent.com/IUBqdqDxA_NyUeWD8eI1gpVqwvKOg4hePvjJ1kbR9aMBzjq-raodXeopzRLU90Unn6qsDJ2erV2CCQxCLPyJIPKeSaVTI7CvfpG1oLz2RUY0GIbpPMYd6Ed5PIfdjpwViLNQ1Xe9)

-   You may notice that not all issues are remediated. This is to showcase that you can exclude updates based on type. In this case we're not pushing out updates for kernel changes. This can of course be configurable through use of the yum module in server patch

![](https://lh6.googleusercontent.com/jf_aZVIk4hNCVKM4Nb49q_OLO18VAWPDcGtJVPaWr8mjosjbw7NjnrLm4r4Jbg2AmQlmCR3EuqKKEFM5LOFKhFspao_65_heKRAmgVkEKjgQhFUO2a6WREkztjpXSzqsLxS9gkoX)

#### 7\. End Lab

-   You have finished the lab.
