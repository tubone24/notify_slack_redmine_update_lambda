variable "env" {}
variable "account_id" {}
variable "region" {}
variable "profile_name" {}

variable "redmine_slack_lambda_function" {
  type    = "map"
  default = {
    role             = ""
    memory_size      = 128
    source_code_hash = ""
    tz               = ""
    log_level        = ""
    timeout          = ""
    runtime          = ""
  }
}

variable "redmine_slack_environment" {
  type    = "map"
  default = {
    REDMINE_URL = ""
    REDMINE_TOKEN = ""
    SINCE_DYNAMODB = ""
    SLACK_WEBHOOK_URL = ""
    AWS_REGION = "ap-northeast-1"
    PROJECT_ID = ""
  }
}

variable "security_group" {
  type    = "map"
  default = {
    vpc_id      = ""
    description = ""
  }
}

variable "security_group_rule" {
  type    = "map"
  default = {
    type        = []
    description = []
    from_port   = []
    to_port     = []
    protocol    = []
    cidr_blocks = []
    self        = []
  }
}