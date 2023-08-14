# ELB_Create_Rule

resource "aws_cloudwatch_event_rule" "ELB_Create_Rule" {
  name          = "ELB_Create_Rule"
  description   = "ELB_Create_Rule (for Inventory)"
  event_pattern = "{\"source\":[\"aws.elasticloadbalancing\"],\"detail-type\":[\"AWS API Call via CloudTrail\"],\"detail\":{\"eventSource\":[\"elasticloadbalancing.amazonaws.com\"],\"eventName\":[\"CreateLoadBalancer\"]}}"
  tags = {
    Environment = var.environment
  }
}

resource "aws_cloudwatch_event_target" "ELB_Create_Rule_Lambda_Target" {
  rule = aws_cloudwatch_event_rule.ELB_Create_Rule.name
  arn  = aws_lambda_function.New_Resource_Creation_Lamba.arn
}


# EBS_event_Rule

resource "aws_cloudwatch_event_rule" "EBS_event_Rule" {
  name          = "EBS_event"
  description   = "EBS_event (for Inventory)"
  event_pattern = "{\"source\":[\"aws.ec2\"],\"detail-type\":[\"EBS Volume Notification\"],\"detail\":{\"event\":[\"createVolume\"]}}"
  tags = {
    Environment = var.environment
  }
}

resource "aws_cloudwatch_event_target" "EBS_event_Rule_Lambda_Target" {
  rule = aws_cloudwatch_event_rule.EBS_event_Rule.name
  arn  = aws_lambda_function.New_Resource_Creation_Lamba.arn
}


# IAM_User_Creation_Rule

resource "aws_cloudwatch_event_rule" "IAM_User_Creation_Rule" {
  name          = "IAM_User_Creation_Rule"
  description   = "IAM_User_Creation_Rule (for Inventory)"
  event_pattern = "{\"source\":[\"aws.iam\"],\"detail-type\":[\"AWS API Call via CloudTrail\"],\"detail\":{\"eventSource\":[\"iam.amazonaws.com\"],\"eventName\":[\"CreateUser\"]}}"
  tags = {
    Environment = var.environment
  }
}

resource "aws_cloudwatch_event_target" "IAM_User_Creation_Rule_Lambda_Target" {
  rule = aws_cloudwatch_event_rule.IAM_User_Creation_Rule.name
  arn  = aws_lambda_function.New_Resource_Creation_Lamba.arn

}


# RDS_Create_Rule

resource "aws_cloudwatch_event_rule" "RDS_Create_Rule" {
  name          = "RDS_Create_Rule"
  description   = "RDS_Create_Rule (for Inventory)"
  event_pattern = "{\"source\":[\"aws.rds\"],\"detail-type\":[\"AWS API Call via CloudTrail\"],\"detail\":{\"eventSource\":[\"rds.amazonaws.com\"],\"eventName\":[\"CreateDBInstance\",\"CreateDBCluster\"]}}"
  tags = {
    Environment = var.environment
  }
}

resource "aws_cloudwatch_event_target" "RDS_Create_Rule_Lambda_Target" {
  rule = aws_cloudwatch_event_rule.RDS_Create_Rule.name
  arn  = aws_lambda_function.New_Resource_Creation_Lamba.arn
}



# S3_Bucket_Creation_Rule

resource "aws_cloudwatch_event_rule" "S3_Bucket_Creation_Rule" {
  name          = "S3_Bucket_Creation_Rule"
  description   = "S3_Bucket_Creation_Event_Rule (for Inventory)"
  event_pattern = "{\"source\":[\"aws.s3\"],\"detail-type\":[\"AWS API Call via CloudTrail\"],\"detail\":{\"eventSource\":[\"s3.amazonaws.com\"],\"eventName\":[\"CreateBucket\"]}}"
  tags = {
    Environment = var.environment
  }
}

resource "aws_cloudwatch_event_target" "S3_Bucket_Creation_Rule_Lambda_Target" {
  rule = aws_cloudwatch_event_rule.S3_Bucket_Creation_Rule.name
  arn  = aws_lambda_function.New_Resource_Creation_Lamba.arn
}



# 

resource "aws_cloudwatch_event_rule" "EC2_ELB_KEY_EIP_SG_Creation_Rule" {
  name          = "EC2_ELB_KEY_EIP_SG_Creation_Rule"
  description   = "Rule to trigger Lambda function on EC2_ELB_KEY_EIP_SG"
  event_pattern = "{\"source\":[\"aws.ec2\"],\"detail-type\":[\"AWS API Call via CloudTrail\"],\"detail\":{\"eventSource\":[\"ec2.amazonaws.com\"],\"eventName\":[\"RunInstances\",\"CreateLoadBalancer\",\"AllocateAddress\",\"CreateKeyPair\",\"CreateSecurityGroup\"]}}"
  tags = {
    Environment = var.environment
  }
}


resource "aws_cloudwatch_event_target" "EC2_ELB_KEY_EIP_SG_Creation_Rule_Lambda_Target" {
  rule = aws_cloudwatch_event_rule.EC2_ELB_KEY_EIP_SG_Creation_Rule.name
  arn  = aws_lambda_function.New_Resource_Creation_Lamba.arn
}


