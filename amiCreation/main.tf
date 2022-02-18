provider "aws" {
  region = var.region
  access_key = ""
  secret_key = ""
}

terraform {
  backend "s3" {
    bucket = "navin-terraform-state"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    access_key = ""
    secret_key = ""
  }
}
