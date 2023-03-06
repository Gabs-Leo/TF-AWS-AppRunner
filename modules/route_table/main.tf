resource "aws_route_table" "route-table" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Env  = var.environment
    Name = "rt-${var.project_name}-${var.is_public ? "pub" : "pvt"}"
  }

  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "private" {
  tags = {
    Env  = var.environment
    Name = "route-table-private"
  }

  vpc_id = aws_vpc.vpc.id
}