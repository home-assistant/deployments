locals {
  service_name                  = "stun-server"
  infrastructure_region_outputs = data.tfe_outputs.infrastructure.values[data.aws_region.current.name]
}

provider "aws" {
  region = var.region
}

data "tfe_outputs" "infrastructure" {
  organization = "home_assistant"
  workspace    = "infrastructure"
}

data "aws_region" "current" {}

module "cloudflare_load_balancer_pool" {
  source = "../../.modules/cloudflare/load_balancer_pool"

  region                   = data.aws_region.current.name
  cloudflare_account_id    = var.cloudflare_account_id
  pool_name                = "stun"
  pool_latitude            = var.cloudflare_load_balancer_pool_latitude
  pool_longitude           = var.cloudflare_load_balancer_pool_longitude
  pool_endpoint            = aws_lb.main.dns_name
  load_balancer_monitor_id = var.cloudflare_load_balancer_monitor_id
}

module "stun_server_tcp" {
  source = "../../.modules/service"

  service_name      = "${local.service_name}-tcp"
  container_image   = "ghcr.io/home-assistant/stun"
  container_version = var.image_tag
  region            = data.aws_region.current.name
  ecs_cpu           = 512
  ecs_memory        = 1024
  container_definitions = {
    portMappings = [
      {
        containerPort = 3478
        hostPort      = 3478
        protocol      = "tcp"
      }
    ],
  }
  webservice = true
}

module "stun_server_udp" {
  source = "../../.modules/service"

  service_name      = "${local.service_name}-udp"
  container_image   = "ghcr.io/home-assistant/stun"
  container_version = var.image_tag
  region            = data.aws_region.current.name
  ecs_cpu           = 512
  ecs_memory        = 1024
  container_definitions = {
    portMappings = [
      {
        containerPort = 3478
        hostPort      = 3478
        protocol      = "udp"
      }
    ],
  }
  webservice = true
}
