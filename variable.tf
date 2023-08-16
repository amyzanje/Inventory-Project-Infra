# This variables must be set as per your requirement

variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "accountid" {
  type    = string
  default = "564572526252"
}

variable "Inventory_bucket" {
  type    = string
  default = "aws-resource-inventory"
}

variable "CloudTrail_bucket" {
  type    = string
  default = "aws-cloudtrail-logs"

}


variable "sender_email" {
  type    = string
  default = "amyzanje@gmail.com"
}

variable "recipient_emails" {
  type    = list(string)
  default = ["amyzanje@gmail.com", "sszanje@gmail.com"]
}

variable "schedule_time" {
  type = string
  default = "47 9 * * ? *"
}

/*

**This is UTC 0 time where**
45 = Minutes
9 = Hours
* = Day of month
* = Month
? = Day of week
* = Year

*/


# Not need to change  


variable "environment" {
  type    = string
  default = "Inventory-Project"
}


variable "file_name" {
  type    = string
  default = "ec2_inventory.xlsx"
}





