output "instance-ip" {
  value = aws_instance.web.public_ip
}

output "instance-domain" {
  value = aws_instance.web.public_dns
}
