terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "static_dns"
    }
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

data "cloudflare_zone" "dns_zone" {
  name = var.domain_name
}
