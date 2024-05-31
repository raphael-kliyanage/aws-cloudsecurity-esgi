output "instance_ip_addr" {
  value = aws_eip.nat-eip.public_ip
}

