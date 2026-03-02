resource "aws_acm_certificate" "cert_instance" {
  domain_name       = "*.${var.domain_name}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "cert_instance_validation" {
  certificate_arn         = aws_acm_certificate.cert_instance.arn
  validation_record_fqdns = var.certificate_validation_fqdns
}