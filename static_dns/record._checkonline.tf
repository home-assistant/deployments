
resource "cloudflare_record" "_checkonline" {
  zone_id = data.cloudflare_zone.dns_zone.id
  name    = "_checkonline"
  value   = "version.${var.domain_name}"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}
