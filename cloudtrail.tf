resource "aws_cloudtrail" "CloudTrailTrail" {
  name                          = "management-events"
  s3_bucket_name                = aws_s3_bucket.cloudtrail-bucket.id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = false
  enable_logging                = false
  
  tags = {
    Environment = var.environment
    
  }
  
depends_on = [aws_s3_bucket_policy.example]
}

