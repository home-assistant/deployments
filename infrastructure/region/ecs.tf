resource "aws_ecs_cluster" "svcs" {
  name = "HomeAssistant-Services"

  tags = {
    Region = data.aws_region.current.name
  }
}
