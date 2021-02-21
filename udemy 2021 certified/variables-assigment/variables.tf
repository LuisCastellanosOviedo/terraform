variable "region" {
  type = string
  default = "us-east-1"
}

variable "ami_id" {
  type = string
  default = "ami-047a51fa27710816e"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "tags" {
  type = map
default = {
    name="hello world tags"
}
}