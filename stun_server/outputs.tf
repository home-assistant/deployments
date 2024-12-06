output "endpoints" {
  description = "Endpoints of the Stun server"
  value = {
    "us-east-1"      = module.us_east_1.stun_server_endpoint
    "eu-central-1"   = module.eu_central_1.stun_server_endpoint
    "ap-southeast-1" = module.ap_southeast_1.stun_server_endpoint
  }
}
