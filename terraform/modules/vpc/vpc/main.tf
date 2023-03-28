# Create a VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = var.cidr
  enable_dns_hostnames = true
  tags = {
    Name = "main"
  }
}

# Create a public subnet 1
resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.main_vpc.id
  availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block = cidrsubnet(aws_vpc.main_vpc.cidr_block, 4, 0)
  map_public_ip_on_launch = true
}

# Create a public subnet 2
resource "aws_subnet" "public_subnet_2" {
  availability_zone = data.aws_availability_zones.available.names[2]
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = cidrsubnet(aws_vpc.main_vpc.cidr_block, 4, 1)
  map_public_ip_on_launch = true
}

# Create an internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
}

# Create a route table for the public subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Associate the public subnet with the route table
resource "aws_route_table_association" "public_association_1" {
  subnet_id = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

# Associate the public subnet with the route table
resource "aws_route_table_association" "public_association_2" {
  subnet_id = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}