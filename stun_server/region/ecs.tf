resource "aws_ecs_service" "stun-server" {
  name                               = local.service_name
  cluster                            = data.tfe_outputs.infrastructure.values[data.aws_region.current.name].ecs_cluster
  task_definition                    = module.stun_server.task_definition
  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  health_check_grace_period_seconds  = 90
  launch_type                        = local.launch_type

  # Required to fetch the public IP address of the ECS service
  enable_ecs_managed_tags = true
  wait_for_steady_state   = true

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.stun_sg.id]
    subnets = [
      data.tfe_outputs.infrastructure.values[data.aws_region.current.name].public_subnets[0],
      data.tfe_outputs.infrastructure.values[data.aws_region.current.name].public_subnets[1]
    ]
  }
}

data "aws_network_interface" "stun_server_interface" {
  filter {
    name   = "tag:aws:ecs:serviceName"
    values = [aws_ecs_service.stun-server.name]
  }
}
