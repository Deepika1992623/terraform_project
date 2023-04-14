# VPC creation
resource "aws_vpc" "card_vpc" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "card_vpc"
  }
}
# subnet config
resource "aws_subnet" "card-subnet-1" {
  vpc_id     = aws_vpc.card_vpc.id
  cidr_block = "10.10.0.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "card-subnet-1"
  }
}


resource "aws_subnet" "card-subnet-2" {
  vpc_id     = aws_vpc.card_vpc.id
  cidr_block = "10.10.1.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "card-subnet-2"
  }
}
resource "aws_subnet" "card-subnet-3" {
  vpc_id     = aws_vpc.card_vpc.id
  cidr_block = "10.10.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "card-subnet-3"
  }
}
resource "aws_subnet" "card-subnet-4" {
  vpc_id     = aws_vpc.card_vpc.id
  cidr_block = "10.10.3.0/24"
  availability_zone = "us-east-1b"
  
  tags = {
    Name = "card-subnet-4"
  }
}
# internet gateway
resource "aws_internet_gateway" "card-IG" {
  vpc_id = aws_vpc.card_vpc.id

  tags = {
    Name = "card-IG"
  }
}

# creating route table
resource "aws_route_table" "card-RT" {
  vpc_id = aws_vpc.card_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.card-IG.id
  }

  tags = {
    Name = "card-RT"
  }
}
# Route Table association

resource "aws_route_table_association" "card_RT_ASSO_Public-1" {
  subnet_id      = aws_subnet.card-subnet-1.id
  route_table_id = aws_route_table.card-RT.id
}

resource "aws_route_table_association" "card_RT_ASSO_Public-2" {
  subnet_id      = aws_subnet.card-subnet-2.id
  route_table_id = aws_route_table.card-RT.id
}