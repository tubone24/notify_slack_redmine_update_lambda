#####################################
# InternetGW
#####################################
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = var.internet_gateway_vpc_id

  tags = {
    "Name" = var.internet_gateway_name
  }
}
