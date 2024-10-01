terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "cas_validator"
    }
  }
}
