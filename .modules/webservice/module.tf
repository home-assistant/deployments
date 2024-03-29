data "tfe_outputs" "infrastructure" {
  organization = "home_assistant"
  workspace    = "infrastructure"
}

module "webservice" {
  source = "../service"

  service_name           = var.service_name
  container_image        = var.container_image
  container_version      = var.container_version
  launch_type            = var.launch_type
  rolling_updates        = var.rolling_updates
  region                 = var.region
  ecs_cpu                = var.ecs_cpu
  ecs_memory             = var.ecs_memory
  webservice             = true
  task_policy_statements = var.task_policy_statements
  container_volumes      = var.container_volumes
  container_definitions = merge({
    portMappings = [
      {
        containerPort = var.port
        hostPort      = var.port
      }
    ],
  }, var.container_definitions)
}