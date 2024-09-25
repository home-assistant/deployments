terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "infrastructure"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "us_east_1" {
  source       = "./region"
  region       = "us-east-1"
  ecs_policy   = aws_iam_instance_profile.ecs_instance_profile.arn
  network_cidr = var.network_cidr["us-east-1"]
}
