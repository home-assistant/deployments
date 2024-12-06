resource "aws_ecs_service" "stun-server-tcp" {
  name                               = "${local.service_name}-tcp"
  cluster                            = local.infrastructure_region_outputs.ecs_cluster
  task_definition                    = module.stun_server_tcp.task_definition
  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  launch_type                        = "FARGATE"
  depends_on                         = [aws_lb_listener.stun_80, aws_lb_listener.stun_3478]

  network_configuration {
    security_groups = [aws_security_group.stun_sg.id]
    subnets         = local.infrastructure_region_outputs.private_subnets
  }

  load_balancer {
    container_name   = "${local.service_name}-tcp"
    container_port   = "3478"
    target_group_arn = aws_lb_target_group.stun.arn
  }

  tags = {
    region = data.aws_region.current.name
  }
}

resource "aws_ecs_service" "stun-server-udp" {
  name                               = "${local.service_name}-udp"
  cluster                            = local.infrastructure_region_outputs.ecs_cluster
  task_definition                    = module.stun_server_udp.task_definition
  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  launch_type                        = "FARGATE"
  depends_on                         = [aws_lb_listener.stun_80, aws_lb_listener.stun_3478]

  network_configuration {
    security_groups = [aws_security_group.stun_sg.id]
    subnets         = local.infrastructure_region_outputs.private_subnets
  }

  load_balancer {
    container_name   = "${local.service_name}-udp"
    container_port   = "3478"
    target_group_arn = aws_lb_target_group.stun.arn
  }

  tags = {
    region = data.aws_region.current.name
  }
}
