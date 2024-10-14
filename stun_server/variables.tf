variable "CLOUDFLARE_ACCOUNT_ID" {
  description = "Cloudflare Account Id"
  type        = string
}

variable "domain_name" {
  description = "The base domain name"
  type        = string
}

variable "image_tag" {
  description = "Version of the Stun server to deploy"
  type        = string
}
