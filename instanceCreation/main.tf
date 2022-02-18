provider "aws" {
  region = var.region
  access_key = "AKIA6NY7ZXOFKSWLDMN2"
  secret_key = "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"
}

terraform {
  backend "s3" {
    bucket = "navin-terraform-state"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    access_key = "AKIA6NY7ZXOFKSWLDMN2"
    secret_key = "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"
  }
}
