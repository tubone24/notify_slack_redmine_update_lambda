#####################################
# VPN GateWay
#####################################
resource "aws_vpn_gateway" "vpn_gw" {
  vpc_id = var.vpn_gw_vpc_id

  tags = {
    Name = var.vpn_gw_name
  }
}
