terraform {
  backend "s3" {
    key = "redmine-slack/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config {
    bucket  = "redmine-dev-tf"
    key     = "env:/${var.env}/network/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = var.env
  }
}