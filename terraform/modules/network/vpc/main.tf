#####################################
# VPC
#####################################
resource "aws_vpc" "vpc" {
  cidr_block                     = var.vpc_cidr_block
  enable_dns_hostnames           = var.vpc_enable_dns_hostnames
  enable_classiclink_dns_support = var.vpc_enable_classiclink_dns_support
  instance_tenancy               = var.vpc_instance_tenancy

  tags = {
    "Name" = var.vpc_name
  }
}