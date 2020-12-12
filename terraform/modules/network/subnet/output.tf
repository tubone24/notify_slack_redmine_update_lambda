output "subnet_id" {
  value = aws_subnet.subnets.id
}

output "subnet_cidr_block" {
  value = aws_subnet.subnets.cidr_block
}

output "subnet_availability_zone" {
  value = aws_subnet.subnets.availability_zone
}

output "subnet_name" {
  value = aws_subnet.subnets.tags.Name
}
