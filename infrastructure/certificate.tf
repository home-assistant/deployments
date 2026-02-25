data "cloudflare_zone" "dns_zone" {
  name = var.domain_name
}

moved {
  from = aws_acm_certificate.cert_instance
  to   = module.us_east_1.aws_acm_certificate.cert_instance
}

moved {
  from = cloudflare_record.dns_instance_validation
  to   = module.us_east_1.cloudflare_record.dns_instance_validation
}

moved {
  from = aws_acm_certificate_validation.cert_instance_validation
  to   = module.us_east_1.aws_acm_certificate_validation.cert_instance_validation
}
