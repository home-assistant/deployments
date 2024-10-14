resource "cloudflare_load_balancer_pool" "stun-server" {
  account_id  = var.cloudflare_account_id
  name        = "stun-${data.aws_region.current.name}"
  description = "Stun server pool for ${data.aws_region.current.name}"
  latitude    = var.cloudflare_load_balancer_pool_latitude
  longitude   = var.cloudflare_load_balancer_pool_longitude
  monitor     = var.cloudflare_load_balancer_monitor_id

  origins {
    name    = "stun-${data.aws_region.current.name}-pool"
    address = aws_lb.main.dns_name
    weight  = 1
  }

  origin_steering {
    policy = "random"
  }
}
