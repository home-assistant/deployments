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

module "us_east_1" {
  source = "./region"

  region    = "us-east-1"
  image_tag = var.image_tag
}

module "eu_central_1" {
  source = "./region"

  region    = "eu-central-1"
  image_tag = var.image_tag
}

module "ap_southeast_1" {
  source = "./region"

  region    = "ap-southeast-1"
  image_tag = var.image_tag
}
