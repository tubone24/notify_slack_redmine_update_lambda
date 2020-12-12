locals {
  public_route_gateway_ids = [
    {
      gateway_id = module.redmine_internet_gateway.internet_gateway_id
      cidr_block = "0.0.0.0/0"
    }
  ]
  private_route_gateway_ids = [
    {
      gateway_id = module.redmine_nat_gateway.nat_gateway_id
      cidr_block = "0.0.0.0/0"
    }
  ]
}

#####################################
# Vpc
#####################################
module "redmine_vpc" {
  source = "../../modules/network/vpc"
  vpc_cidr_block = var.vpc_cidr_block
  vpc_name = "redmine-vpc"
}

#####################################
# Internet Gateway
#####################################
module "redmine_internet_gateway" {
  source = "../../modules/network/internet-gateway"
  internet_gateway_vpc_id = module.redmine_vpc.vpc_id
  internet_gateway_name = "redmine-internet-gateway"
}

#####################################
# Public Subnet
#####################################
module "redmine_public_subnet_1a" {
  source = "../../modules/network/subnet"
  subnets_vpc_id = module.redmine_vpc.vpc_id
  subnets_map_public_ip_on_launch = true
  subnet_name = "redmine-public-subnet-1a"
  subnets_cidr_block = var.redmine_public_subnet_cidr_block_a
  subnets_availability_zone = "ap-northeast-1a"
}

module "redmine_public_subnet_1c" {
  source = "../../modules/network/subnet"
  subnets_vpc_id = module.redmine_vpc.vpc_id
  subnets_map_public_ip_on_launch = true
  subnet_name = "redmine-public-subnet-1c"
  subnets_cidr_block = var.redmine_public_subnet_cidr_block_c
  subnets_availability_zone = "ap-northeast-1c"
}

#####################################
# Private Subnet
#####################################
module "redmine_private_subnet_1a" {
  source = "../../modules/network/subnet"
  subnets_vpc_id = module.redmine_vpc.vpc_id
  subnets_map_public_ip_on_launch = false
  subnet_name = "redmine-private-subnet-1a"
  subnets_cidr_block = var.redmine_private_subnet_cidr_block_a
  subnets_availability_zone = "ap-northeast-1a"
}

module "redmine_private_subnet_1c" {
  source = "../../modules/network/subnet"
  subnets_vpc_id = module.redmine_vpc.vpc_id
  subnets_map_public_ip_on_launch = false
  subnet_name = "redmine-private-subnet-1c"
  subnets_cidr_block = var.redmine_private_subnet_cidr_block_c
  subnets_availability_zone = "ap-northeast-1c"
}

#####################################
# Nat Gateway
#####################################
module "redmine_nat_gateway" {
  source = "../../modules/network/nat-gateway"
  nat_gateway_subnet_id = module.redmine_public_subnet_1a.subnet_id
  nat_gateway_nat_eip_allocation_id = var.redmine_nat_gateway_nat_eip_allocation_id
  nat_gateway_name = "redmine-natgateway"
}

#####################################
# Public Route Table
#####################################
module "redmine_public_route_table" {
  source = "../../modules/network/route-table"
  route_table_vpc_id = module.redmine_vpc.vpc_id
  route_table_gateway_id_map = local.public_route_gateway_ids
  route_table_name = "redmine-public-route"
}

#####################################
# Private Route Table
#####################################
module "redmine_private_route_table" {
  source = "../../modules/network/route-table"
  route_table_vpc_id = module.redmine_vpc.vpc_id
  route_table_gateway_id_map = local.private_route_gateway_ids
  route_table_name = "redmine-private-route"
}

#####################################
# Publc Route Table Association
#####################################
module "redmine_public_route_table_1a_association" {
  source = "../../modules/network/route-table-association"
  route_table_association_subnet_id = module.redmine_public_subnet_1a.subnet_id
  route_table_association_route_table_id = module.redmine_public_route_table.route_table_id
}

module "redmine_public_route_table_1c_association" {
  source = "../../modules/network/route-table-association"
  route_table_association_subnet_id = module.redmine_public_subnet_1c.subnet_id
  route_table_association_route_table_id = module.redmine_public_route_table.route_table_id
}

#####################################
# Private Route Table Association
#####################################
module "redmine_private_route_table_1a_association" {
  source = "../../modules/network/route-table-association"
  route_table_association_subnet_id = module.redmine_private_subnet_1a.subnet_id
  route_table_association_route_table_id = module.redmine_private_route_table.route_table_id
}

module "redmine_private_route_table_1c_association" {
  source = "../../modules/network/route-table-association"
  route_table_association_subnet_id = module.redmine_private_subnet_1c.subnet_id
  route_table_association_route_table_id = module.redmine_private_route_table.route_table_id
}