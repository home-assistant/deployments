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

import {
  to = module.cloudflare_load_balancer.cloudflare_load_balancer.load_balancer
  id = "${data.cloudflare_zone.dns_zone.id}/3e9afe7fac269375a9e371c7c41cf3da"
}

import {
  to = module.cloudflare_load_balancer.cloudflare_load_balancer_monitor.monitor
  id = "${var.CLOUDFLARE_ACCOUNT_ID}/9f1f73919056954a660d29a5511dd57b"
}

import {
  to = module.us_east_1.module.cloudflare_load_balancer_pool.cloudflare_load_balancer_pool.pool
  id = "${var.CLOUDFLARE_ACCOUNT_ID}/abd4bc10bc961fb472442b3784545be3"
}

import {
  to = module.eu_central_1.module.cloudflare_load_balancer_pool.cloudflare_load_balancer_pool.pool
  id = "${var.CLOUDFLARE_ACCOUNT_ID}/b99c549ecfe01f068bdfdda8d08677be"
}

import {
  to = module.ap_southeast_1.module.cloudflare_load_balancer_pool.cloudflare_load_balancer_pool.pool
  id = "${var.CLOUDFLARE_ACCOUNT_ID}/b62889bd0bc43b9a4167ae7da754a1ea"
}

module "cloudflare_load_balancer" {
  source = "../.modules/cloudflare/load_balancer"

  cloudflare_account_id = var.CLOUDFLARE_ACCOUNT_ID
  domain_name           = var.domain_name
  subdomain             = "stun"
  pool_ids = [
    module.us_east_1.cloudflare_load_balancer_pool_id,
    module.eu_central_1.cloudflare_load_balancer_pool_id,
    module.ap_southeast_1.cloudflare_load_balancer_pool_id,
  ]
  monitoring_port = 80
}

module "us_east_1" {
  source = "./region"

  region                              = "us-east-1"
  cloudflare_account_id               = var.CLOUDFLARE_ACCOUNT_ID
  cloudflare_load_balancer_monitor_id = module.cloudflare_load_balancer.load_balancer_monitor_id
  image_tag                           = var.image_tag
}

module "eu_central_1" {
  source = "./region"

  region                              = "eu-central-1"
  cloudflare_account_id               = var.CLOUDFLARE_ACCOUNT_ID
  cloudflare_load_balancer_monitor_id = module.cloudflare_load_balancer.load_balancer_monitor_id
  image_tag                           = var.image_tag
}

module "ap_southeast_1" {
  source = "./region"

  region                              = "ap-southeast-1"
  cloudflare_account_id               = var.CLOUDFLARE_ACCOUNT_ID
  cloudflare_load_balancer_monitor_id = module.cloudflare_load_balancer.load_balancer_monitor_id
  image_tag                           = var.image_tag
}
