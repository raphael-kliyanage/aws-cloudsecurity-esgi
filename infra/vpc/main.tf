resource "aws_vpc" "main-vpc" {
 cidr_block = "10.0.0.0/16"

 tags = {
   Name = "Groupe1 5SI1 VPC"
 }
}

resource "aws_subnet" "public-subnet" {
 vpc_id             = aws_vpc.main-vpc.id
 cidr_block         = "10.0.2.0/24"
 availability_zone  = "eu-west-3a"

 tags = {
  Name = "${var.public_subnet}"
 }
}

resource "aws_subnet" "private-subnet" {
 vpc_id             = aws_vpc.main-vpc.id
 cidr_block         = "10.0.1.0/24"
 availability_zone  = "eu-west-3a"

 tags = {
  Name = "${var.private_subnet}"
 }

resource "aws_internet_gateway" "main-igw" {
 vpc_id = aws_vpc.main-vpc.id

 tags   = {
  Name  = "${var.internet_gateway}"
  }
}

resource "aws_route_table" "public-route-table" {
 vpc_id = aws_vpc.main-vpc.id

 tags = {
  Name = "${var.public_route_table}"
  }
 }

resource "aws_route" "public-route" {
  route_table_id         = aws_route_table.public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main-igw.id
 }
 
resource "aws_route_table_association" "public-subnet-association" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-route-table.id
 }

#resource "aws_eip" "nat-eip" {
# vpc = true

# tags = {
# Name = "nat-eip"
# }
#}

#resource "aws_nat_gateway" "nat-gateway" {
# allocation_id = aws_eip.nat-eip.id
# subnet_id     = aws_subnet.public-subnet.id

# tags = {
#  Name = "nat-gateway"
#}
#}

resource "aws_security_group" "web-sg" {
 vpc_id = aws_vpc.main-vpc.id
 name   = "web-sg"

 ingress {
  description = "allow in http requests"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }

 ingress {
  description = "allow in https requests"
  from_port   = "443"
  to_port     = "443"
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
   description = "allow in ssh requests"
   from_port   = 22
   to_port     = 22
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
  Name = "web-sg"
 }
}

resource "aws_security_group" "db-sg" {
 vpc_id = aws_vpc.main-vpc.id
 name = "db-sg"

 ingress {
  from_port   = 3306
  to_port     = 3306
  protocol    = "tcp"
  cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
 }

 egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 }

 tags = {
  Name = "db-sg"
 }
}
