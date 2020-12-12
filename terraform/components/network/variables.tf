variable "env" {}
variable "account_id" {}
variable "region" {}
variable "profile_name" {}

variable "vpc_cidr_block" {}
// public_subnet_a
variable "redmine_public_subnet_cidr_block_a" {}
// public_subnet_c
variable "redmine_public_subnet_cidr_block_c" {}
// private_subnet_a
variable "redmine_private_subnet_cidr_block_a" {}
// private_subnet_c
variable "redmine_private_subnet_cidr_block_c" {}
// nat_gateway
variable "redmine_nat_gateway_nat_eip_allocation_id" {}
variable "redmine_public_route_cidr_blocks" {default = []}