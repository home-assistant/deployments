data "cloudflare_zone" "dns_zone" {
  name = var.domain_name
}

resource "cloudflare_record" "community" {
  zone_id = data.cloudflare_zone.dns_zone.id
  name    = "community"
  value   = aws_eip.discourse.public_ip
  type    = "A"
  proxied = true
}
