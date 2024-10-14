output "cloudflare_load_balancer_pool_id" {
  description = "The ID of the Cloudflare Load Balancer Pool"
  value       = cloudflare_load_balancer_pool.stun-server.id
}
