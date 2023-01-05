terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "community"
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
  region = "us-west-2"
}

resource "aws_instance" "discourse" {
  id            = "i-0f10391ee5e9b9527"
  ami           = "ami-003634241a8fcdec0"
  instance_type = "m5a.4xlarge"
}
