terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "nabucasa"

    workspaces {
      prefix = "assist-"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
