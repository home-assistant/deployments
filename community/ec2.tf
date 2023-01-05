
resource "aws_instance" "discourse" {
  ami           = "ami-003634241a8fcdec0"
  instance_type = "m5a.4xlarge"
}
