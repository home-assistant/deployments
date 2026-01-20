output "fqdn" {
  description = "FQDN of the webservice"
  value = cloudflare_record.instance_dns.hostname
}
