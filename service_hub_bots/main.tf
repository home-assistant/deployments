# Retired: the Home Assistant bots run from OpenHomeFoundation/bots
# (OpenHomeFoundation/deployments, bots/). Applying this destroys the legacy
# service and keeps the two CLA tables.

terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "service_hub_bots"
    }
  }

  required_version = "~> 1.11.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# The CLA tables are the legal record of every signature collected by the
# legacy bot: Terraform forgets them instead of deleting them. They keep
# deletion protection and their on-demand backups.
removed {
  from = aws_dynamodb_table.signers

  lifecycle {
    destroy = false
  }
}

removed {
  from = aws_dynamodb_table.pending_signature

  lifecycle {
    destroy = false
  }
}
