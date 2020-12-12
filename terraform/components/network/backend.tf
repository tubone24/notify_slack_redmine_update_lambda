terraform {
  backend "s3" {
    key    = "terraform/redmine/network.tfstate"
    region = "ap-northeast-1"
  }
}