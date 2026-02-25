output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}

output "ecs_cluster" {
  value = aws_ecs_cluster.svcs.id
}

output "network_id" {
  value = aws_vpc.network.id
}

output "certification_arn" {
  description = "The ARN for the wildcard certificate in this region"
  value       = aws_acm_certificate.cert_instance.arn
}
