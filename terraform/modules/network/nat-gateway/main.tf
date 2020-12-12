#####################################
# NatGateway
#####################################
resource "aws_nat_gateway" "nat_gateway" {
  subnet_id     = var.nat_gateway_subnet_id
  allocation_id = var.nat_gateway_nat_eip_allocation_id

  tags = {
    "Name" = var.nat_gateway_name
  }
}
