DRAFT:
======

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

-   Once you're in Tower you will be able to see a dashboard

#### 2\. Creating a new Patching Workflow

-   Now we will start configuring a workflow that encompasses publishing a content view, a fact scan, as well as a server patching.

-   Click "Templates" from the left side pane menu, and then click on the green + icon to create a "Workflow Template".

-   Create the name 'Satellite / Patching Workflow - Dev' and click save (there are no other options necessary to select on this page).

-   You are now presented with the WORKFLOW VISUALIZER. Select Start to add a node. From the drop-down menu select **Inventory Sync** and click on satellite_source. This sets up the inventory you will use in your workflow. You may leave the default remaining selections. Click the green SELECT button to finish.

-   Select Start again to add a second node. From the drop-down menu select template and click on 'Satellite / Publish Content View - RHEL'. A survey is attached to this template so you will need to select 'Prompt' at the bottom and select the correct content view for the servers we will patch. Select the RHEL7 content view. Click NEXT, then CONFIRM. Click the green SELECT button to finish. This step in the workflow adds your first job template which runs a playbook called 'satellite_publish.yml'

-   Hover over your 'Satellite' inventory node and select the green + icon to generate another node called Fact_Scan. Select **SERVER / Fact Scan - RHEL7** then click **SELECT** to finish. This is what will scan the nodes in our Satellite inventory to check for package updates and errata. 

-   Hover over the Publish Content View node and select the blue link icon. Then click on Server / Fact Scan. Click save to add the link. We will also need to set convergence for the Server / Fact Scan node. Select 'All' from the 'Convergence' drop-down menu. 

-   Next add another node by hovering over Server / Fact Scan and selecting the Server / Patch template. This template also has a survey attached. You will need to select 'Prompt and from the drop-down menu select the environment you would like to patch. Choose 'RHEL7_Dev'. The 'Check' drop-down is a selection that tells the server_patch whether or not to apply updates to the servers in our inventory. Since we want to apply the patches, we will select 'No'. Click 'Next' at the bottom of the window and them select 'Confirm'

-   You can now save and exit the workflow template.

#### 3\. Logging into Satellite 

-   Use a web browser on your computer to access the Satellite GUI via the link found in the Environment above

-   Once you're in Satellite, you'll be able to see a dashboard.

#### 4\. Exploring the Satellite host configuration

-   Hover over 'Hosts' and select 'Content Hosts'. Observe the multiple security, bug fix, enhancements and package updates available for each server. Further, take note of the life cycle environment 

-   Navigate to 'Content' and select 'Content Views'. Since the servers that we are working with are RHEL7 select the RHEL_7 content view. We need to publish a new content view version. Fortunately, we set that up as part of our workflow!

#### 5\. Navigate back to Ansible and let's launch the workflow job

-   Click on Templates to locate the Patching Workflow template. You can either click on the rocketship to the right of the template or select the template and select LAUNCH. (they do the same thing). 

-   Observe the job kicking off in Ansible. 

#### 6\. Navigate back to Satellite to examine smart automation

-   Click on 'Content' then 'Content Hosts' and select RHEL7. Notice the new content view version.

-   Navigate to Hosts > All Hosts and select node1.example.com. Select the 'content' tab under Details. Notice that the Installable errata has decreased. This indicates that we have applied our updates.

-   You'll notice that not all issues are remediated. This is to showcase that you can exclude updates based on type. In this case we're not pushing out updates for kernel changes. This can of course be configurable through use of the yum module in server patch

#### 7\. End Lab

-   You have finished the lab.
