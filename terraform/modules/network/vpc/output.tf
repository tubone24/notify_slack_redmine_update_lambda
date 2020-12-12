output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr_clock" {
  value = aws_vpc.vpc.cidr_block
}
