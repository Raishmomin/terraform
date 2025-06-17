variable "aws_region" {
  default = "ap-south-1"
}
variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "availability_zone" {
  default = "ap-south-1a"
}

variable "flask_image_url" {
  description = "ECR image URL for Flask app"
  type        = string
}

variable "express_image_url" {
  description = "ECR image URL for Express app"
  type        = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "ACCESS_KEY" {
  description = "Your AWS access key"
  type        = string
  sensitive   = true
}

variable "SECRET_ACCESS_KEY" {
  description = "Your AWS secret key"
  type        = string
  sensitive   = true
}
