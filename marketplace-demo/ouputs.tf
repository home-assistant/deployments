output "image_tag" {
  description = "The image tag in use by the deployment"
  value       = var.image_tag
}

output "fqdn" {
  description = "FQDN of the service"
  value = module.webservice_marketplace_demo.fqdn
}
