terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "infrastructure"
    }
  }
}
