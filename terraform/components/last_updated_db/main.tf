locals {
  shift_status_table = merge(
    var.shift_status_table,
    map("name", "redmine_last_update"),
    map("hash_key", "project_id"),
    map("attribute_name", "project_id"),
    map("attribute_type", "S")
  )
}

module "shift_status_table" {
  source = "../../modules/dynamodb"
  dynamodb_table = "${local.shift_status_table}"
}