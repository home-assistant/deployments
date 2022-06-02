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
  container_image   = "ghcr.io/home-assistant/private-demo"
  container_version = "2022.5.5"
  port              = 8123

  container_volumes = [
    "private_demo_config"
  ]

  container_definitions = {
    mountPoints : [
      {
        sourceVolume : "private_demo",
        containerPath : "/config"
      }
    ]
  }
}
