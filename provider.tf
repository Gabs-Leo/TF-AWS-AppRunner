terraform {
  backend "s3" {
    bucket = "terraform-tfstate"
    key    = "dev"
    region = "us-east-2"
  }
}
provider "aws" {
  region = "us-east-2"
}