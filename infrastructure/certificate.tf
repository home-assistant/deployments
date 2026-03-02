data "cloudflare_zone" "dns_zone" {
  name = var.domain_name
}

resource "aws_acm_certificate" "cert_instance" {
  domain_name       = "*.${var.domain_name}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_record" "dns_instance_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert_instance.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = data.cloudflare_zone.dns_zone.id
  name    = each.value.name
  content = trimsuffix(each.value.record, ".")
  type    = each.value.type
  ttl     = 1
  proxied = false
}

resource "aws_acm_certificate_validation" "cert_instance_validation" {
  certificate_arn         = aws_acm_certificate.cert_instance.arn
  validation_record_fqdns = [for record in cloudflare_record.dns_instance_validation : record.hostname]
}
