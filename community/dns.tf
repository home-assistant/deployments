resource "cloudflare_record" "community" {
  zone_id = data.cloudflare_zone.dns_zone.id
  name    = "community"
  value   = aws_eip.discourse.public_ip
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "community_direct" {
  zone_id = data.cloudflare_zone.dns_zone.id
  name    = "community-direct"
  value   = aws_eip.discourse.public_ip
  type    = "A"
  proxied = false
}

