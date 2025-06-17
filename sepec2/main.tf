provider "aws" {
  region     = "ap-south-1"
  access_key = var.ACCESS_KEY
  secret_key = var.SECRET_ACCESS_KEY
}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "flask-express-vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "main-subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-gw"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "main-rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.rt.id
  depends_on     = [aws_internet_gateway.gw]
}

resource "aws_security_group" "flask_sg" {
  name        = "flask-sg"
  description = "Allow Flask traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_security_group" "express_sg" {
  name        = "express-sg"
  description = "Allow Express traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "flask" {
  ami                    = "ami-0f918f7e67a3323f0"
  instance_type          = "t2.micro"
  key_name               = var.key_name
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.flask_sg.id]
  user_data              = file("flask_user_data.sh")

  tags = {
    Name = "flask-server"
  }
}

resource "aws_instance" "express" {
  ami                    = "ami-0f918f7e67a3323f0"
  instance_type          = "t2.micro"
  key_name               = var.key_name
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.express_sg.id]
  user_data = templatefile("user_data_express.sh", {
    API_URL = "${aws_instance.flask.public_ip}"
  })
  tags = {
    Name = "express-server"
  }
}
