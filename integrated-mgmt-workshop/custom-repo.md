# Integrated Management Workshop: Configuring a custom repository in Satellite

In this part of the workshop, we will learn how to configure a custom repository in Satellite. When you have RHEL clients managed by Satellite in your environment, sometimes there is a requirement to manage 3rd-party software packages that don't come from any of the RHEL distributions/repositories. For example, the Creative department wanted you to manage a 3rd-party CAD/CAM software that runs on many of their RHEL workstations.

## Environment

-   Red Hat Satellite 6

-   2 x Red Hat Enterprise Linux clients

## Pre-requisites (completed in previous exercises in the workshop, values to be changed)

-   Organization to be used = arwinata-test

-   Location to be used = Default Location

-   A content view = Workshop CV

-   Lifecycle environments = Dev, QA, Prod

-   SSH access to RHEL clients (node1, node2) which has been registered to Satellite

## Exercise

#### 1\. Logging in to Satellite

-   Use a web browser on your computer to access the Satellite GUI via the link found in the Environment above. And use the following username and password to login: admin / ansible123

![](https://lh3.googleusercontent.com/E7feHyVF0hUr0ySyPm12NTdVZuLqSxVeRg30JZ63XorJSVAnOZDfGrW8h4f9xvStN9gp_Sx48ArGaThHSFuG9PcQsSdjqS7KDrpZ3OhkpqnLQ_RNsgTxVglJk90LNZfG2QLk6ULK)

-   Once you're in Satellite you would be able to see a dashboard

![](https://lh5.googleusercontent.com/g22VsrKilxepC3DSpw-tGWM9YOFHfrH2z8GRmwj6s_0369aX9JhXY0K2YGBI13mM7xB1CiWAOLg1CbQrNchNsWZsUgDBO3bNd9J_3bF5dQO0A1GztjMyVNx1OUrLM5STVk50Wx1a)

#### 2\. Set Organization and Location (values to be changed)

-   Ensure that you select "myorg" as the Organization and "Default Location" as the location, by clicking on the menu on top of the page

![](https://lh5.googleusercontent.com/eQPZFalUi2kSLW2K7ejRnPnEl0pj_3msuo4QXKv8BKvKhAz-ClEA8FQspIhH8ukhfMHXc4VYJOYSYvgPZRnaKx94ZDaBqxDPYjeZqj-yGAKnwZBivyEksD7YIaurxnIxNCmAkWss)

#### 3\. Creating a custom product (values to be changed)

-   Now we will start preparing our Satellite server to be able to manage a custom product

-   Click "Content" from the menu on the left side of the screen, and then click on "Products"

![](https://lh4.googleusercontent.com/G9XyXg_q9klv9KsT-2IyT0cIUjZLSXjjCSV2MJzi5LtwDuo3ZKY6o2fcVMFswhD9p3LUip7_C59t02jF1rMS3jByL02j0tcJvOOtY47gpkBO2bUPW67dMRh-Isf6T8DY3afwIgBD)

-   Click on "Create Product" button, and fill out the details as followed (note that the Label field will be filled out automatically):

![](https://lh5.googleusercontent.com/PsSrTQFuV_BSHr1DmMiICStmpTWQAz6INkfg_UsvmptZcAZiltBXdoxIl9ls1myn6SvoXYCAg8ZtgvYNDE1lV9wCCqzEIRDdgSBPzBAhDzUEmL6xX-JSb4hNqxtuiO8COZPQvkxY)

Leave the rest of the fields blank or as they are, and click "Save". It should then take you to the "3rd Party" product screen.

#### 4\. Creating a custom repository (values to be changed)

-   Click the "New Repository" button, and fill out the details as followed (note that the Label field will be filled out automatically):

![](https://lh3.googleusercontent.com/YubtN4kG2LAHX3jx3vEyXed4MdikMx0wRupoeft-l3EHE7v5fD-zcWERt44tqLdDRVxjwjTKCWZ9NhSb6-BzC9Ohs-wBDd1WVv19AhvIPLEcHyRI4dA8a9SHm6Lg1w44ZgPuhydf)

Leave the rest of the fields blank or as they are, and click "Save".

#### 5\. Preparing a custom software package (values to be changed)

-   Let's prepare a 3-rd party software package which doesn't come with RHEL distribution. Since we have limited time, let's stick with a small footprint software package.

-   Download an application called Figlet to your computer by using the following link:

<https://www.rpmfind.net/linux/epel/7/x86_64/Packages/f/figlet-2.2.5-9.el7.x86_64.rpm>

#### 6\. Uploading custom software package to Satellite (values to be changed)

-   Go back to the "3rd Party" product page, and you should see the "Extra Software" repository under the "Repositories" tab

![](https://lh5.googleusercontent.com/qy2Qh1PrgGJiXPqEDM82xwbr37TAy0LmaqK1JFbshzPa8t_nr6sEH_Z0rpGGNdUM8LDAtkyb7TsvG53c2hVl4EnWZTn7riF3SU3QmJCFyziPxp5j-o1gtRA7pHm-j3RDAQO5sE67)

-   Click on "Extra Software" and then click on "Choose Files" to select the figlet-2.2.5-9.el7.x86_64.rpm package on your computer, and click on "Upload"

![](https://lh4.googleusercontent.com/SHC_mQYAeB8VURjUzyeRNSlZWkHZ8NespeM6Cuk-2LxjbzyBgQR824XcqPPEjUzqTchtF4XpAp1S0_GBILK-CFcRp0iA-Ox4ve_78S-VafESAGEtjIn3tCUTnFTVHgmhGRXVSOod)

-   If it's successful you should be able to see the number of packages in the repository has increased to 1

![](https://lh6.googleusercontent.com/gCY1mGVpEgEPRdEQ-Et7rmKohHPA4DNkrTURbRdz_CYwJI5932Z_CP6IggEqPFYog2QhpPblm7fQ8l90e4GbRWPs0mf_mQmh3h7fv9DJj7mQ3BwvQYO5Lg-6laGN_DHNAdtG9G-u)

#### 7\. Adding custom repository to a content view (values to be changed)

-   Now that we have a custom repository, let's add it to the content view that we created on previous exercises

-   Using the menu on the left side of the screen, go to "Content" and "Content Views", and click on "Workshop CV"

![](https://lh6.googleusercontent.com/KPXrr2IPoygEFYB6F5IJ7y6KydzYR3Bq7oDQmgdPUvKxI9hhL4-4m4gHw5rucSpNt2J5fdcg32VoNuK2xX2B1EfupgprRXtVA94fOD_QsuBKcLd1RyxQaL6QuGU-Q10sGXiLxPWD)

-   Once you're in the "Workshop CV" go to the "Yum Content" tab and click on "Repositories", and under the "Repository Selection" click on "Add"

![](https://lh3.googleusercontent.com/_riBc5sHHzV5Y4eWpBCdw2g0hXLFT4Un9YAG_0iNOaVAg2GpPQpJuAsx6FgnfjIxGyg5X33BPN75ThQnXmJ9tCBizkZmt21-SKC9spZUimFGOS6qzMfg7FXw0uM4nD8pt52xPAxz)

-   Select the "Extra Software" by checking the box and click the "Add Repositories" button

![](https://lh5.googleusercontent.com/tt6K4c0AeMZUxWqxcO44C4yT52mTFt1h8Sgz_qtPyUQkMgg_TEGAENUsnIYyiL4e6J7xoBut7LEx_wyIY_FvdF4KgvfznXD0_2aJA9PLFaHC_bWHN2lnmdMIE7dQ1mt_MtOaY5MO)

-   Click on "List/Remove" to confirm the "Extra Software" repository has been added to the content view

![](https://lh5.googleusercontent.com/htIaNteFJwtLMYFfh4Ync58xtlfsbXkHvtIoObxRhYE3hvpR_FeuvEDr81n-37VcEphc0pNTjZF8TloVNhx-1A1bhLx2Wn0np8PZQtDLXS28mlQuS7Vyg8xoA9uXOyG4OmSSzGuX)

-   Since we have just modified our content view, we should publish it to activate the changes by clicking on the "Publish New Version" button on the top area of the screen, and then click "Save"

-   Finally promote the content view to the "Dev" lifecycle environment

#### 8\. Installing software from a custom repo on RHEL clients (values to be changed)

-   Login to one of the RHEL clients (node1) via SSH

-   Install the figlet software package by using yum (sudo yum install figlet)

-   And verify if you can use the figlet application (type figlet on command line)

```
$ figlet
finish!
  __ _       _     _     _
 / _(_)_ __ (_)___| |__ | |
| |_| | '_ \| / __| '_ \| |
|  _| | | | | \__ \ | | |_|
|_| |_|_| |_|_|___/_| |_(_)
```
