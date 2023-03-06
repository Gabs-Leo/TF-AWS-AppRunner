resource "aws_vpc" "vpc" {
  cidr_block  = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc-${var.project_name}"
  }
}

resource "aws_security_group" "security_group" {
  description = "sg-${var.project_name}-ec2"

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


  name = "sg-${var.project_name}-ec2"

  tags = {
    Env  = var.environment
    Name = "sg-${var.project_name}-ec2"
  }

  vpc_id = aws_vpc.vpc.id
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Env  = var.environment
    Name = "ig-${var.project_name}"
  }
}