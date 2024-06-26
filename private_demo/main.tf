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

data "tfe_outputs" "infrastructure" {
  organization = "home_assistant"
  workspace    = "infrastructure"
}

module "webservice_private_demo" {
  source = "../.modules/webservice"

  service_name      = "Private-Demo"
  container_image   = "ghcr.io/home-assistant/private-demo"
  container_version = var.image_tag
  port              = 8123
  cloudflare_proxy  = false

  container_volumes = [
    { name : "private_demo_config",
      efs_volume_configuration : [
        {
          file_system_id : aws_efs_file_system.efs.id,
        }
      ],
    }
  ]

  container_definitions = {
    mountPoints : [
      {
        sourceVolume : "private_demo_config",
        containerPath : "/config"
      }
    ]
  }
}
