terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "home_assistant"

    workspaces {
      prefix = "assist-"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
