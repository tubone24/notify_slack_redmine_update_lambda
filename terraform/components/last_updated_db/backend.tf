terraform {
  backend "s3" {
    key    = "last_updated_db/terraform.tfstate"
    region = "ap-northeast-1"
  }
}