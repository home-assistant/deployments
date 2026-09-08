variable "image_tag" {
  description = "Image tag for the container"
  type        = string
  default     = "stable"
}

variable "configuration_yaml" {
  description = "Content of configuration.yaml - written on every deploy"
  type        = string
  default     = "default_config:"

  # No yamldecode() validation here: Home Assistant configuration.yaml uses
  # custom YAML tags such as `!include`, `!secret` and `!env_var`, which
  # Terraform's yamldecode() rejects as invalid YAML.
}
