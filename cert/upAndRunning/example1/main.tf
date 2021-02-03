provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "example" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  user_data = <<-EOF
#!/bin/bash
echo "Hello, World" > index.html
nohup busybox httpd -f -p ${var.server_port} &
EOF

  tags = {
    Name = "terraform-example"
  }
}

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "the public ip address of teh webserver"
}

resource "aws_security_group" "instance_sg" {
  name        = "instance-sg"
  description = "Allow TLS inbound traffic"


  ingress {
    description = "TLS from VPC"
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}



##### AUTO SCALING GROUP #####

resource "aws_launch_configuration" "example" {
  image_id        = "ami-0c55b159cbfafe1f0"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.instance_sg.id]

  user_data = <<-EOF
#!/bin/bash
echo "Hello, World" > index.html
nohup busybox httpd -f -p ${var.server_port} &
EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg_example" {
  launch_configuration = aws_launch_configuration.example.name
  vpc_zone_identifier  = data.aws_subnet_ids.default.ids

  min_size = 2
  max_size = 4

  tag {
    key                 = "Name"
    value               = "terra ASG example"
    propagate_at_launch = true
  }
}

### data source 

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id

}


##### load balancer

resource "aws_lb" "alb_example" {
  name               = "terra-alb-example"
  load_balancer_type = "application"
  subnets            = data.aws_subnet_ids.default.ids
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb_example.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }

}