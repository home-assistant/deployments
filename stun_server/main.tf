terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "stun_server"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "us_east_1" {
  source = "./region"

  region                  = "us-east-1"
  domain_name             = var.domain_name
  image_tag               = var.image_tag
  ecs_execution_role      = aws_iam_role.ecs-execution.name
  ecs_task_execution_role = aws_iam_role.task-execution.name
}

module "eu_central_1" {
  source = "./region"

  region                  = "eu-central-1"
  domain_name             = var.domain_name
  image_tag               = var.image_tag
  ecs_execution_role      = aws_iam_role.ecs-execution.name
  ecs_task_execution_role = aws_iam_role.task-execution.name
}

module "ap_southeast_1" {
  source = "./region"

  region                  = "ap-southeast-1"
  domain_name             = var.domain_name
  image_tag               = var.image_tag
  ecs_execution_role      = aws_iam_role.ecs-execution.name
  ecs_task_execution_role = aws_iam_role.task-execution.name
}
