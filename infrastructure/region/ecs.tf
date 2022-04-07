resource "aws_ecs_cluster" "svcs" {
  name = "HomeAssistant-Services"

  tags = {
    Region = var.region
  }
}
