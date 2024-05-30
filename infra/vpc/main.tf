resource "aws_vpc" "main-vpc" {
 cidr_block = "10.0.0.0/16"

 tags = {
   Name = "Groupe1 5SI1 VPC"
 }
}

resource "aws_subnet" "public_subnet" {
 vpc_id             = aws_vpc.main-vpc.id
 cidr_block         = "10.0.2.0/24"
 availability_zone  = "eu-west-3a"

 tags = {
  Name = "Public Subnet"
 }
}

resource "aws_subnet" "private_subnet" {
 vpc_id             = aws_vpc.main-vpc.id
 cidr_block         = "10.0.1.0/24"
 availability_zone  = "eu-west-3a"

 tags = {
  Name = "Private Subnet"
 }

resource "aws_internet_gateway" "main-igw" {
 vpc_id = aws_vpc.main-vpc.id

 tags   = {
  Name  = "main-vpc-IGW"
  }
}

resource "aws_route_table" "public-route-table" {
 vpc_id = aws_vpc.main-vpc.id

 tags = {
  Name = "public-route-table"
  }
 }
