output "subnet_id" {
 value = aws_subnet.public-subnet.id
}

output "vpc_id" {
 value = aws_vpc.main-vpc.id
}

output "vpc_security_group_ids" {
 value = aws_security_group.web-sg.id
}

output "allocation_id" {
 value = aws_eip.nat-eip.id
}
