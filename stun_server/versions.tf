terraform {
  required_version = "= 1.9.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.58.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}
