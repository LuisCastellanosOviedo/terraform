provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "variables_lab_1" {
  ami           = "ami-047a51fa27710816e"
  instance_type = var.instance_type
  tags = {
    "name"        = "variables_lab_1"
    "environment" = "dev"
  }
}

resource "aws_instance" "variables_lab_1_1" {
  ami           = "ami-047a51fa27710816e"
  instance_type = var.instance_type
  tags = {
    "name"        = "variables_lab_1_1"
    "environment" = "dev"
  }
}