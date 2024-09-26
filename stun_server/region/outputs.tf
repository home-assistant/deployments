output "stun_server_ip" {
  description = "The public IP address of the stun server"
  value       = data.aws_network_interface.stun_server_interface.association[0].public_ip
}
