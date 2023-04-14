# Security Group

resource "aws_security_group" "allow_security_group" {
  name        = "allow_security_group"
  description = "Allow security group traffic"
  vpc_id      = aws_vpc.card_vpc.id

  ingress {
    description      = "SSH from my laptop"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "SSH from my laptop"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}