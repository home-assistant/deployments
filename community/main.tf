terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "community"
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
  region = "us-west-2"
}
