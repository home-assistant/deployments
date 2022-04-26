terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "cas_validator"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
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

module "example" {
  source       = "../.modules/webservice"

  service_name = "CAS_Validator"
  domain_name = var.domain_name
  container_image = "codenotary/immuproof"
  port = 8091
}
