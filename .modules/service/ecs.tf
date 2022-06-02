resource "aws_ecs_service" "service" {
  count = var.webservice ? 0 : 1

  name                               = var.service_name
  cluster                            = data.tfe_outputs.infrastructure.values[var.region].ecs_cluster
  task_definition                    = aws_ecs_task_definition.task.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 200
  launch_type                        = var.launch_type

}

resource "aws_cloudwatch_log_group" "aws_logs" {
  name              = "/ecs/${var.service_name}"
  retention_in_days = 14
}

resource "aws_ecs_task_definition" "task" {
  family                   = var.service_name
  cpu                      = var.ecs_cpu
  memory                   = var.ecs_memory
  execution_role_arn       = aws_iam_role.ecs-execution.arn
  task_role_arn            = aws_iam_role.task-execution.arn
  network_mode             = "awsvpc"
  requires_compatibilities = [var.launch_type]

  dynamic "volume" {
    for_each = var.container_volumes

    content {
      name = volume.value
    }
  }

  container_definitions = jsonencode([merge(
    {
      name  = lower(var.service_name)
      image = "${var.container_image}:${var.container_version}"
      logConfiguration : {
        logDriver : "awslogs",
        options : {
          "awslogs-group" : aws_cloudwatch_log_group.aws_logs.name,
          "awslogs-region" : var.region,
          "awslogs-stream-prefix" : "ecs"
        }
      }
    }, var.container_definitions)
  ])
}