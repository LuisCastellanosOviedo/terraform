provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "lab4" {
  ami           = "ami-047a51fa27710816e"
  instance_type = "t2.micro"
  tags = {
    "name"        = "lab4"
    "environment" = "dev"
  }
}

resource "aws_ebs_volume" "ebs_volume_lab4" {
  availability_zone = aws_instance.lab4.availability_zone
  size              = 10

}

resource "aws_volume_attachment" "ebs_lab4_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs_volume_lab4.id
  instance_id = aws_instance.lab4.id

}

