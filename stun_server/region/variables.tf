variable "region" {
  description = "The region to deploy the STUN server to"
  type        = string

}

variable "domain_name" {
  description = "The base domain name"
  type        = string
}

variable "subdomain" {
  description = "The subdomain to use for the STUN server"
  type        = string
}
variable "image_tag" {
  description = "Version of the Stun server to deploy"
  type        = string
}
