resource "aws_ecs_service" "stun-server" {
  name                               = local.service_name
  cluster                            = local.infrastructure_region_outputs.ecs_cluster
  task_definition                    = module.stun_server.task_definition
  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  launch_type                        = "FARGATE"
  depends_on                         = [aws_lb_listener.tcp, aws_lb_listener.udp]

  network_configuration {
    assign_public_ip = false
    security_groups  = [aws_security_group.stun_sg.id]
    subnets          = local.infrastructure_region_outputs.private_subnets
  }

  load_balancer {
    container_name   = local.service_name
    container_port   = "3478"
    target_group_arn = aws_lb_target_group.tcp.arn
  }

  load_balancer {
    container_name   = local.service_name
    container_port   = "3478"
    target_group_arn = aws_lb_target_group.udp.arn
  }

  tags = {
    region = data.aws_region.current.name
  }
}
