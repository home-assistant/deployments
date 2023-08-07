terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "assist"
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
