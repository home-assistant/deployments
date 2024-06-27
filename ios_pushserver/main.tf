terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "ios_pushserver"
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

module "webservice_ios_pushserver" {
  source = "../.modules/webservice"

  service_name      = "iOS-PushServer"
  container_image   = "ghcr.io/home-assistant/service-hub"
  container_version = var.service_hub_image_tag
  port              = 5000
  healthcheck_path  = "/__heartbeat__"
  rolling_updates   = true

  container_definitions = {
    command : [
      "start:apn:prod"
    ],
    environment : [
      { name : "APN_TOPIC", value : var.apns_topic },
      { name : "APN_CERTIFICATE", value : var.apns_key_contents },
      { name : "APN_KEY_ID", value : var.apns_key_identifier },
      { name : "APN_TEAM_ID", value : var.apns_key_team_identifier },
      { name : "SENTRY_DSN", value : var.sentry_dsn },
      { name : "NODE_ENV", value : "production" }
    ]
  }
}
