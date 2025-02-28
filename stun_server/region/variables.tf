variable "region" {
  description = "The region to deploy the STUN server to"
  type        = string
}

variable "cloudflare_account_id" {
  description = "Cloudflare Account Id"
  type        = string
}

variable "cloudflare_load_balancer_monitor_id" {
  description = "Cloudflare Load Balancer Monitor Id"
  type        = string
}

variable "image_tag" {
  description = "Version of the Stun server to deploy"
  type        = string
}
