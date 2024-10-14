variable "cloudflare_account_id" {
  description = "Cloudflare Account Id"
  type        = string
}

variable "domain_name" {
  description = "Domain name for the load balancer"
  type        = string
}

variable "subdomain" {
  description = "Subdomain for the load balancer"
  type        = string
}

variable "pool_ids" {
  description = "List of Cloudflare Load Balancer Pool Ids"
  type        = list(string)
}

variable "default_pool_ids_index" {
  description = "Index of the default pool in the pool_ids list"
  type        = number
  default     = 0
}

variable "monitoring_port" {
  description = "Port used for monitoring by the load balancer"
  type        = number
}
