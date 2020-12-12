locals {
  nat_private_subnets = data.terraform_remote_state.network.nat_private_subnets
  subnet_ids = [
    local.nat_private_subnets["redmine-private-subnet-1a"],
    local.nat_private_subnets["redmine-private-subnet-1c"]
  ]
  security_group = merge(
    var.security_group,
    map("vpc_id", data.terraform_remote_state.network.vpc_id)
  )

  redmine_slack_lambda = merge(
    var.redmine_slack_lambda_function,
    map("function_name", "redmine_slack")
  )

}

data "archive_file" "redmine_slack_lambda_zip" {
  type        = "zip"
  source_dir  = "../workspace"
  output_path = "../redmine_slack.zip"
}

module "redmine_slack" {
  source = "../../modules/lambda"
  lambda_function = local.redmine_slack_lambda
  subnet_ids = local.subnet_ids
  environment = {
    variables = var.redmine_slack_environment
  }
  security_group = local.security_group
  security_group_rule = var.security_group_rule
}