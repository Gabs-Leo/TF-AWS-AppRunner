terraform {
  backend "s3" {
    bucket = "terraform-taveira"
    key    = "dev"
    region = "us-east-2"
  }
}
provider "aws" {
  region = "us-east-2"
}