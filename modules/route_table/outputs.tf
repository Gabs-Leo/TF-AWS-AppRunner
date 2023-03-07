output "id" {
    value = var.is_public ? aws_route_table.pub_route_table[0].id : aws_route_table.pvt_route_table[0].id
}