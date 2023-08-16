resource "aws_lambda_permission" "lambda_trigger_permission1" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.New_Resource_Creation_Lamba.function_name
  principal     = "events.amazonaws.com"
  
  source_arn = aws_cloudwatch_event_rule.ELB_Create_Rule.arn    
}

resource "aws_lambda_permission" "lambda_trigger_permission2" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.New_Resource_Creation_Lamba.function_name
  principal     = "events.amazonaws.com"
  
  source_arn = aws_cloudwatch_event_rule.EBS_event_Rule.arn    
}

resource "aws_lambda_permission" "lambda_trigger_permission3" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.New_Resource_Creation_Lamba.function_name
  principal     = "events.amazonaws.com"
  
  source_arn = aws_cloudwatch_event_rule.IAM_User_Creation_Rule.arn    
}

resource "aws_lambda_permission" "lambda_trigger_permission4" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.New_Resource_Creation_Lamba.function_name
  principal     = "events.amazonaws.com"
  
  source_arn = aws_cloudwatch_event_rule.RDS_Create_Rule.arn    
}

resource "aws_lambda_permission" "lambda_trigger_permission5" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.New_Resource_Creation_Lamba.function_name
  principal     = "events.amazonaws.com"
  
  source_arn = aws_cloudwatch_event_rule.S3_Bucket_Creation_Rule.arn    
}

resource "aws_lambda_permission" "lambda_trigger_permission6" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.New_Resource_Creation_Lamba.function_name
  principal     = "events.amazonaws.com"
  
  source_arn = aws_cloudwatch_event_rule.EC2_ELB_KEY_EIP_SG_Creation_Rule.arn    
}


resource "aws_lambda_permission" "lambda_trigger_permission7" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.Inventory_Lambda_Function.function_name
  principal     = "events.amazonaws.com"
  
  source_arn = aws_cloudwatch_event_rule.scheduler_schedule.arn    
}