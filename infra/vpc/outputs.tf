output "public_subnet_id" {
  value = aws_subnet.public-subnet.id
}

output "vpc_id" {
  value = aws_vpc.main-vpc.id
}
