resource "cloudflare_load_balancer" "stun-server" {
  zone_id          = data.cloudflare_zone.dns_zone.id
  name             = "stun.${var.domain_name}"
  default_pool_ids = [module.us_east_1.cloudflare_load_balancer_pool_id, module.eu_central_1.cloudflare_load_balancer_pool_id, module.ap_southeast_1.cloudflare_load_balancer_pool_id]
  fallback_pool_id = module.us_east_1.cloudflare_load_balancer_pool_id
  description      = "Stun server load balancer using proximity steering policy"

  proxied         = false
  steering_policy = "proximity"

  location_strategy {
    mode       = "pop"
    prefer_ecs = "proximity"
  }
}

resource "cloudflare_load_balancer_monitor" "stun-server" {
  account_id = var.CLOUDFLARE_ACCOUNT_ID
  type       = "tcp"
  port       = 3478
  interval   = 60
  timeout    = 5
  retries    = 2
}
