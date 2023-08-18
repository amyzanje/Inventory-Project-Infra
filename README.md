
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

At specified time Cloudwatch Rule will trigger the Lamba Function and it will compare the state of resources mentioned in Inventory file and current state of resources and sends an Email to Cloud Admin's with current state of resources.

 ## Architecture Overview

The system architecture consists mainly AWS Lambda function, CloudTrail events, Clouswatch Rules, IAM Roles, S3 Bucket, Simple Email Service to send the notification to Cloud Admin.


## Architecture Diagrams

Inventory Management

![Inventory Management](https://github.com/amyzanje/Inventory-Project-Infra/blob/main/Architecture/Inventory%20Management.png?raw=true)



![AWS Resources Monitoring](https://github.com/amyzanje/Inventory-Project-Infra/blob/main/Architecture/AWS%20Resource%20Monitoring.png?raw=true)


 ## Deployment Guide

- **Variables**

**region** = Deployment and Inventory region

**accountid** = AWS Account ID

**Inventory_bucket** = Bucket Name in which Inventory Excel file will strore.

**CloudTrail_bucket** = Bucket Name in which CloudTrail logs will strore.

**sender_email** = Email ID of sender for Inventory Report.

**recipient_emails** = Email ID of recipient for Inventory Report.

**schedule_time** = Schedule time for AWS Resource Monitoring in  UTC+0 format.

**This is UTC 0 time where**

     45 = Minutes
 
      9 = Hours

     \* = Day of month

     \* = Month

     ? = Day of week

     \* = Year

 1. Clone this repo locally.
 2. Set the AWS secret key , access key and region as per your requirement.
 3. Set the required variable values.
 4. Initialize the terraform code (terraform init)
 5. Make terraform plan and through the Resources which will created in this project (terraform plan)
 6. Deployment of automation Resources in your account (terraform apply)
