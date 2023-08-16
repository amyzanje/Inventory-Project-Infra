resource "aws_iam_role" "Lambda_role" {
  path                 = "/"
  name                 = "Lambda-role-Inventory"
  assume_role_policy   = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"lambda.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}"
  max_session_duration = 3600
  tags = {
    Environment = var.environment
  }
}




resource "aws_iam_role_policy" "S3-Inventory-Bucket-Access-Policy" {
  name   = "S3-Inventory-Bucket-Access-Policy"
  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": [
				"s3:PutObject",
				"s3:GetObject"
			],
			"Resource": "arn:aws:s3:::${aws_s3_bucket.Inventory_bucket.id}/*"
		}
	]
}
EOF
  role   = aws_iam_role.Lambda_role.name

  
}



# Policy attachements to role


resource "aws_iam_role_policy_attachment" "Lambda_role_policy_attachment_ec2" {
  role       = aws_iam_role.Lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
  
}

resource "aws_iam_role_policy_attachment" "Lambda_role_policy_attachment_iam" {
  role       = aws_iam_role.Lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
  
}

resource "aws_iam_role_policy_attachment" "Lambda_role_policy_attachment_rds" {
  role       = aws_iam_role.Lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
  
}

resource "aws_iam_role_policy_attachment" "Lambda_role_policy_attachment_s3" {
  role       = aws_iam_role.Lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  
}


resource "aws_iam_role_policy_attachment" "Lambda_role_policy_attachment_ses" {
  role       = aws_iam_role.Lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSESFullAccess"
  
}

resource "aws_iam_role_policy_attachment" "Lambda_role_policy_attachment_lambda" {
  role       = aws_iam_role.Lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  
}

resource "aws_iam_role_policy_attachment" "Lambda_role_policy_attachment_cloudtrail" {
  role       = aws_iam_role.Lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCloudTrail_ReadOnlyAccess"
  
}


# Poliy and Role schedule rule


resource "aws_iam_policy" "EventBridge_Scheduler_policy" {
    name = "Amazon-EventBridge-Scheduler-Execution-Policy"
    path = "/service-role/"
    
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "lambda:InvokeFunction"
            ],
            "Resource": [
                "${aws_lambda_function.Inventory_Lambda_Function.arn}:*",
                "a${aws_lambda_function.Inventory_Lambda_Function.arn}"
            ]
        }
    ]
}
EOF
}


resource "aws_iam_role" "EventBridge_Schedule_Role" {
    path = "/service-role/"
    name = "Amazon_EventBridge_Scheduler_LAMBDA"
    assume_role_policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"scheduler.amazonaws.com\"},\"Action\":\"sts:AssumeRole\",\"Condition\":{\"StringEquals\":{\"aws:SourceAccount\":\"564572526252\"}}}]}"
    max_session_duration = 3600
    tags = {}
}

resource "aws_iam_role_policy_attachment" "EventBridge_Schedule_Policy_attachement" {
  role       = aws_iam_role.EventBridge_Schedule_Role.name
  policy_arn = aws_iam_policy.EventBridge_Scheduler_policy.arn
  
}
