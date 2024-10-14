output "load_balancer_endpoint" {
  value = cloudflare_load_balancer.load_balancer.name
}

output "load_balancer_monitor_id" {
  value = cloudflare_load_balancer_monitor.monitor.id
}
