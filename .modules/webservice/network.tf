resource "aws_security_group" "lb_sg" {
  vpc_id = data.tfe_outputs.infrastructure.values[var.region].network_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS traffic"
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Region = var.region
    Zone   = "public"
  }
}

resource "aws_security_group" "container_sg" {
  vpc_id = data.tfe_outputs.infrastructure.values[var.region].network_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Web traffic"
    from_port   = var.port
    protocol    = "tcp"
    to_port     = var.port
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Region = var.region
    Zone   = "private"
  }
}

resource "aws_alb" "main" {
  name               = var.service_name
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.lb_sg.id]
  subnets         = data.tfe_outputs.infrastructure.values[var.region].public_subnets

  idle_timeout = "60"

  tags = {
    Region = var.region
    Zone   = "public"
  }
}

resource "aws_lb_listener" "front_end" {
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.internal.arn
  }

  load_balancer_arn = aws_alb.main.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = data.tfe_outputs.infrastructure.values.certification_arn

  depends_on = [
    aws_lb_target_group.internal,
    aws_alb.main,
  ]
}

resource "aws_lb_target_group" "internal" {
  port                 = var.port
  protocol             = "HTTP"
  vpc_id               = data.tfe_outputs.infrastructure.values[var.region].network_id
  target_type          = "ip"
  deregistration_delay = 600


  health_check {
    path                = var.healthcheck_path
    matcher             = "200"
    interval            = 10
    timeout             = 5
    unhealthy_threshold = 2
    healthy_threshold   = 2
  }

  tags = {
    Region = var.region
  }
}