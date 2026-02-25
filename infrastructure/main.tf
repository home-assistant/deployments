terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "infrastructure"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "us_east_1" {
  source             = "./region"
  region             = "us-east-1"
  ecs_policy         = aws_iam_instance_profile.ecs_instance_profile.arn
  network_cidr       = var.network_cidr["us-east-1"]
  domain_name        = var.domain_name
  cloudflare_zone_id = data.cloudflare_zone.dns_zone.id
}

module "eu_central_1" {
  source             = "./region"
  region             = "eu-central-1"
  ecs_policy         = aws_iam_instance_profile.ecs_instance_profile.arn
  network_cidr       = var.network_cidr["eu-central-1"]
  domain_name        = var.domain_name
  cloudflare_zone_id = data.cloudflare_zone.dns_zone.id
}

module "ap_southeast_1" {
  source             = "./region"
  region             = "ap-southeast-1"
  ecs_policy         = aws_iam_instance_profile.ecs_instance_profile.arn
  network_cidr       = var.network_cidr["ap-southeast-1"]
  domain_name        = var.domain_name
  cloudflare_zone_id = data.cloudflare_zone.dns_zone.id
}
