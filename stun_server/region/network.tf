resource "aws_security_group" "stun_sg" {
  vpc_id = local.infrastructure_region_outputs.network_id

  tags = {
    Region = data.aws_region.current.name
    Zone   = "public"
  }
}

resource "aws_vpc_security_group_egress_rule" "stun_sg_egress" {
  security_group_id = aws_security_group.stun_sg.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "stun_sg_ingress_tcp" {
  security_group_id = aws_security_group.stun_sg.id

  from_port   = 3478
  to_port     = 3478
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "stun_sg_ingress_udp" {
  security_group_id = aws_security_group.stun_sg.id

  from_port   = 3478
  to_port     = 3478
  ip_protocol = "udp"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_lb" "main" {
  name               = local.service_name
  internal           = false
  load_balancer_type = "network"

  subnets = local.infrastructure_region_outputs.public_subnets

  tags = {
    Region = data.aws_region.current.name
    Zone   = "public"
  }
}

resource "aws_lb_listener" "tcp" {
  load_balancer_arn = aws_lb.main.arn
  port              = 3478
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tcp.arn
  }

  depends_on = [
    aws_lb_target_group.tcp,
    aws_lb.main,
  ]
}

resource "aws_lb_listener" "udp" {
  load_balancer_arn = aws_lb.main.arn
  port              = 3478
  protocol          = "UDP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.udp.arn
  }

  depends_on = [
    aws_lb_target_group.udp,
    aws_lb.main,
  ]
}

resource "aws_lb_target_group" "tcp" {
  port                 = 3478
  protocol             = "TCP"
  vpc_id               = local.infrastructure_region_outputs.network_id
  target_type          = "ip"
  deregistration_delay = 60

  health_check {
    protocol            = "TCP"
    interval            = 10
    unhealthy_threshold = 2
    healthy_threshold   = 2
  }

  tags = {
    Region = data.aws_region.current.name
    Zone   = "public"
  }
}

resource "aws_lb_target_group" "udp" {
  port                 = 3478
  protocol             = "UDP"
  vpc_id               = local.infrastructure_region_outputs.network_id
  target_type          = "ip"
  deregistration_delay = 60

  health_check {
    protocol            = "TCP"
    interval            = 10
    unhealthy_threshold = 2
    healthy_threshold   = 2
  }

  tags = {
    Region = data.aws_region.current.name
    Zone   = "public"
  }
}
