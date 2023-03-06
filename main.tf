terraform {
  backend "s3" {
    bucket = "tfstate-propesq"
    key    = "path/"
    region = "us-east-1"
  }
}
provider "aws" {
  region = "us-east-1"
}

module "infra" {
  source = "./modules/infra"
}



