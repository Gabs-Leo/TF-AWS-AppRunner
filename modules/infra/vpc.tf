resource "aws_vpc" "vpc" {
  cidr_block  = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name      = "Prod Vpc"
  }
}

resource "aws_subnet" "public__a" {
  availability_zone       = "us-east-1a"
  cidr_block              = "10.10.20.0/24"
  map_public_ip_on_launch = true

  tags = {
    Env  = "production"
    Name = "public-us-east-1a"
  }

  vpc_id = aws_vpc.vpc.id
}

resource "aws_subnet" "public__b" {
  availability_zone       = "us-east-1b"
  cidr_block              = "10.10.30.0/24"
  map_public_ip_on_launch = true

  tags = {
    Env  = "production"
    Name = "public-us-east-1b"
  }

  vpc_id = aws_vpc.vpc.id
}

resource "aws_subnet" "private__a" {
  availability_zone       = "us-east-1a"
  cidr_block              = "10.10.40.0/24"
  map_public_ip_on_launch = false

  tags = {
    Env  = "production"
    Name = "private-us-east-1a"
  }

  vpc_id= aws_vpc.vpc.id
}

resource "aws_subnet" "private__b" {
  availability_zone       = "us-east-1b"
  cidr_block              = "10.10.50.0/24"
  map_public_ip_on_launch = false

  tags = {
    Env  = "production"
    Name = "private-us-east-1b"
  }

  vpc_id= aws_vpc.vpc.id
}

resource "aws_security_group" "ec2" {
  description = "security-group--ec2"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    from_port       = 0
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
    to_port         = 65535
  }
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }


  name = "security-group--ec2"

  tags = {
    Env  = "production"
    Name = "security-group--ec2"
  }

  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "public" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Env  = "production"
    Name = "route-table-public"
  }

  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "private" {
  tags = {
    Env  = "production"
    Name = "route-table-private"
  }

  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table_association" "public__a" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public__a.id
}

resource "aws_route_table_association" "public__b" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public__b.id
}

resource "aws_route_table_association" "private__a" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private__a.id
}

resource "aws_route_table_association" "private__b" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private__b.id
}

resource "aws_main_route_table_association" "default" {
  route_table_id = aws_route_table.public.id
  vpc_id         = aws_vpc.vpc.id
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Env  = "production"
    Name = "internet-gateway"
  }
}