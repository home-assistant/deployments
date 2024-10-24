terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "assist"
    }
  }

  required_version = "= 1.9.6"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}
