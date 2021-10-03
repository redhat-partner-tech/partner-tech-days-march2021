Automated Smart Management Workshop: Managing Additional Software with Satellite
--------------------------------------------------------------------------------

In this part of the workshop, we will learn how to manage extra/additional software with Satellite. When you have RHEL clients managed by Satellite in your environment, often there is also a requirement to manage additional software packages that don't come from any of the RHEL distributions/repositories. For example, the Creative department wanted you to manage a CAD/CAM software that runs on many of their RHEL workstations. Satellite has the ability to manage other software packages on top of what comes with Red Hat subscriptions.

## Environment

-   Satellite 6.8, Ansible Automation Platform 4.0.0

-   3 x Red Hat Enterprise Linux clients

## Pre-requisites

-   Organization to be used = Default Organization

-   Location to be used = Default Location

-   Lifecycle environments = RHEL7_Dev, RHEL7_QA, RHEL7_Prod

## Exercise

#### 1\. Logging in to Satellite

-   Use a web browser on your computer to access the Satellite GUI via the link found in the Environment above.

![](https://lh3.googleusercontent.com/E7feHyVF0hUr0ySyPm12NTdVZuLqSxVeRg30JZ63XorJSVAnOZDfGrW8h4f9xvStN9gp_Sx48ArGaThHSFuG9PcQsSdjqS7KDrpZ3OhkpqnLQ_RNsgTxVglJk90LNZfG2QLk6ULK)

-   Once you're in Satellite you would be able to see a dashboard

![](https://lh5.googleusercontent.com/g22VsrKilxepC3DSpw-tGWM9YOFHfrH2z8GRmwj6s_0369aX9JhXY0K2YGBI13mM7xB1CiWAOLg1CbQrNchNsWZsUgDBO3bNd9J_3bF5dQO0A1GztjMyVNx1OUrLM5STVk50Wx1a)

#### 2\. Set Organization and Location

-   Ensure that you select "Default Organization" as the Organization and "Default Location" as the location, by clicking on the menu on top of the page

![](https://lh3.googleusercontent.com/JBbWFK5lF_cgtCzCbzONkCJzQfXRMYpXyOcqVrrkflzlxjQUuw8seO_JJu7VBo3-yV0PSELR8-gAgdRvUeVcgDONhS_qGQhgdqY9-2129AdweJY7SCdB26XhnledDfu24TkY2z2l)

#### 3\. Creating a custom product

-   Now we will start preparing our Satellite server to be able to manage a custom product

-   Click "Content" from the menu on the left side of the screen, and then click on "Products"

![](https://lh4.googleusercontent.com/G9XyXg_q9klv9KsT-2IyT0cIUjZLSXjjCSV2MJzi5LtwDuo3ZKY6o2fcVMFswhD9p3LUip7_C59t02jF1rMS3jByL02j0tcJvOOtY47gpkBO2bUPW67dMRh-Isf6T8DY3afwIgBD)

-   Click on "Create Product" button, and fill out the details as followed (note that the Label field will be filled out automatically):

![](https://lh4.googleusercontent.com/OAx1M_syPGq9keY1xnI_aw-oRSXUH1_piJFkaiKfr7cYFxiglVfGbN_X6Kjb95yU9L6epaAXMuQPH1DhMaw1d7wKE3_gQT2av4C55gHJHHGOD207NFWvaV3A3T-NCe9asOMoTzFH)

Leave the rest of the fields blank, and click "Save". It should then take you to the "Creative Software" product screen.

#### 4\. Creating a custom repository

-   Click the "New Repository" button, and fill out the details as followed (note that the Label field will be filled out automatically):

![](https://lh4.googleusercontent.com/FTGcdR1gRRP_rMaYt4ygzchzDZrpyY5nKfBN1fwQpyBYPylhPuWZ6pg2oFtj9qzlyJt1hmaV116iY8ll6e4Tyv4qZpCI80GqcD8UPyTHpjKjCYS6IT_7ZO_Y0ItXC_OjBwrqZmu1)

Leave the rest of the fields blank or as their default values, and click "Save".

#### 5\. Preparing a custom software package

-   Let's prepare a software package which doesn't come with RHEL distribution. Since we have limited time, let's stick with a small footprint software package.

-   Download an application called Figlet to your computer by using the following link:

<https://www.rpmfind.net/linux/epel/7/x86_64/Packages/f/figlet-2.2.5-9.el7.x86_64.rpm>

#### 6\. Uploading custom software package to Satellite

-   Go back to the "Creative Software" product page, and you should see the "Figlet Application" repository under the "Repositories" tab

![](https://lh3.googleusercontent.com/_Y6wAULSUAPzCjYIV-3mQb5nyNxyNvkVmVrErh3AdARbPIR-v_shpPUQSvYGmqSc7anGr6ccIrUT2yDaYNXzb6kzXf02xVZmqhekiakI6bkGgDYaP96zdL8URhxtcp6HpDJ8-ZIM)

-   Click on "Figlet Application" and then click on "Choose Files" to select the figlet-2.2.5-9.el7.x86_64.rpm package on your computer, and click on "Upload"

![](https://lh4.googleusercontent.com/SHC_mQYAeB8VURjUzyeRNSlZWkHZ8NespeM6Cuk-2LxjbzyBgQR824XcqPPEjUzqTchtF4XpAp1S0_GBILK-CFcRp0iA-Ox4ve_78S-VafESAGEtjIn3tCUTnFTVHgmhGRXVSOod)

-   If it's successful you should be able to see the number of packages in the repository has increased to 1

![](https://lh6.googleusercontent.com/gCY1mGVpEgEPRdEQ-Et7rmKohHPA4DNkrTURbRdz_CYwJI5932Z_CP6IggEqPFYog2QhpPblm7fQ8l90e4GbRWPs0mf_mQmh3h7fv9DJj7mQ3BwvQYO5Lg-6laGN_DHNAdtG9G-u)

#### 7\. Creating a content view

-   Now that we have a custom repository, let's create a content view in Satellite that we will use to make the repository available to our RHEL clients

-   Using the menu on the left side of the screen, go to "Content" and "Content Views", and click on "Create New View"

![](https://lh6.googleusercontent.com/PHdM4h9bkchBRXXnuwRnZRjjNsK8zWjuz5uSTp0760eAZbsZukKWN_9H58brPMYB61CTqhbs6HqrhvmWwZKVBEThGeDnLbF5Fy0zTEELiRS7IxnOQbG8jk5zYqgaD1OfvaecVOcj)

-   Leave the 2 checkboxes unchecked and hit the "Save" button

-   When you reach the next screen, go ahead and add tick the checkbox next to "Figlet Application" and hit the "Add Repository" to add the repository to the content view

![](https://lh4.googleusercontent.com/GzF32Zw0qE6yHKZ7Xq5X-36R7YPpfimlR2Fl2Hv7ID0fRIddDGK-UeYvbUznY-A-aQ-kzNM8Z0atmPPtccc851f7A8JhNCPjSUeFL_wwxDA3e58KlXy7PbNWeogRucuEtLXVrOOQ)

-   Verify the result by visiting the "List/Remove" tab above, you should see the "Figlet Application" listed there

-   Now let's publish the content view to make it available in our lifecycle environments, go ahead and click the "Publish New Version" button at the top right of the screen, followed by "Save" on the next screen

-   By default a new content view will be published to the Library environment

![](https://lh5.googleusercontent.com/ZsxViS4bLq4KwK912UoiOWiCAIYCosRHCpFQ6dUGuoNiVf3-XsJBsqmwAf-dX7AJfRf7X4V-PlWuUcYJSkXCUhUebQqkq7gXmqDiH1iZER_nRoCi-u-Uw07uMbBLl0LSixMOpXa0)

-   Click the "Promote" button to make it available in other lifecycle environments, and for this exercise, let's make it available to RHEL clients in the "RHEL7_Dev" environment

![](https://lh3.googleusercontent.com/-bRjtIVAlWL9ptYOS32OnpQ550qsrkVVSUQWPk-vZck0zbMtwWsTmd0U8evj2HhtpLh0qLRZoKFCwEP7sp5ShXRd9RAQIx1aMB9nkejqzdPo5doZQeEpacCLXCl1_ajHTAZoaUN6)

-   Click the "Promote Version" button after you make the selection

![](https://lh5.googleusercontent.com/8OsRyJorrb8n8cz8BHZWzhQKJqROzu4fytBRmkH6bEQsYJ71dU2Lnls3PPUL2V6OLcv_Po1KJ0j4oTUSFppwxwQ5aVuvtxh7vYQi-nhBokZZgXUCFdtB1mtX3LaeHJ0jS9vQCuWM)

-   A RHEL client managed by Satellite can only see one content view at a time. And all of the RHEL7 clients in the lab environment have been configured to see the "RHEL7" content view. To ensure that our clients can see both the OS related content and the Creative Software content, we need to create a composite content view. A composite content view consists of multiple content views

-   Go ahead and create a new composite content view called "RHEL7-Creative" which consists of the "RHEL7" and "Creative Software" content views, save it, publish it, and promote it to the "RHEL7_Dev" lifecycle environment

![](https://lh4.googleusercontent.com/0BnV1hRP7R6zaNcLDTePesVxzqROypyHKjdQn3BBEjVP5XB_Cl6zVqQHvkUNCKmT9LrxXdgBKHRrNrrYcxi-6CCIoKV528gEeqmz_HFQLUZQ3myiJY3KawO0ijjra6R9p7Ex7EkR)

![](https://lh3.googleusercontent.com/vSz2YcV76y8VSvKMFFyZmLtv_YYKaqqvz8XxVYLjzvXkvkZ7pk6tkNtR2mYKZ_q-KDqxtd2S_mBbGCGI9SRUr4VZA2A-XRFvmmncAeTUKSgXWy3TIopH2V9HmHAy8oqcrlTU4qrL)

![](https://lh4.googleusercontent.com/3ESb1fhEaSyVO3nuBc1q3VNxL8930AGnV5gP33XU1oeFCmQURv9h70_t3vBJkvAHyqEZZWaYObKFPR7KaZuCZaZ6sIy-VLQ2VyVWuqGzicBLIPtqrCGScfegu0QCWVBMaSG6P5JC)

-   Now let's reconfigure our RHEL7 clients to use the new composite content view. From the menu choose Hosts -> Content Hosts, and select one or multiple clients, click the "Select Action" button and choose "Change Lifecycle Environment", assign clients to "RHEL7_Dev" environment and "RHEL7-Creative" content view, and click the "Assign" button

![](https://lh5.googleusercontent.com/3YnVOo_A5q2wx6mz58GvwercMrasEa83RT-X3Tu3zdSUTA9QNGILoDKF_AA9bRI9qvhD9cVXBDo65aw6ueOYLwOwCyUBNhAn6ogr36iGvrqsT5Wk7jIwJWnos9OmPSQGo1GhbuN7)

![](https://lh4.googleusercontent.com/EJLq295DZoh0vMzHQt46FB-efZVUHttu1OaBj7Gq8hMxbtrK9ON7BUGeP72zp9AYvX76N6N2thX-B6huk7Kxo4FRueoFL0agebH0koFTEs6Yre0CqMK7VP29pnTRFZ6fL8KdNa1v)

#### 8\. Installing software on RHEL clients

-   From the menu choose Hosts -> Content Hosts, and select one or multiple clients, click the "Select Action" button and choose "Manage Packages"

-   Type "figlet" in the field and click the "Install" button

![](https://lh5.googleusercontent.com/Dnj0GhPsjMzB5hFswAsJe_3TNPpu9MBZp9BNpPH8jQYEOhx71D-ibYfD1zd9gTkNC0RywsPeKezGauRZWn8dJ9ct5srqIMuklnagSZhgFQ4AnQOCUZ1bGF4o_B5kW2sd1WB8J2gN)

OR

-   Login to one of the RHEL clients via SSH

-   Install the figlet software package by using yum (sudo yum install figlet)

-   And verify if you can use the figlet application (type figlet on command line)

```
$ figlet
finish!
  __ _       _     _     _
 / _(_)_ __ (_)___| |__ | |
| |_| | '_ \| / __| '_ \| |
|  _| | | | | \__ \ | | |_|
|_| |_|_| |_|_|___/_| |_(_)
```
