provider "aws" {
  region     = var.region
  access_key = var.ACCESS_KEY
  secret_key = var.SECRET_ACCESS_KEY
}

resource "aws_instance" "raish" {
  ami                    = "ami-0f918f7e67a3323f0" # Ubuntu 22.04 LTS (for ap-south-1)
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_ports.id]
  key_name               = var.key_name
  user_data              = file("install.sh")
  tags = {
    Name = "Terraform-EC2"
  }
}

resource "aws_security_group" "allow_ports" {
  name        = "allow_flask_express"
  description = "Allow SSH, Flask, and Express"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
