
resource "aws_efs_file_system" "efs" {
  creation_token = "efs"

  tags = {
    Name = "PrivateDemo"
  }
}


resource "aws_security_group" "efs" {
  vpc_id      = data.tfe_outputs.infrastructure.values["us-east-1"].network_id

  ingress {
    from_port = 2049
    to_port   = 2049
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 }

resource "aws_efs_mount_target" "mount" {
  for_each = toset(
    nonsensitive(data.tfe_outputs.infrastructure.values["us-east-1"].private_subnets),
  )

  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = each.value
  security_groups = [aws_security_group.efs.id]

}