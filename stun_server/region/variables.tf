variable "region" {
  description = "The region to deploy the STUN server to"
  type        = string
}

variable "image_tag" {
  description = "Version of the Stun server to deploy"
  type        = string
}
