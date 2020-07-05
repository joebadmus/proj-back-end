resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true

  tags = {
    Name   = var.vpc_name
    Author = var.author
    Tool   = var.tool
  }
}


resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_subnet" "subnet-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name   = "public_subnet-1"
    Author = var.author
    Tool   = var.tool
  }
}

resource "aws_subnet" "subnet-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name   = "public_subnet-2"
    Author = var.author
    Tool   = var.tool
  }
}

resource "aws_subnet" "subnet-3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name   = "public_subnet-3"
    Author = var.author
    Tool   = var.tool
  }
}

resource "aws_route_table" "default" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table_association" "main-sub-1" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.default.id
}

resource "aws_route_table_association" "main-sub-2" {
  subnet_id      = aws_subnet.subnet-2.id
  route_table_id = aws_route_table.default.id
}

resource "aws_route_table_association" "main-sub-3" {
  subnet_id      = aws_subnet.subnet-3.id
  route_table_id = aws_route_table.default.id
}


resource "aws_network_acl" "allowall" {
  vpc_id = aws_vpc.main.id

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}

#========================#


# resource "aws_security_group" "allow"




