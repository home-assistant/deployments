resource "cloudflare_load_balancer" "load_balancer" {
  zone_id          = data.cloudflare_zone.dns_zone.id
  name             = "${var.subdomain}.${var.domain_name}"
  default_pool_ids = var.pool_ids
  fallback_pool_id = var.pool_ids[var.default_pool_ids_index]
  description      = "${var.subdomain} load balancer using proximity steering policy"

  proxied         = false
  steering_policy = "proximity"

  location_strategy {
    mode       = "pop"
    prefer_ecs = "proximity"
  }
}

resource "cloudflare_load_balancer_monitor" "monitor" {
  account_id = var.cloudflare_account_id
  type       = "tcp"
  port       = var.monitoring_port
  interval   = 60
  timeout    = 5
  retries    = 2
}
