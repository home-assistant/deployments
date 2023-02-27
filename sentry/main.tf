terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "sentry"
    }
  }

  required_providers {
    sentry = {
      source = "jianyuan/sentry"
      version = "0.11.2"
    }
  }
}

