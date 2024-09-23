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

output "eu-central-1" {
  description = "Outputs for the eu-central-1 region"
  value = {
    "public_subnets" : module.eu_central_1.public_subnets,
    "private_subnets" : module.eu_central_1.private_subnets,
    "ecs_cluster" : module.eu_central_1.ecs_cluster,
    "network_id" : module.eu_central_1.network_id,
  }
}

output "ap-southeast-1" {
  description = "Outputs for the ap-southeast-1 region"
  value = {
    "public_subnets" : module.ap_southeast_1.public_subnets,
    "private_subnets" : module.ap_southeast_1.private_subnets,
    "ecs_cluster" : module.ap_southeast_1.ecs_cluster,
    "network_id" : module.ap_southeast_1.network_id,
  }
}
