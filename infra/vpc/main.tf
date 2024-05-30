resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main-subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/28"

  tags = {
    Name = "main-subnet"
  }
}
