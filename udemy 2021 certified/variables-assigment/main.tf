provider "aws" {
  region = var.region
}


resource "aws_instance" "assignment" {
  ami = var.ami_id
  instance_type = var.instance_type
  tags = var.tags
}