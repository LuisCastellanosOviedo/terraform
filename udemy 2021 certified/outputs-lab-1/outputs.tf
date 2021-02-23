output "private_ip" {
  value = aws_instance.assignment.private_ip
  description = "private instance for instance 1"
}

output "private_ip_machine2" {
  value = aws_instance.machine2.private_ip
  description = "private ip for instance 2"
}