output "image_tag" {
  description = "The image tag in use by the deployment"
  value       = var.image_tag
}

output "fqdn" {
  description = "FQDN of the service"
  value       = module.webservice_product_demo.fqdn
}

output "configuration_yaml" {
  description = "Content of configuration.yaml in use by the deployment"
  value       = var.configuration_yaml
}
