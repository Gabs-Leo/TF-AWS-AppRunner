resource "aws_route_table" "pub_route_table" {
  count = var.is_public ? 1 : 0
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  tags = {
    Env  = var.environment
    Name = "rt-${var.project_name}-${var.is_public ? "pub" : "pvt"}"
  }

  vpc_id = var.vpc_id
}

resource "aws_route_table" "pvt_route_table" {
  count = var.is_public ? 0 : 1

  tags = {
    Env  = var.environment
    Name = "rt-${var.project_name}-${var.is_public ? "pub" : "pvt"}"
  }

  vpc_id = var.vpc_id
}