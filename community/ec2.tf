
resource "aws_instance" "discourse" {
  ami           = "ami-003634241a8fcdec0"
  instance_type = "m5a.4xlarge"
  tags = {
    Name = "Discourse"
  }
}

resource "aws_eip" "discourse" {
  instance = aws_instance.discourse.id
  vpc      = true
}
