terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "static_dns"
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

data "cloudflare_zone" "dns_zone" {
  name = var.domain_name
}
