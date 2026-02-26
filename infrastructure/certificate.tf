data "cloudflare_zone" "dns_zone" {
  name = var.domain_name
}

# DNS validation record — created once at the root level since ACM reuses
# the same CNAME for the same domain across regions within the same account.
resource "cloudflare_record" "dns_instance_validation" {
  for_each = {
    for dvo in module.us_east_1.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id         = data.cloudflare_zone.dns_zone.id
  name            = each.value.name
  content         = trimsuffix(each.value.record, ".")
  type            = each.value.type
  ttl             = 1
  proxied         = false
  allow_overwrite = false
}

moved {
  from = aws_acm_certificate.cert_instance
  to   = module.us_east_1.aws_acm_certificate.cert_instance
}

moved {
  from = aws_acm_certificate_validation.cert_instance_validation
  to   = module.us_east_1.aws_acm_certificate_validation.cert_instance_validation
}
