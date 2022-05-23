terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.15"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}
