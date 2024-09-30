variable "region" {
  description = "The region to deploy the STUN server to"
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

variable "ecs_execution_role" {
  description = "The name of the ECS execution role"
  type        = string
}

variable "ecs_task_execution_role" {
  description = "The name of the ECS task execution role"
  type        = string
}
