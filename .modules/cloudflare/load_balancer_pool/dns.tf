resource "cloudflare_load_balancer_pool" "pool" {
  account_id  = var.cloudflare_account_id
  name        = "${var.pool_name}-${var.region}"
  description = "${var.pool_name} pool for ${var.region}"
  latitude    = var.pool_latitude
  longitude   = var.pool_longitude
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
