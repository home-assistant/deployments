resource "aws_iam_role" "scheduler" {
  name = "marketplace-demo-scheduler"

  tags = {
    Name = "Marketplace-Demo-Scheduler"
  }

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "scheduler.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "scheduler" {
  name = "marketplace-demo-ecs-update-service"
  role = aws_iam_role.scheduler.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "ecs:UpdateService"
        Resource = "arn:aws:ecs:us-east-1:*:service/*/Marketplace-Demo"
      }
    ]
  })
}

resource "aws_scheduler_schedule" "weekly_reset" {
  name       = "marketplace-demo-weekly-reset"
  group_name = "default"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression          = "cron(0 5 ? * SUN *)"
  schedule_expression_timezone = "Europe/Paris"

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:ecs:updateService"
    role_arn = aws_iam_role.scheduler.arn

    input = jsonencode({
      Cluster            = data.tfe_outputs.infrastructure.values["us-east-1"].ecs_cluster
      Service            = "Marketplace-Demo"
      ForceNewDeployment = true
    })
  }
}
