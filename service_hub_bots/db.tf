resource "aws_dynamodb_table" "signers" {
  name         = "home-assistant-cla-signers"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "github_username"

  attribute {
    name = "github_username"
    type = "S"
  }

  tags = {
    Region = "us-east-1"
  }
}

resource "aws_dynamodb_table" "pending_signature" {
  name         = "home-assistant-cla-pending-signatures"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "github_username"

  attribute {
    name = "github_username"
    type = "S"
  }

  tags = {
    Region = "us-east-1"
  }
}