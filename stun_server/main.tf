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

data "cloudflare_zone" "dns_zone" {
  name = var.domain_name
}

module "us_east_1" {
  source = "./region"

  region                                  = "us-east-1"
  cloudflare_account_id                   = var.CLOUDFLARE_ACCOUNT_ID
  cloudflare_load_balancer_pool_latitude  = 37.54129
  cloudflare_load_balancer_pool_longitude = -77.43477
  cloudflare_load_balancer_monitor_id     = cloudflare_load_balancer_monitor.stun-server.id
  image_tag                               = var.image_tag
}

module "eu_central_1" {
  source = "./region"

  region                                  = "eu-central-1"
  cloudflare_account_id                   = var.CLOUDFLARE_ACCOUNT_ID
  cloudflare_load_balancer_pool_latitude  = 50.1155
  cloudflare_load_balancer_pool_longitude = 8.6842
  cloudflare_load_balancer_monitor_id     = cloudflare_load_balancer_monitor.stun-server.id
  image_tag                               = var.image_tag
}

module "ap_southeast_1" {
  source = "./region"

  region                                  = "ap-southeast-1"
  cloudflare_account_id                   = var.CLOUDFLARE_ACCOUNT_ID
  cloudflare_load_balancer_pool_latitude  = 1.2897
  cloudflare_load_balancer_pool_longitude = 103.8501
  cloudflare_load_balancer_monitor_id     = cloudflare_load_balancer_monitor.stun-server.id
  image_tag                               = var.image_tag
}
