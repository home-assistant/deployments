terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "marketplace_demo"
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
  region = "us-east-1"

  default_tags {
    tags = {
      application = "marketplace-demo"
    }
  }
}

data "tfe_outputs" "infrastructure" {
  organization = "home_assistant"
  workspace    = "infrastructure"
}

module "webservice_marketplace_demo" {
  source = "../.modules/webservice"

  service_name      = "Marketplace-Demo"
  container_image   = "ghcr.io/home-assistant/marketplace-demo"
  container_version = var.image_tag
  port              = 8123
  cloudflare_proxy  = false
  ecs_memory        = 3072

  container_definitions = {
    environment = [
      {
        name  = "DEFAULT_USERS"
        value = var.default_users
      }
    ]
  }
}
