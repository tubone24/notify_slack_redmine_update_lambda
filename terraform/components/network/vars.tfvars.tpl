env = ""
account_id = ""
region = "ap-northeast-1"
profile_name  = ""

vpc_cidr_block = "10.10.10.0/26"
// public_subnet_a
redmine_public_subnet_cidr_block_a = "10.10.10.32/28"
// public_subnet_c
redmine_public_subnet_cidr_block_c = "10.10.10.48/28"
// private_subnet_a
redmine_private_subnet_cidr_block_a = "10.10.10.0/28"
// private_subnet_c
redmine_private_subnet_cidr_block_c = "10.10.10.16/28"
// nat_gateway
redmine_nat_gateway_nat_eip_allocation_id = "eipalloc-xxxxxxxxxxxx"
redmine_public_route_cidr_blocks = ["0.0.0.0/0"]