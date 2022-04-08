data "cloudflare_zone" "dns_zone" {
  name = var.domain_name
}

resource "cloudflare_record" "instance_dns" {
  zone_id = data.cloudflare_zone.dns_zone.id
  name    = coalesce(var.subdomain, lower(var.service_name))
  value   = aws_alb.main.dns_name
  type    = "CNAME"
  ttl     = 1
  proxied = true
}