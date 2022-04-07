variable "domain_name" {
  description = "The base domain name"
  type        = string
}

variable "network_cidr" {
  description = "Network CIDR for VPC"
  type        = map(string)
}
