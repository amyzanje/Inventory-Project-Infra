
# Inventory Management and AWS Resource Monitoring Automation

The "Inventory Management and AWS Resource Monitoring Automation" system is designed to streamline inventory tracking and automate the monitoring of resources deployed on the Amazon Web Services (AWS) cloud platform. 




## Purpose

The purpose of this system is to provide organizations with an efficient solution for managing their inventory and monitoring AWS resources in a centralized and automated manner. By implementing this system, businesses can achieve:

•	Accurate inventory records 

•	Reduced manual effort in data collection

•	Timely identification of resource issues



## AWS Resources Covered

- EC2
- RDS Instance
- RDS Cluster
- Elastic Load Balancer
- Security Group
- Key Pair
- EBS Volumes
- Elastic IP
- S3 Bucket
- IAM User

## Inventory Management


The system maintains a digital record of all inventory items, such as products, equipment, and assets. It tracks details such as resource name, configuration, availablity zone, and status.

Inventory data is collected automatically when the new resource is deployed in region of AWS account.This automation reduces the risk of human errors and ensures real-time accuracy.

 ## AWS Resource Monitoring

Daily routine Monitoring of AWS resource is the time-consuming and tedious tasks of every cloud engineer.By leveraging AWS Lambda and Python, we have been able to design a robust solution that significantly reduces the manual effort required for these tasks.

 ## Architecture Overview

The system architecture consists mainly AWS Lambda function, CloudTrail events, S3 Bucket, Simple Email Service to send the notification to Cloud Admin.


## Architecture Diagrams

Inventory Management

![Inventory Management](https://github.com/amyzanje/Inventory-Project-Infra/blob/main/Architecture/Inventory%20Management.png?raw=true)



![AWS Resources Monitoring](https://github.com/amyzanje/Inventory-Project-Infra/blob/main/Architecture/AWS%20Resource%20Monitoring.png?raw=true)


 ## Deployment Guide

 1. Clone this repo locally.
 2. Set the AWS secret key , access key and region as per your requirement.
 3. Initialize the terraform code (terraform init)
 4. Make terraform plan and through the Resources which will created in this project (terraform plan)
 5. Deployment of automation Resources in your account (terraform apply)
