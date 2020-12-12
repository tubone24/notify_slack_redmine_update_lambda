variable "env" {}
variable "account_id" {}
variable "region" {}
variable "profile_name" {}

variable "last_updated_db" {
  type = "map"
  default = {
    read_capacity = ""
    write_capacity = ""
    hash_key = ""
    attribute_name = ""
    attribute_type = ""
  }
}