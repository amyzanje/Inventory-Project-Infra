# resource "aws_iam_role_policy" "IAMPolicy" {
#     policy = <<EOF
# {
# 	"Version": "2012-10-17",
# 	"Statement": [
# 		{
# 			"Sid": "VisualEditor0",
# 			"Effect": "Allow",
# 			"Action": [
# 				"s3:PutObject",
# 				"s3:GetObject"
# 			],
# 			"Resource": "arn:aws:s3:::inventory-sz/*"
# 		}
# 	]
# }
# EOF
#     role = "${aws_iam_role.IAMRole.name}"
# }

# resource "aws_iam_role" "IAMRole" {
#     path = "/"
#     name = "inv-LambdaExecutionRole-ASR0AMA7ZLRK"
#     assume_role_policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"lambda.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}"
#     max_session_duration = 3600
#     tags = {}
# }

# resource "aws_cloudwatch_event_rule" "EventsRule" {
#     name = "ELB_Create_Rule"
#     description = "ELB_Create_Rule (for Inventory"
#     event_pattern = "{\"source\":[\"aws.elasticloadbalancing\"],\"detail-type\":[\"AWS API Call via CloudTrail\"],\"detail\":{\"eventSource\":[\"elasticloadbalancing.amazonaws.com\"],\"eventName\":[\"CreateLoadBalancer\"]}}"
# }

# resource "aws_cloudwatch_event_target" "CloudWatchEventTarget" {
#     rule = "ELB_Create_Rule"
#     arn = "arn:aws:events:us-east-1:564572526252:rule/ELB_Create_Rule"
# }

# resource "aws_cloudwatch_event_rule" "EventsRule2" {
#     name = "EBS_event"
#     event_pattern = "{\"source\":[\"aws.ec2\"],\"detail-type\":[\"EBS Volume Notification\"],\"detail\":{\"event\":[\"createVolume\"]}}"
# }

# resource "aws_cloudwatch_event_target" "CloudWatchEventTarget2" {
#     rule = "EBS_event"
#     arn = "arn:aws:events:us-east-1:564572526252:rule/EBS_event"
# }

# resource "aws_cloudwatch_event_rule" "EventsRule3" {
#     name = "IAM_User_Creation_Rule"
#     description = "IAM_User_Creation_Rule (for Inventory)"
#     event_pattern = "{\"source\":[\"aws.iam\"],\"detail-type\":[\"AWS API Call via CloudTrail\"],\"detail\":{\"eventSource\":[\"iam.amazonaws.com\"],\"eventName\":[\"CreateUser\"]}}"
# }

# resource "aws_cloudwatch_event_target" "CloudWatchEventTarget3" {
#     rule = "IAM_User_Creation_Rule"
#     arn = "arn:aws:events:us-east-1:564572526252:rule/IAM_User_Creation_Rule"
# }

# resource "aws_cloudwatch_event_rule" "EventsRule4" {
#     name = "RDS_Create_Rule"
#     description = "RDS_Create_Rule (for Inventory)"
#     event_pattern = "{\"source\":[\"aws.rds\"],\"detail-type\":[\"AWS API Call via CloudTrail\"],\"detail\":{\"eventSource\":[\"rds.amazonaws.com\"],\"eventName\":[\"CreateDBInstance\",\"CreateDBCluster\"]}}"
# }

# resource "aws_cloudwatch_event_target" "CloudWatchEventTarget4" {
#     rule = "RDS_Create_Rule"
#     arn = "arn:aws:events:us-east-1:564572526252:rule/RDS_Create_Rule"
# }

# resource "aws_cloudwatch_event_rule" "EventsRule5" {
#     name = "S3_Bucket_Creation"
#     description = "S3_Bucket_Creation_Event_Rule ( for Inventory)"
#     event_pattern = "{\"source\":[\"aws.s3\"],\"detail-type\":[\"AWS API Call via CloudTrail\"],\"detail\":{\"eventSource\":[\"s3.amazonaws.com\"],\"eventName\":[\"CreateBucket\"]}}"
# }

# resource "aws_cloudwatch_event_target" "CloudWatchEventTarget5" {
#     rule = "S3_Bucket_Creation"
#     arn = "arn:aws:events:us-east-1:564572526252:rule/S3_Bucket_Creation"
# }

# resource "aws_cloudwatch_event_rule" "EventsRule6" {
#     name = "YourEventsRuleName"
#     description = "Rule to trigger Lambda function on EC2 instance creation"
#     event_pattern = "{\"source\":[\"aws.ec2\"],\"detail-type\":[\"AWS API Call via CloudTrail\"],\"detail\":{\"eventSource\":[\"ec2.amazonaws.com\"],\"eventName\":[\"RunInstances\",\"CreateLoadBalancer\",\"AllocateAddress\",\"CreateKeyPair\",\"CreateSecurityGroup\"]}}"
# }

# resource "aws_cloudwatch_event_target" "CloudWatchEventTarget6" {
#     rule = "YourEventsRuleName"
#     arn = "arn:aws:events:us-east-1:564572526252:rule/YourEventsRuleName"
# }

# resource "aws_lambda_function" "LambdaFunction" {
#     description = ""
#     environment {
#         variables {
#             file_name = "ec2_inventory.xlsx"
#             bucket_name = "${aws_s3_bucket.S3Bucket.id}"
#             region = "us-east-1"
#             account = "564572526252"
#         }
#     }
#     function_name = "YourLambdaFunctionName"
#     handler = "lambda_function.update_excel_with_instance_details"
#     architectures = [
#         "x86_64"
#     ]
#     s3_bucket = "prod-04-2014-tasks"
#     s3_key = "/snapshots/564572526252/YourLambdaFunctionName-3c01a382-9039-4da1-a4c7-0dee052d70bb"
#     s3_object_version = "IjIjtU8YLPB0n7C.5Fhpc56c02XchCoE"
#     memory_size = 128
#     role = "${aws_iam_role.IAMRole.arn}"
#     runtime = "python3.8"
#     timeout = 303
#     tracing_config {
#         mode = "PassThrough"
#     }
#     layers = [
#         "arn:aws:lambda:us-east-1:564572526252:layer:YourLambdaLayerName:3"
#     ]
#     tags = {}
# }

# resource "aws_lambda_function" "LambdaFunction2" {
#     description = ""
#     environment {
#         variables {
#             file_name = "ec2_inventory.xlsx"
#             bucket_name = "${aws_s3_bucket.S3Bucket.id}"
#         }
#     }
#     function_name = "Create_Event"
#     handler = "lambda_function.lambda_handler"
#     architectures = [
#         "x86_64"
#     ]
#     s3_bucket = "prod-04-2014-tasks"
#     s3_key = "/snapshots/564572526252/Create_Event-0eef0365-b926-4018-b109-941211a8cf85"
#     s3_object_version = "MjuB3MVn3.7RbJCtAMR_GC8NsX4EmTEL"
#     memory_size = 128
#     role = "${aws_iam_role.IAMRole.arn}"
#     runtime = "python3.8"
#     timeout = 243
#     tracing_config {
#         mode = "PassThrough"
#     }
#     layers = [
#         "arn:aws:lambda:us-east-1:564572526252:layer:YourLambdaLayerName:3"
#     ]
# }

# resource "aws_lambda_layer_version" "LambdaLayerVersion" {
#     description = ""
#     compatible_runtimes = [
#         "python3.8"
#     ]
#     layer_name = "YourLambdaLayerName"
#     s3_bucket = "prod-04-2014-layers"
#     s3_key = "/snapshots/564572526252/YourLambdaLayerName-ea16118b-eec0-4e58-8c70-a4e1d70fdac1"
# }

# resource "aws_cloudtrail" "CloudTrailTrail" {
#     name = "management-events"
#     s3_bucket_name = "${aws_s3_bucket.S3Bucket2.id}"
#     include_global_service_events = true
#     is_multi_region_trail = true
#     enable_log_file_validation = false
#     enable_logging = true
# }

# resource "aws_s3_bucket" "S3Bucket" {
#     bucket = "inventory-sz"
# }

# resource "aws_s3_bucket" "S3Bucket2" {
#     bucket = "aws-cloudtrail-logs-564572526252-540945cf"
# }
