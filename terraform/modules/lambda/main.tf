#####################################
# Security Group
#####################################
resource "aws_security_group" "security_group" {
  name = "${var.lambda_function["function_name"]}-sg"
  description = var.security_group["description"]
  vpc_id = var.security_group["vpc_id"]

  tags = {
    Name = "${var.lambda_function["function_name"]}-sg"
  }
}
resource "aws_security_group_rule" "security_group_rule" {
  count = length(var.security_group_rule["type"])
  description = element(var.security_group_rule["description"], count.index)
  security_group_id = aws_security_group.security_group.id
  type = element(var.security_group_rule["type"], count.index)
  from_port = element(var.security_group_rule["from_port"], count.index)
  to_port = element(var.security_group_rule["to_port"], count.index)
  protocol = element(var.security_group_rule["protocol"], count.index)
  cidr_blocks = [element(var.security_group_rule["cidr_blocks"], count.index)]
  self = element(var.security_group_rule["self"], count.index)
}

#####################################
# Lambda
#####################################
resource "aws_lambda_function" "lambda_function" {
  filename = "redmine_slack.zip"
  function_name = var.lambda_function["function_name"]
  role = var.lambda_function["role"]
  handler = "lambda_function.lambda_handler"
  timeout = var.lambda_function["timeout"]
  runtime = var.lambda_function["runtime"]
  source_code_hash = var.lambda_function["source_code_hash"]
  memory_size = var.lambda_function["memory_size"]
  environment = [
    slice( list(var.environment), 0, length(var.environment) == 0 ? 0 : 1 )]
  vpc_config {
    security_group_ids = [aws_security_group.security_group.id]
    subnet_ids = [var.subnet_ids]
  }
}