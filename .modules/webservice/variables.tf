variable "domain_name" {
  description = "The base domain name"
  default     = "home-assistant.io"
  type        = string
}

variable "subdomain" {
  description = "The subdomain for the sercive, leave blank to use the service_name variable for it."
  default     = ""
  type        = string
}

variable "service_name" {
  description = "The name of the service"
  type        = string
}


variable "container_image" {
  description = "The container image (without the tag to use)"
  type        = string
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

variable "port" {
  description = "The port for the webservice"
  type        = number
}

variable "container_definitions" {
  description = "Custom container definitions that will be merged with the base definitions"
  default     = {}
}