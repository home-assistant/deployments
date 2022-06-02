data "tfe_outputs" "infrastructure" {
  organization = "home_assistant"
  workspace    = "infrastructure"
}

module "webservice" {
  source = "../service"

  service_name      = var.service_name
  container_image   = var.container_image
  container_version = var.container_version
  launch_type       = var.launch_type
  region            = var.region
  ecs_cpu           = var.ecs_cpu
  ecs_memory        = var.ecs_memory
  webservice        = true
  container_volume  = var.container_volume
  container_definitions = merge({
    portMappings = [
      {
        containerPort = var.port
        hostPort      = var.port
      }
    ],
  }, var.container_definitions)
}