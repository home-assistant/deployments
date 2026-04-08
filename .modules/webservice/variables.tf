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

variable "port" {
  description = "The port for the webservice"
  type        = number
}

variable "healthcheck_path" {
  description = "The path used for healthchecks"
  default     = "/"
  type        = string
}

variable "container_definitions" {
  description = "Custom container definitions that will be merged with the base definitions"
  default     = {}
}

variable "container_volumes" {
  description = "Container volume configuration"
  default     = []
}

variable "task_policy_statements" {
  description = "Custom task_policy_statements"
  default     = []
}

variable "rolling_updates" {
  description = "Boolean to set rolling updates"
  default     = false
  type        = bool
}

variable "deployment_maximum_percent" {
  description = "Upper limit on the number of tasks that can run during a deployment. Must be within ECS' allowed range of 100-200. When rolling_updates is true, use a value greater than 100 (typically 200) to avoid stalled deployments."
  default     = 200
  type        = number

  validation {
    condition     = var.deployment_maximum_percent >= 100 && var.deployment_maximum_percent <= 200
    error_message = "deployment_maximum_percent must be between 100 and 200. When rolling_updates is true, set deployment_maximum_percent to a value greater than 100 (typically 200) to avoid stalled ECS deployments."
  }
}

variable "cloudflare_proxy" {
  description = "Boolean to set if CloudFlare proxy should be active"
  default     = true
  type        = bool
}