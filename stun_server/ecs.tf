resource "aws_ecs_service" "stun-server" {
  name = "stun-server"

  cluster         = data.tfe_outputs.infrastructure.values.ecs_cluster
  task_definition = aws_ecs_task_definition.stun-server.arn
  count           = 1
  desired_count   = 1

  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  health_check_grace_period_seconds  = 90
  launch_type                        = "FARGATE"

  # Required to fetch the public IP address of the ECS service
  enable_ecs_managed_tags = true
  wait_for_steady_state   = true

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.stun_sg.id]
    subnets = [
      data.tfe_outputs.infrastructure.values.public_subnets[0],
      data.tfe_outputs.infrastructure.values.public_subnets[1]
    ]
  }
}

data "aws_network_interface" "stun_server_interface" {
  filter {
    name   = "tag:aws:ecs:serviceName"
    values = [aws_ecs_service.stun-server.name]
  }
}

resource "aws_cloudwatch_log_group" "aws_logs" {
  name              = "/ecs/stun-server"
  retention_in_days = 14
}

resource "aws_ecs_task_definition" "stun-server" {
  family = "stun-server"

  count  = 1
  cpu    = 2048
  memory = 4096

  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }

  container_definitions = jsonencode([
    {
      name      = "stun-server"
      image     = "ghcr.io/home-assistant/stun:${var.image_tag}"
      cpu       = 2048
      memory    = 4096
      essential = true

      portMappings = [
        {
          containerPort = 3478
          hostPort      = 3478
          protocol      = "tcp"
        },
        {
          containerPort = 3478
          hostPort      = 3478
          protocol      = "udp"
        }
      ],

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/stun-server"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}
