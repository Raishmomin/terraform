variable "region" {
  default = "ap-south-1"
}

variable "ami" {
  description = "Ubuntu AMI"
  default     = "ami-0f5ee92e2d63afc18" # Ubuntu 22.04 in ap-south-1
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "Name of your existing AWS EC2 key pair"
}

variable "private_key_path" {
  description = "Path to your private key (PEM file) on local system"
}

variable "ACCESS_KEY" {
  type      = string
  sensitive = true
}
variable "SECRET_ACCESS_KEY" {
  type      = string
  sensitive = true
}
