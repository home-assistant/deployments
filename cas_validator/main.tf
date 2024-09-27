terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "cas_validator"
    }
  }

  required_version = "= 1.9.6"

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
}

module "webservice_cas_validator" {
  source = "../.modules/webservice"

  service_name      = "CAS-Validator"
  subdomain         = "cas-validator"
  container_image   = "codenotary/immuproof"
  container_version = "v0.0.11"
  port              = 8091

  container_definitions = {
    environment : [
      { name : "IMMUPROOF_HOST", value : "cas.codenotary.com" },
      { name : "IMMUPROOF_PORT", value : "443" },
      { name : "IMMUPROOF_API_KEY", value : var.cas_api_key },
      { name : "IMMUPROOF_WEB_TITLE_TEXT", value : "Home Assistant service validator" },
      { name : "IMMUPROOF_WEB_HOSTED_BY_TEXT", value : "Home Assistant Community" },
      { name : "IMMUPROOF_WEB_HOSTED_BY_LOGO_URL", value : "https://www.home-assistant.io/images/home-assistant-logo.svg" }
    ]
  }
}
