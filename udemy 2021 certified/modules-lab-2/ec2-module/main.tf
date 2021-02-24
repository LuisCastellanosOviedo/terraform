resource "aws_instance" "assignment" {
  ami = data.aws_ami.windows.id
  instance_type = "t2.micro"
  availability_zone = var.availability_zone
}

data "aws_ami" "windows" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["801119661308"] # Canonical
}

#EBS volume attachment

resource "aws_ebs_volume" "example" {
  availability_zone = var.availability_zone
  size = 10

  tags = {
      Name = "Data drive"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id = aws_ebs_volume.example.id
  instance_id = aws_instance.assignment.id
}


# Cloudwatch metric
resource "aws_cloudwatch_metric_alarm" "ec2_alamr_cpu" {
    alarm_name = "cpu-utilization"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = 120 #seconds
    statistic = "Average"
    threshold = "80"
    alarm_description = "this metric monitor ec2 cpu uitilization"
    insufficient_data_actions = [  ]
    dimensions = {
      "InstanceId" = aws_instance.assignment.id
    }
  
}