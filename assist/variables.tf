locals {
  environment = element(split("-", terraform.workspace), length(split("-", terraform.workspace)) - 1)
}
