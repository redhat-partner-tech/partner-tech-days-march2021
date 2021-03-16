# Ansible Workshop - Smart Management Automation

In this workshop you will learn how to get the most from using both Red Hat Smart Management and the Ansible Automation Platform.

## Table of Contents
- [Use Cases](#use-cases)
- [Lab Diagram](#lab-diagram)
- [Lab Setup](#lab-setup)
    - [Deployment](#deployment)
    - [Configure](#configure)
    - [Environment](#environment)
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
- Option 1: [AWS Provisioner](https://github.com/redhat-partner-tech/partner-tech-days-march2021/blob/main/integrated-mgmt-workshop/provision-aws.md) (Ansible)  
- Option 2: [RHPDS](https://github.com/redhat-partner-tech/partner-tech-days-march2021/blob/main/integrated-mgmt-workshop/provision-rhpds.md) (Coming soon)

### Configure
*This step is only applicable if you did Option 1 for deployment.*<br><br>
After the workshop is deployed, you will need to configure the environment. This step will configure the deployed environment, including Activation Keys, Lifecycle Environments, Registering Servers to Satellite Server, etc.
- [Configure/Setup Workshop Environment](https://github.com/redhat-partner-tech/partner-tech-days-march2021/tree/main/integrated-mgmt-workshop/exercises/0-setup)<br>



### Environment

Now you should have the following configured workshop environment:

| Role                 | Inventory name |
| ---------------------| ---------------|
| Automation Platform  | ansible-1      |
| Satellite Server     | satellite      |
| Managed Host 1       | node1          |
| Managed Host 2       | node2          |
| Managed Host 3       | node3          |
| Managed Host 4       | node4          |
| Managed Host 5       | node5          |




## Guide
Workshop Presentation: [Partner Content Hub](http://redhat-partner.highspot.com)<br>
*You will need a Red Hat Partner Connect account/login to access. Don't have one? Click [here](https://connect.redhat.com/en/support)*
* [Exercise 1: Compliance / Vulnerability Management](https://github.com/redhat-partner-tech/partner-tech-days-march2021/blob/main/integrated-mgmt-workshop/exercises/2-compliance/openscap-exercise.md)
* [Exercise 2: Patch Management / OS](https://github.com/redhat-partner-tech/partner-tech-days-march2021/blob/main/integrated-mgmt-workshop/exercises/3-patching/automated-patch-management.md)
* Exercise 3: System Baseline / Drift (see presentation)
* [Exercise 4: CentOS to RHEL conversion + upgrade](https://github.com/redhat-partner-tech/partner-tech-days-march2021/blob/main/integrated-mgmt-workshop/exercises/4-convert2rhel/upgrade-exercise.md)
* [Exercise 5: Custom Repositories](https://github.com/redhat-partner-tech/partner-tech-days-march2021/blob/main/integrated-mgmt-workshop/exercises/5-customerepo/custom-repo-exercise.md)
