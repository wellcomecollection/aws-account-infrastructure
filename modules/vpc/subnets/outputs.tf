output "subnets" {
  value = [for subnet in aws_subnet.subnet : subnet.id]
}

output "route_table_id" {
  value = aws_route_table.table.id
}
