Integrated Management Workshop: Configuring and performing an OpenSCAP Scan
===========================================================================

In this part of the workshop, we will learn how to configure and perform an OpenSCAP scan using playbooks in Ansible Tower with Satellite. When running multiple Red Hat Enterprise Linux systems, it's important to keep all of these systems compliant with a meaningful security policy and perform security scans remotely from a single location. OpenSCAP is an open source project that is used by government agencies, corporations, as well as e-commerce and provides tools for automated vulnerability checking.

Environment
-----------

-   Red Hat Satellite v6.8

-   3 x Red Hat Enterprise Linux clients v7.9

-   2 x CentOS Linux clients v7.8

Pre-requisites (completed in previous exercises in the workshop, values to be changed)
--------------------------------------------------------------------------------------

-   Organization to be used = Default Organization

-   Content view = RHEL7

-   Lifecycle environments = Dev, QA, Prod

-   SSH access to RHEL clients (node1, node2, node3) which have been registered to Satellite

Exercise
--------

#### 1\. Logging into Satellite

-   Use a web browser on your computer to access the Satellite GUI via the link found in the Environment above. And use the following username and password to login: *admin /* <*password*>

![](https://lh3.googleusercontent.com/61RJI80QPal7BWRRjw8AGQA_okIXvBTGG6Vfo0ECdVjSFO4PPkvAMKHpVccroazXRtV_uvfC20x38j0i49BZErswpsDXTcDrxFw94cp1KlLYdjNDCC3Sxb8UwYcrOZNCWR7rqcmD)

Once you're in Satellite you would be able to see a dashboard

![](https://lh5.googleusercontent.com/0oL1NhGOFVJQIcnol7xSneJgzAIAX5HKPkV_hHjan5iM9L7qVliUMct53MsKTy4rkJU0Yu8HBmd7yV9VLafJqDJFZKTLHPo73wNMD64dNuvP6xS04C6KAHKr2KIJ1bF67m62cjdA)

#### 2\. Creating a new compliance policy

-   Now we will start configuring a compliance policy to be able to scan our RHEL nodes.

-   In Satellite hover over 'Hosts' from the menu on the left side pane, and then click on 'Policies'

-   Click on the "New Policy" button, and fill out the details as followed in step 3. 

![](https://lh5.googleusercontent.com/2qOPrqw4iC02hxEM6dfG5fj_TOsR5s-AAPCmEIXRDJo7kcfLlATH-bH36htyDB4UHWVTA-43jpwQfv21QdZx6oW41KohQYz4K8bpg1z_70-J6RkSknnMSiD486UjVziqD0SdnSxU)

#### 3\. Configuring a new compliance policy

-   Now we will start configuring our Satellite server to be able to manage a compliance policy

-   Select "Manual" from the deployment options and click "Next"

![](https://lh3.googleusercontent.com/j9IPZGS-LJPKAZJj4k6wZbbx15cAkOtvqT_UBDj2iAzhi5_Mkkq6aGZClS8gSq__DxVEMsPik-pQVDEK7l2JqWJNYZJXGr2yNdETyeNaSydhU8A205f9cha97QQYNLzlPRjW9-Ka)

-   Create the policy name "PCI-Compliance" and provide any description you like. Then click "Next"

![](https://lh4.googleusercontent.com/sbJOKhFNODc7YodnOaFwZjeOx16eofpbEW0PxDTv76R4aoWKHHtP-BrpKXE7khOnSKKxdKWxQRbWK7TIIoYaW6otQJjxHIO-Rd770NsBLVZiHZdhrpy8MhqaiJRoNQOv0bV1oFo4)

-   Select the "Red Hat rhel7 default content" and "PCI-DSS v3.2.1 Control Baseline for Red Hat Enterprise Linux 7". There is no tailoring file. Then click "Next"![](https://lh6.googleusercontent.com/m4VK9on3A5ZASMOB1sG8Hx76L3-fCy4Pn_mYsSmYT-QZYGbK_bYubLLpYRHzP5DoLGi_XTd7bAXTZZ2xdg5ss0OT-oRWguI7nECaUJtD-8k6i6sxLfTFn6SSLwYsaV8ePRMq5v--)

-   It is necessary to set a schedule when creating a new compliance policy. You can select "Weekly" and "Monday" for lab purposes. Then click "Next"

![](https://lh6.googleusercontent.com/rvXj6ousHaUVEs4XBXe-wON8U3LqnSFN8xrTYtQLEWQ1_YmbPDy3Ytw3Muogeb5tYFkG4rxr5s2MlGlJgjSh4gIc53Ovx0o_VEWHrU7YRH_OM6XyLKZmJLR9m8dOucga_HcFaf5_)

-   Steps 5, 6, and 7 as part of the New Compliance Policy can use default values. Click "Next" through "Locations", "Organizations", and "Hostgroups"

![](https://lh6.googleusercontent.com/Y2DSZltuMov4zXtop_IYzfWZXRRmyk2Ogvnv-Sz22QGaKWm4QD7LcVtjkVP3inDSFIlLUiaRC267gnBrABF0sNJCx-lXN-19Ufu4le-HdUzWz36fxAI4nizD3bi5piEwEoJN3JXF)

#### 4\. Logging into the Ansible Automation Platform

-   Use a web browser on your computer to access the Ansible GUI via the link found in the Environment above

![](https://lh5.googleusercontent.com/UH3-l8kGnC1UM20Op4_d0HZZ7upq84dechLxShPZZ4Ki-4P-bu8ej8sfUZIO-lxBXwdAx7MaIehy9I0NQt-w_DhzJdHBJnOfwRcYaY6Z2UUXsTY_eekbmDgvfq-2SLEIgqEvF7SG)

Once you're in Ansible Tower, you'll be able to see a dashboard.

![](https://lh4.googleusercontent.com/sVjxVPXbZ0lHrA3clT0kFIMNbYizH4y3OCTrb_kxSK39RhDr1UzLz4AS4N2Tvs6R9wUzmma0nj-CkJtHL8c0EjPyz5oEfbGFYtDzPRZ637X4rRKqtNseCxR9OL7JJNlfA9cygoIN)

#### 4\. Configure and launch an Ansible Tower template to run an OpenSCAP scan. 

-   In Ansible Tower click 'Templates' from the left side pane menu

-   Select on the GREEN + icon on the far right side of the screen and click "Job Template". Fill out the details as follows. 

        Name: OpenSCAP_Configure

        Job Type: Run

        Inventory: Workshop Inventory (Click the magnifying glass icon to select)

        Project: Automated Management (Click the magnifying glass icon to select) 

        Playbook: configure_openscap.yml

        Credentials: Workshop Credential (Click the magnifying glass icon to select)

        Extra Variables:

        HOSTS: node1.example.com
        Policy_scan: 
          - PCI_Compliance

![](https://lh5.googleusercontent.com/w--1gqh7nJwqHv_q_vjbXDaJCPXmrj5bHbZnx5A0lO3SChPDthAxR9b3IXMapaDUf4oWK_HIk-2iwAszRl671_5D0kOcqBNBKOuMwN5M9TsgmVGJcZxuwLfWrreaGg9zUbVdQC39)

-   Leave the rest of the fields blank or as they are, and click 'Save'. You can then select 'Launch' to deploy the job template.

![](https://lh3.googleusercontent.com/nkQNdZD0E3zKh6oHQTiF29A_qYR6qgFJWH8_HRuttjgR69vyLuagPJJQ-3nw7jh32DvSy39RPWFzN6qz2Hp0gj6JjdOpjlCdV8V5hFALlPEMiE8EhNuRcXPbi7Oz5aZlXucGRBPM)

#### 5\. Navigate back to Satellite to examine the Asset Reporting File (ARF). 

-   Hover over 'Hosts' from the side pane menu and then click on 'Reports'.

-   Click on the report for 'node1.example.com' to evaluate

-   You can sort by "Pass", "Fail", "Fixed", or any number of qualifiers as well as group rules by "Severity"

![](https://lh3.googleusercontent.com/hu_26q9h1QEMEAs6_57yiqDngir1xM5lolQWOSsDkOOzuiCpSUKtYDDk3TLc2zMozmLNWcmmDXMVuIulAvsolKZa_t6Siu62mqLabFdgO19Mr-V6rw6E14n7qYUxmmwt2PpaiapP)

-   Selecting a rule presents further information regarding rationale as well as a description of the rule that includes references and identifiers.

-   If you scroll the page you will notice multiple remediation steps including an 'Ansible' snippet. This presents tasks you can compile within a playbook to automation remediation across affected machines.

![](https://lh3.googleusercontent.com/_H6GjCsPq1pntFiW1lSRJQBq5dOyeGBJhk66RxNn6KO4SqeYJfmEeTgr2-rbpJlIEt5-ueQcfA41Ivae-wIErXreIsy9vkYnVB-i9K_FzA9mz_MWrjFpMdDyMcZurjaSNf-t516p)

#### 7\. Scaling an OpenSCAP scan. (values to be changed)

-   In Satellite, hover over "Hosts" from the menu on the left side of the screen, and then click on "Policies".

-   Select "Manual" from the deployment options and click "Next"

![](https://lh3.googleusercontent.com/j9IPZGS-LJPKAZJj4k6wZbbx15cAkOtvqT_UBDj2iAzhi5_Mkkq6aGZClS8gSq__DxVEMsPik-pQVDEK7l2JqWJNYZJXGr2yNdETyeNaSydhU8A205f9cha97QQYNLzlPRjW9-Ka)

-   Create the policy name "STIG_Compliance" and provide any description you like. Then click "Next"

![](https://lh4.googleusercontent.com/dTnvNbOssJCLU4h2wp1OkN6fOTlVORkANhgW6dmt2gxcegGsXdYlhNbXGVMlc6VDzu8OMzXgXR0oHbs_UWAoBhijgVvsPUEu3_GDkLWaCdLudhJHrlB4Kyv_CGFCEUS362ZqzQak)

-   Select the "Red Hat rhel7 default content" and "DISA STIG for Red Hat Enterprise Linux 7". There is no tailoring file. Then click "Next"

![](https://lh4.googleusercontent.com/WSMWISWqV4d5Lm-rOHEZDmsoRaijc642iIhi7l23Tpe5XCJMEk__7xP0o3pj7lDbP0NJssxNI7a0FMbj21r8FPwqjkQ0W58lmyvprQXu3xgoCNiuii6VGwkt1BH_Hb7psI5XBE5c)

-   It is necessary to set a schedule when creating a new compliance policy. You can select "Weekly" and "Monday" for lab purposes. Then click "Next"

![](https://lh6.googleusercontent.com/rvXj6ousHaUVEs4XBXe-wON8U3LqnSFN8xrTYtQLEWQ1_YmbPDy3Ytw3Muogeb5tYFkG4rxr5s2MlGlJgjSh4gIc53Ovx0o_VEWHrU7YRH_OM6XyLKZmJLR9m8dOucga_HcFaf5_)

-   Steps 5, 6, and 7 as part of the New Compliance Policy can use default values. Click "Next" through "Locations", "Organizations", and "Hostgroups"

![](https://lh6.googleusercontent.com/Y2DSZltuMov4zXtop_IYzfWZXRRmyk2Ogvnv-Sz22QGaKWm4QD7LcVtjkVP3inDSFIlLUiaRC267gnBrABF0sNJCx-lXN-19Ufu4le-HdUzWz36fxAI4nizD3bi5piEwEoJN3JXF)

-   Click "Templates" from the left sidebar. 

-   Then select on the far right side of the screen and click "Job Template". Fill out the details as follows. 

        Name: "OpenSCAP_Configure"

        Job Type: "Run"

        Inventory: "Workshop Inventory"

        Playbook: "configure_openscap.yml"

        Project: "Automated_Smart_Management" 

        Credentials: "Satellite_Credential", "Workshop Credential"

        Extra Variables:

            HOSTS: rhel7

            Policy_scan: 

                - PCI_Compliance

                - STIG_Compliance

![](https://lh4.googleusercontent.com/KV-fvA1EBSSWJL_e9cxPtRrJzGcuzAAl2TjLLGPQVrxo9E-gqnL6VAqBmjRXOs8a6LGjmatQCQWzIjZXu_qnawmZBmERi2ydlPdcNyCOV5zCncwZ5iU7HtKszFDgV9WOYuM0KUal)

-   Leave the rest of the fields blank or as they are, and click 'Save'. You can then select 'Launch' to deploy the job template.

![](https://lh5.googleusercontent.com/0r_XUXeCaLqSE3ehvvRB8TCCQLZPa9USDwhU46etuzb_eYxZbHJCTVb7SmyqZuebAO2xm1eSRsPVWLYgS43-KVGDbxob5hkZ8bHS8Q2speQTilfaV38oSXInVqUF5tRN8PekEVeW)

#### 8\. Navigate back to Satellite to examine the Asset Reporting File (ARF). 

-   Hover over "Hosts" from the menu on the left side of the screen, and then click on "Reports".

-   Notice that we've now easily scaled to six scans, 2 scans of each node for PCI_Compliance and for STIG_Compliance. 

![](https://lh3.googleusercontent.com/BoUp9jxDCNaqpWabW1hdEZJazSA5T79Oh1jt7hzCaLtm374oH8EZfrloculCO3ekg2ncdqKMAzAGqdXo7bwNsmMPaxElddYXZx7vmbS3s-J3bGKqCClh7wPjDq0oVC3zL8Xq1wIc)

-   Each report can be reviewed independent of other node scans and remediations for rule findings can be completed according to the requirements of your own internal policies.

#### 9\. End Lab

-   You have finished the lab.
