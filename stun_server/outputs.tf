output "endpoint" {
  description = "Endpoint of the Stun server"
  value       = module.cloudflare_load_balancer.load_balancer_endpoint
}
