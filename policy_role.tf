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

