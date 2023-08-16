# Lambda Layer

resource "aws_lambda_layer_version" "Lambda_layer_Inventory_project" {
  description = "Lambda-layer-Inventory-project"
  compatible_runtimes = [
    "python3.8"
  ]
  layer_name = "Lambda-layer-Inventory-project"
  filename   = "lambdazip/python.zip"
}


# Inventory_Lambda_Function_Daily_Monitoring


resource "aws_lambda_function" "Inventory_Lambda_Function" {
  description = "Inventory_Lambda_Function_Daily_Monitoring"
  environment {
    variables =  {
      file_name        = var.file_name
      bucket_name      = aws_s3_bucket.Inventory_bucket.id
      region           = var.region
      account          = var.accountid
      recipient_emails = join(",", var.recipient_emails)
      sender_email     = var.sender_email
    }
  }
  function_name = "Inventory_Lambda_Function"
  handler       = "lambda_function.update_excel_with_instance_details"
  architectures = [
    "x86_64"
  ]
  filename    = "lambdazip/monitoring_function.zip"
  memory_size = 128
  role        = aws_iam_role.Lambda_role.arn
  runtime     = "python3.8"
  timeout     = 303
  tracing_config {
    mode = "PassThrough"
  }
  layers = [aws_lambda_layer_version.Lambda_layer_Inventory_project.arn]
  tags = {
    Environment = var.environment
  }
}


# Lambda Function to update the Inventory once new resource will create

resource "aws_lambda_function" "New_Resource_Creation_Lamba" {
  description = "Lambda Function to update the Inventory once new resource will create"
  environment {
    variables =  {
      file_name   = var.file_name
      bucket_name = aws_s3_bucket.Inventory_bucket.id
    }
  }
  function_name = "New_Resource_Creation_Lamba"
  handler       = "lambda_function.lambda_handler"
  architectures = [
    "x86_64"
  ]
  filename    = "lambdazip/resource_create_function.zip"
  memory_size = 128
  role        = aws_iam_role.Lambda_role.arn
  runtime     = "python3.8"
  timeout     = 243
  tracing_config {
    mode = "PassThrough"
  }
  layers = [aws_lambda_layer_version.Lambda_layer_Inventory_project.arn]
  tags = {
    Environment = var.environment
  }
}


