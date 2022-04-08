resource "aws_ecs_service" "webservice" {
  name                               = var.service_name
  cluster                            = data.tfe_outputs.infrastructure.values[var.region].ecs_cluster
  task_definition                    = module.webservice.task_definition
  desired_count                      = 1
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 200
  health_check_grace_period_seconds  = 90
  launch_type                        = var.launch_type

  network_configuration {
    subnets         = data.tfe_outputs.infrastructure.values[var.region].private_subnets
    security_groups = [aws_security_group.container_sg.id]
  }

  depends_on = [
    aws_lb_target_group.internal,
    aws_lb_listener.front_end,
  ]

  load_balancer {
    container_name   = lower(var.service_name)
    container_port   = var.port
    target_group_arn = aws_lb_target_group.internal.arn
  }
}