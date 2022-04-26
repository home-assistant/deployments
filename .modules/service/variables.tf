variable "service_name" {
  description = "The name of the service"
  type        = string
}

variable "container_image" {
  description = "The container image (without the tag to use)"
  type        = string
}

variable "container_version" {
  description = "The version (tag) of the container image to use"
  type        = string
  default     = "latest"
}

variable "launch_type" {
  description = "The launch type to use for the deployment"
  default     = "FARGATE"
  type        = string
}

variable "region" {
  description = "The AWS region for the deployment"
  default     = "us-east-1"
  type        = string
}

variable "ecs_cpu" {
  description = "CPU resource allocation"
  default     = 512
  type        = number
}

variable "ecs_memory" {
  description = "Memory resource allocation"
  default     = 1024
  type        = number
}

variable "container_definitions" {
  description = "Custom container definitions that will be merged with the base definitions"
  default     = {}
}

variable "webservice" {
  description = "Boolean to to disable ecs service creation, as this is handled in the webservice module"
  default     = false
  type        = bool
}
