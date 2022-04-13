
resource "cloudflare_record" "_checkdns" {
  zone_id = data.cloudflare_zone.dns_zone.id
  name    = "_checkdns"
  value   = "127.0.0.1"
  type    = "A"
  ttl     = 1
  proxied = false
}