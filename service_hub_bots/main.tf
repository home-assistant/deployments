terraform {
  cloud {
    organization = "home_assistant"

    workspaces {
      name = "service_hub_bots"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "webservice_service_hub_bots" {
  source = "../.modules/webservice"

  service_name      = "service-hub-bots"
  container_image   = "ghcr.io/home-assistant/service-hub"
  container_version = var.service_hub_image_tag
  port              = 5000
  healthcheck_path  = "/__heartbeat__"
  rolling_updates   = true

  task_policy_statements = [
    {
      actions = ["dynamodb:PutItem", "dynamodb:UpdateItem", "dynamodb:DeleteItem", "dynamodb:GetItem"],
      resources = [
        aws_dynamodb_table.signers.arn,
        "${aws_dynamodb_table.signers.arn}/*",
        aws_dynamodb_table.pending_signature.arn,
        "${aws_dynamodb_table.pending_signature.arn}/*"
      ]
    }
  ]

  container_definitions = {
    "command" : [
      "start:bots:prod"
    ],
    environment : [
      { name : "DISCORD_TOKEN", value : var.discord_token },
      { name : "DISCORD_GUILD_ID", value : var.discord_guild_id },
      { name : "GITHUB_TOKEN", value : var.github_token },
      { name : "GITHUB_WEBHOOK_SECRET", value : var.github_webhook_secret },
      { name : "DYNAMODB_CLA_SIGNERS_TABLE", value : aws_dynamodb_table.signers.id },
      { name : "DYNAMODB_CLA_PENDING_SIGNERS_TABLE", value : aws_dynamodb_table.pending_signature.id },
      { name : "SENTRY_DSN", value : var.sentry_dsn },
      { name : "NODE_ENV", value : "production" }
    ]
  }
}
