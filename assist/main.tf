terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "assist"
    }
  }


  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }
}
