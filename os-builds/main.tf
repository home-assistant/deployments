terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "os-builds"
    }
  }


  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }
}
