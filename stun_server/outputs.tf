output "stun_server_ip-us_east_1" {
  description = "The public IP address of the stun server in us-east-1"
  value       = module.us_east_1.stun_server_ip
}

output "stun_server_ip-eu_central_1" {
  description = "The public IP address of the stun server in eu-central-1"
  value       = module.eu_central_1.stun_server_ip
}

output "stun_server_ip-ap_southeast_1" {
  description = "The public IP address of the stun server in ap-southeast-1"
  value       = module.ap_southeast_1.stun_server_ip
}
