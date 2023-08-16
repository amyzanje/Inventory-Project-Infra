resource "aws_cloudwatch_event_rule" "scheduler_schedule" {
  name        = "scheduler_schedule"
  description = "scheduler_schedule"

  schedule_expression = "cron(${var.schedule_time})"
}

resource "aws_cloudwatch_event_target" "scheduler_target" {
  rule = aws_cloudwatch_event_rule.scheduler_schedule.name
  arn  = aws_lambda_function.Inventory_Lambda_Function.arn


}
