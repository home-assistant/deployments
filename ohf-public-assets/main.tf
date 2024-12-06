terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "ohf-public-assets"
    }
  }

  required_version = "= 1.10.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}
