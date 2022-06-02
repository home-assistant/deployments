terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "private_demo"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "webservice_private_demo" {
  source = "../.modules/webservice"

  service_name      = "Private-Demo"
  container_image   = "ghcr.io/home-assistant/home-assistant"
  container_version = "2022.6.0"
  port              = 8123

  volume = {
    name = "private_demo"
    host_path = "/ecs/private_demo"
  }

  container_definitions = {
    mountPoints: [
      {
        sourceVolume: "private_demo",
        containerPath: "/config"
      }
    ]
  }
}
