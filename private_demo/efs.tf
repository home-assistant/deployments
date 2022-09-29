
resource "aws_efs_file_system" "efs" {
  creation_token = "efs"
}

resource "aws_efs_mount_target" "mount" {
  for_each = toset(
    nonsensitive(data.tfe_outputs.infrastructure.values["us-east-1"].private_subnets),
  )

  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = each.value

}