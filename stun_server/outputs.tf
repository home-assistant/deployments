output "ip" {
  description = "The public IP address of the stun server"
  value = {
    "us-east-1"      = module.us_east_1.stun_server_ip
    "eu-central-1"   = module.eu_central_1.stun_server_ip
    "ap-southeast-1" = module.ap_southeast_1.stun_server_ip
  }
}
