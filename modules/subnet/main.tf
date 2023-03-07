resource "aws_subnet" "subnetwork" {
  availability_zone       = "${var.project_region}a"
  cidr_block              = var.cidr
  map_public_ip_on_launch = var.is_public

  tags = {
    Env  = var.environment
    Name = "${var.is_public ? "pub" : "pvt"}-${var.project_name}"
  }

  vpc_id = var.vpc_id
}

resource "aws_route_table_association" "route-table-association" {
  route_table_id = var.route_table_id
  subnet_id      = aws_subnet.subnetwork.id
}