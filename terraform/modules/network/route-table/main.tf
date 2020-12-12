#####################################
# RouteTable
#####################################
resource "aws_route_table" "route_table" {
  vpc_id = var.route_table_vpc_id

  dynamic "route" {
    for_each = var.route_table_gateway_id_map
    content {
      cidr_block = route.value.cidr_block
      gateway_id = route.value.gateway_id
    }
  }
  tags = {
    "Name" = var.route_table_name
  }
}
