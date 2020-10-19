# Specify the provider and access details
provider "aws" {
  region = var.aws_region
}

# VPC resources: This will create 1 VPC with 4 Subnets, 1 Internet Gateway, 4 Route Tables. 

resource "aws_vpc" "RHCSA8Cloud" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "RHCSA8 Cloud"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.RHCSA8Cloud.id
  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "private" {
  count = length(var.private_subnet_cidr_blocks)

  vpc_id = aws_vpc.RHCSA8Cloud.id
}

resource "aws_route" "private" {
  count = length(var.private_subnet_cidr_blocks)

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.default[count.index].id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.RHCSA8Cloud.id
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr_blocks)

  vpc_id            = aws_vpc.RHCSA8Cloud.id
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]
      tags = {
    Name = "Private Subnet"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.RHCSA8Cloud.id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
    tags = {
    Name = "Public Subnet"
  }
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr_blocks)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr_blocks)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}


# NAT resources: This will create 1 NAT gateway in 1 Public Subnet for 1 different Private Subnet.

resource "aws_eip" "nat" {
  count = length(var.public_subnet_cidr_blocks)
  vpc = true
}

resource "aws_nat_gateway" "default" {
  depends_on = [aws_internet_gateway.default]

  count = length(var.public_subnet_cidr_blocks)

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags = {
    Name = "NAT Gateway"
  }
}
 
# Create security group in RHCSA 8 Cloud VPC
resource "aws_security_group" "rhcsa8env-sg" {
  name        = "rhcsa8env-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.RHCSA8Cloud.id

  ingress {
    description = "SSH for RHCSA8env"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Ping for RHCSA8env"
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP for RHCSA8env"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS for RHCSA8env"
    from_port   = 443
    to_port     = 443
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
    Name = "rhcsa8env-sg"
  }
}


# Create Server 1
resource "aws_instance" "rhcsa8-server1" {
  instance_type = "t2.micro"
  ami           = "ami-081d04fe4876761a1"
  key_name      = "rhcsa8env"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.rhcsa8env-sg.id}"]
  subnet_id     = aws_subnet.public[0].id
    tags = {
    Name = "rhcsa8-server1"
  }
}

# Create Server 2
resource "aws_instance" "rhcsa8-server2" {
  instance_type = "t2.micro"
  ami           = "ami-0f2c48ef05221645f"
  key_name      = "rhcsa8env"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.rhcsa8env-sg.id}"]
  subnet_id     = aws_subnet.public[0].id
  tags = {
    Name = "rhcsa8-server2"
  }
}
