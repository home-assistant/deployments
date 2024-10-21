variable "region" {
  description = "AWS region associated with the resources of the Cloudflare Load Balancer Pool"
  type        = string
}

variable "cloudflare_account_id" {
  description = "Cloudflare Account Id"
  type        = string
}

variable "pool_name" {
  description = "Cloudflare Load Balancer Pool Name"
  type        = string
}

variable "pool_endpoint" {
  description = "Cloudflare Load Balancer Pool Endpoint"
  type        = string
}

variable "load_balancer_monitor_id" {
  description = "Cloudflare Load Balancer Monitor Id"
  type        = string
}
