variable "region" {
  description = "Region of AWS for staging infrastructure"
  type        = string
}

variable "network_cidr" {
  description = "Network CIDR for VPC"
  type        = string
}

variable "ecs_policy" {
  description = "The name attribute of the IAM instance profile"
  type        = string
}

variable "domain_name" {
  description = "The base domain name for the wildcard certificate"
  type        = string
}

