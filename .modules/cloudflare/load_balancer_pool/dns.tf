locals {
  geolocation = {
    "us-east-1" : {
      "latitude" : 37.54129,
      "longitude" : -77.43477
    },
    "eu-central-1" : {
      "latitude" : 50.1155,
      "longitude" : 8.6842
    },
    "ap-southeast-1" : {
      "latitude" : 1.2897,
      "longitude" : 103.8501
    }
  }
}

resource "cloudflare_load_balancer_pool" "pool" {
  account_id  = var.cloudflare_account_id
  name        = "${var.pool_name}-${var.region}"
  description = "${var.pool_name} pool for ${var.region}"
  latitude    = local.geolocation[var.region].latitude
  longitude   = local.geolocation[var.region].longitude
  monitor     = var.load_balancer_monitor_id

  origins {
    name    = "${var.pool_name}-${var.region}-pool"
    address = var.pool_endpoint
    weight  = 1
  }

  origin_steering {
    policy = "random"
  }
}
