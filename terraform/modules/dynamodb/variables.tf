variable "dynamodb_table" {
  type = "map"
  default = {
    name = ""
    read_capacity = ""
    write_capacity = ""
    hash_key = ""
    attribute_name = ""
    attribute_type = ""
  }
}