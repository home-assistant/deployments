variable "image_tag" {
  description = "Image tag for the container"
  type        = string
  default     = "stable"
}

variable "configuration_yaml" {
  description = "Content of configuration.yaml - written on every deploy"
  type        = string
  default     = "default_config:"
}
