data "cloudflare_zone" "dns_zone" {
  name = var.domain_name
}

resource "cloudflare_record" "instance_dns" {
  zone_id = data.cloudflare_zone.dns_zone.id
  name    = "" # TODO: Add the subdomain
  content = data.aws_network_interface.stun_server_interface.association[0].public_ip
  type    = "A"
  proxied = true
}
