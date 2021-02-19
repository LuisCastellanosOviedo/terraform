output "alb_dns_name" {
  value       = aws_lb.alb_example.dns_name
  description = "domain of the load balancer"
}

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "the public ip address of teh webserver"
}