env = ""
account_id = ""
region = "ap-northeast-1"
profile_name  = ""

redmine_slack_lambda_function = {
  role             = "arn:aws:iam::xxxxx"
  memory_size      = 128
  source_code_hash = ""
  tz               = "Asia/Tokyo"
  log_level        = "INFO"
  timeout          = 300
  runtime          = "python3.8"
}

redmine_slack_environment = {
  REDMINE_URL = ""
  REDMINE_TOKEN = ""
  SINCE_DYNAMODB = ""
  SLACK_WEBHOOK_URL = ""
  AWS_REGION = "ap-northeast-1"
  PROJECT_ID = ""
}

security_group                          = {
  vpc_id      = ""
  description = "security group for redmine_slack"
}

security_group_rule                     = {
  description = ["in", "e"]
  type        = ["ingress", "egress"]
  from_port   = [80, 0]
  to_port     = [80, 0]
  protocol    = ["tcp", "-1"]
  cidr_blocks = [
    ["10.51.0.0/16"],
    ["0.0.0.0/0"]
  ]
  self        = [false, false]
}