output "certification_arn" {
  description = "The ARN for the wildcard certificate"
  value       = aws_acm_certificate.cert_instance.arn
}

output "us-east-1" {
  description = "Outputs for the us-east-1 region"
  value = {
    "public_subnets" : module.us_east_1.public_subnets,
    "private_subnets" : module.us_east_1.private_subnets,
    "ecs_cluster" : module.us_east_1.ecs_cluster,
    "network_id" : module.us_east_1.network_id,
  }
}
