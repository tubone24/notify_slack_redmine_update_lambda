locals {
  last_updated_db = merge(
    var.last_updated_db,
    map("name", "redmine_last_update"),
    map("hash_key", "project_id"),
    map("attribute_name", "project_id"),
    map("attribute_type", "S")
  )
}

module "last_updated_db" {
  source = "../../modules/dynamodb"
  dynamodb_table = local.shift_status_table
}