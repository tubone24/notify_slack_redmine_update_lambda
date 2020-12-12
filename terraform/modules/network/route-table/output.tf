output "route_table_id" {
  value = aws_route_table.route_table.id
}

output "route_table_name" {
  value = aws_route_table.route_table.tags.Name
}
