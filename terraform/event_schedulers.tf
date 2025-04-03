resource "aws_scheduler_schedule" "cubs" {
  name       = "CubsCfaSchedulerTf"
  group_name = "default"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "cron(0 3 * * ? *)"

  target {
    arn      = "arn:aws:lambda:us-east-1:875660052076:function:cubs-cfa-texter"
    role_arn = "arn:aws:iam::875660052076:role/service-role/Amazon_EventBridge_Scheduler_LAMBDA_d214280288"
  }
}

resource "aws_scheduler_schedule" "hawks" {
  name       = "BlackhawksCfaSchedulerTf"
  group_name = "default"

  flexible_time_window {
    mode                      = "FLEXIBLE"
    maximum_window_in_minutes = 5
  }

  schedule_expression = "cron(30 1 * * ? *)"

  target {
    arn      = "arn:aws:lambda:us-east-1:875660052076:function:blackhawks-cfa-texter"
    role_arn = "arn:aws:iam::875660052076:role/service-role/Amazon_EventBridge_Scheduler_LAMBDA_7d62825168"
  }
}
