variable "image_tag" {
  description = "Image tag for the container"
  type        = string
}

variable "default_users" {
  description = "Default users configuration"
  type        = string
  sensitive   = true
}
