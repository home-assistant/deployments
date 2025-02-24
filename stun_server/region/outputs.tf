output "cloudflare_load_balancer_pool_id" {
  description = "Cloudflare Load Balancer Pool Id"
  value       = module.cloudflare_load_balancer_pool.load_balancer_pool_id
}
