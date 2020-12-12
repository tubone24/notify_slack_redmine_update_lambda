#####################################
# DynamoDB
#####################################

resource "aws_dynamodb_table" "dynamodb_table" {
  name = var.dynamodb_table["name"]
  read_capacity = var.dynamodb_table["read_capacity"]
  write_capacity = var.dynamodb_table["write_capacity"]
  hash_key = var.dynamodb_table["hash_key"]
  stream_enabled = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = var.dynamodb_table["attribute_name"]
    type = var.dynamodb_table["attribute_type"]
  }
}