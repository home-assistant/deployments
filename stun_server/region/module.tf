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

module "stun_server" {
  source = "../../.modules/service"

  service_name      = local.service_name
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
      },
      {
        containerPort = 3478
        hostPort      = 3478
        protocol      = "udp"
      }
    ],
  }
  webservice                           = true
  create_policies                      = false
  external_ecs_execution_role_arn      = var.ecs_execution_role_arn
  external_ecs_task_execution_role_arn = var.ecs_task_execution_role_arn
}
