output "stun_server_endpoint" {
  description = "Endpoint of the Stun server"
  value       = aws_lb.main.dns_name
}
