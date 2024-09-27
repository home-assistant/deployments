terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "ios_pushserver"
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

module "webservice_ios_pushserver" {
  source = "../.modules/webservice"

  service_name      = "iOS-PushServer"
  container_image   = "ghcr.io/home-assistant/ios-pushserver"
  container_version = "0.1.0"
  port              = 8080

  container_definitions = {
    environment : [
      { name : "APNS_TOPIC", value : var.apns_topic },
      { name : "APNS_KEY_CONTENTS", value : var.apns_key_contents },
      { name : "APNS_KEY_IDENTIFIER", value : var.apns_key_identifier },
      { name : "APNS_KEY_TEAM_IDENTIFIER", value : var.apns_key_team_identifier }
    ]
  }
}
