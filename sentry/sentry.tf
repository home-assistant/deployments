provider "sentry" {}

resource "sentry_organization" "main" {
  name = "Home Assistant"
  slug = "home-assistant-io"

  agree_terms = true
}
