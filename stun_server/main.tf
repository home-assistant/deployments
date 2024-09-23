terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "stun_server"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "tfe_outputs" "infrastructure" {
  organization = "home_assistant"
  workspace    = "infrastructure"
}
