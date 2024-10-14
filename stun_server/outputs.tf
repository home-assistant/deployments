output "endpoint" {
  description = "Endpoint of the Stun server"
  value       = cloudflare_load_balancer.stun-server.name
}
