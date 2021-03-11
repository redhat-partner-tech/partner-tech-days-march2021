# Ansible Workshop - Smart Management Automation

In this workshop you will learn how to get the most from your Red Hat Smart Management subscription and the Ansible Automation Platform.

## Table of Contents
- [Use Cases](#use-cases)
- [Lab Diagram](#lab-diagram)
- [Lab Setup](#lab-setup)
    - [Deployment](#deployment)
    - [Objective](#objective)
      - [Your Lab Environment](#your-lab-environment)
      - [**Step 1 - Setup Ansible Tower**](#step-1---setup-ansible-tower)
      - [**Step 2 - Create a Project**](#step-2---create-a-project)
      - [**Step 3 - Create Job Template**](#step-3---create-job-template)
- [Guide](#guide)

## Use Cases
We will focus on 5 main customer pain points:
- Compliance (OpenSCAP Scanning) and Vulnerability Management
- Patch Management
- System Baselining and Drift
- CentOS to RHEL conversion + upgrade
- Custom Repositories

## Lab Diagram
![](https://lh3.googleusercontent.com/TFkdkKSfTtqbwE4i0ZDTyzvKCojXgeYuIrxIq4kgK6RqiiVU54msgOjGObQEqskvi6BUilA8YoRJg5rdSq-NFC47L6GC3PFhaTmBc9fKBaUX1Axcm_u0UiuRDNJxDrTjsTfUqUpi)

## Lab Setup

### Deployment
- Option 1: [AWS Provisioner](https://github.com/redhat-partner-tech/partner-tech-days-march2021/blob/main/integrated-mgmt-workshop/provision-aws.md) (awscli)  
- Option 2: [RHPDS](https://github.com/redhat-partner-tech/partner-tech-days-march2021/blob/main/integrated-mgmt-workshop/provision-rhpds.md) (Coming soon)
- After the workshop is deployed, you will need to configure the environment
    - [Configure Workshop Environment](https://github.com/redhat-partner-tech/partner-tech-days-march2021/blob/main/integrated-mgmt-workshop/intro.md)

### Objective
Once the lap is deployed, we will need to configure the environment:
- Configure Activation Keys and Lifecycle environments
- Register Servers to Satellite Server

### Your Workshop Environment

In this workshop you'll work in a pre-configured lab environment. You will have access to the following hosts:

| Role                 | Inventory name |
| ---------------------| ---------------|
| Automation Platform  | ansible-1      |
| Satellite Server     | satellite      |
| Managed Host 1       | node1-rhel     |
| Managed Host 2       | node2-rhel     |
| Managed Host 3       | node3-rhel     |
| Managed Host 4       | node4-centos   |
| Managed Host 5       | node5-centos   |


#### **Step 1 - Setup Ansible Tower**

Login to the Automation Platform:

Open your browser and navigate to the Ansible Tower UI link provided on the attendance page. Login with the username `admin` and the password from your attendance page.

#### **Step 2 - Create a Project**

From the navigation section on the left side of the Automation Platform homepage, select **Project**. Click the green **Create** button in the top right corner. 

Create a project using the `https://github.com/willtome/automated-smart-management.git` as the source git repository. Enable the checkbox **Update on Launch**.

#### **Step 3 - Create Job Template**

## Guide
Workshop Presentation: [Partner Content Hub](link)
* [Exercise 1: Compliance / Vulnerability Management](https://github.com/redhat-partner-tech/partner-tech-days-march2021/blob/main/integrated-mgmt-workshop/openscap-exercise.md)
* [Exercise 2: Patch Management / OS](https://github.com/redhat-partner-tech/partner-tech-days-march2021/blob/main/integrated-mgmt-workshop/automated-patch-management.md)
* Exercise 3: System Baseline / Drift (See presentation)
* [Exercise 4: CentOS to RHEL conversion + upgrade](https://github.com/redhat-partner-tech/partner-tech-days-march2021/blob/main/integrated-mgmt-workshop/upgrade-exercise.md)
* [Exercise 5: Custom Repositories](https://github.com/redhat-partner-tech/partner-tech-days-march2021/blob/main/integrated-mgmt-workshop/custom-repo-exercise.md)
