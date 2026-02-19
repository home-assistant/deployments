terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "product_demo"
    }
  }

  required_version = "~> 1.14.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"

  default_tags {
    tags = {
      application = "product-demo"
    }
  }
}

data "tfe_outputs" "infrastructure" {
  organization = "home_assistant"
  workspace    = "infrastructure"
}

module "webservice_product_demo" {
  source = "../.modules/webservice"

  service_name      = "Product-Demo"
  container_image   = "ghcr.io/home-assistant/home-assistant"
  container_version = var.image_tag
  port              = 8123
  cloudflare_proxy  = false
  ecs_memory        = 2048

  container_volumes = [
    { name : "product_demo_config",
      efs_volume_configuration : [
        {
          file_system_id : aws_efs_file_system.efs.id,
        }
      ],
    }
  ]

  container_definitions = {
    entryPoint : [
      "/bin/bash", "-c",
      "echo '${base64encode(var.configuration_yaml)}' | base64 -d > /config/configuration.yaml && exec /init"
    ],
    mountPoints : [
      {
        sourceVolume : "product_demo_config",
        containerPath : "/config"
      }
    ]
  }
}
