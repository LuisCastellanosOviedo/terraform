provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "lab3" {
    ami = "ami-047a51fa27710816e"
    instance_type = "t2.micro"
    tags = {
      "name" = "test"
      "environment" = "dev"
    }
}