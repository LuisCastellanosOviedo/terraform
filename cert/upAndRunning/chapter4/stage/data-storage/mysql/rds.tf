provider "aws" {
  region = "us-east-2"
}

resource "aws_db_instance" "db_example" {
  identifier_prefix = "terraform-rds-exmple"
  engine            = "mysql"
  allocated_storage = 10
  instance_class    = "t2.micro"
  name              = "rds-example"
  username          = "admin"
  password          = data.aws_secretsmanager_secret_version.db_password.secret_string
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = "mysql-master-password-stage"
}