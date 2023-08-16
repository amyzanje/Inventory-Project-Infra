# S3 Bucket to store the Inventory file

resource "aws_s3_bucket" "Inventory_bucket" {
  bucket = "${var.Inventory_bucket}-${var.accountid}"
  #force_destroy = true

  tags = {
    Environment = var.environment
  }
}


# Bucket Versioning

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.Inventory_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}


# Bucket for cloudtrail

resource "aws_s3_bucket" "cloudtrail-bucket" {
  bucket = "${var.CloudTrail_bucket}-${var.accountid}"
  force_destroy = true
  tags = {
    Environment = var.environment
  }
}


# resource "aws_s3_bucket_policy" "cloudtrail_bucket_policy" {
#   bucket = aws_s3_bucket.cloudtrail-bucket.id
#   policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Sid\":\"AWSCloudTrailAclCheck20150319\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"cloudtrail.amazonaws.com\"},\"Action\":\"s3:GetBucketAcl\",\"Resource\":\"${aws_s3_bucket.cloudtrail-bucket.arn}\",\"Condition\":{\"StringEquals\":{\"AWS:SourceArn\":\"${aws_cloudtrail.CloudTrailTrail.arn}\"}}},{\"Sid\":\"AWSCloudTrailWrite20150319\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"cloudtrail.amazonaws.com\"},\"Action\":\"s3:PutObject\",\"Resource\":\"${aws_s3_bucket.cloudtrail-bucket.arn}/AWSLogs/${var.accountid}/*\",\"Condition\":{\"StringEquals\":{\"AWS:SourceArn\":\"${aws_cloudtrail.CloudTrailTrail.arn}\",\"s3:x-amz-acl\":\"bucket-owner-full-control\"}}}]}"
# }
