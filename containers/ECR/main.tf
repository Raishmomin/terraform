provider "aws" {
  region = "ap-south-1"
}

resource "aws_ecr_repository" "tutedude-backend" {
  name = "tutedude-backend"
}

resource "aws_ecr_repository" "tutedude-frontend" {
  name = "tutedude-frontend"
}
