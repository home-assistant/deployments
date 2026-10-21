terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "os-builds"
    }
  }

  required_version = "1.17.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}
