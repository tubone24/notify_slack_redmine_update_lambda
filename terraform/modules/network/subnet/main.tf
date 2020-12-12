#####################################
# Subnet
#####################################
resource "aws_subnet" "subnets" {
  vpc_id                  = var.subnets_vpc_id
  cidr_block              = var.subnets_cidr_block
  availability_zone       = var.subnets_availability_zone
  map_public_ip_on_launch = var.subnets_map_public_ip_on_launch

  tags = {
    "Name" = var.subnet_name
  }
}
