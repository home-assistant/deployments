terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "ohf-public-assets"
    }
  }

  required_version = "= 1.14.8"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}
