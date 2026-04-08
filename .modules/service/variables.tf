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


variable "task_policy_statements" {
  description = "Custom task_policy_statements"
  default     = []
}

variable "container_volumes" {
  description = "Container volume configuration"
  default     = []
}

variable "webservice" {
  description = "Boolean to to disable ecs service creation, as this is handled in the webservice module"
  default     = false
  type        = bool
}

variable "rolling_updates" {
  description = "Boolean to set rolling updates"
  default     = false
  type        = bool
}

variable "deployment_maximum_percent" {
  description = "Upper limit on the number of tasks that can run during a deployment"
  default     = 200
  type        = number

  validation {
    condition = !var.rolling_updates || var.deployment_maximum_percent >= 200
    error_message = "deployment_maximum_percent must be at least 200 when rolling_updates is true, so ECS can start a replacement task for a service with desired_count = 1 and deployment_minimum_healthy_percent = 100."
  }
}
