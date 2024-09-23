locals {
  service_name = "stun-server"
  launch_type  = "FARGATE"
}

data "tfe_outputs" "infrastructure" {
  organization = "home_assistant"
  workspace    = "infrastructure"
}

module "stun_server" {
  source = "../../.modules/service"

  service_name      = local.service_name
  container_image   = "ghcr.io/home-assistant/stun-server"
  container_version = var.image_tag
  launch_type       = local.launch_type
  region            = var.region
  ecs_cpu           = 2048
  ecs_memory        = 4096
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
  webservice      = true
  rolling_updates = true
}
