data "cloudflare_zone" "dns_zone" {
  name = var.domain_name
}
