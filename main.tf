module "vpc" {
  source = "./modules/vpc"
  environment = var.environment
  project_region = var.project_region
}

module "pub_subnet" {
  source = "./modules/subnet"
  vpc_id = module.vpc.id
  route_table_id = route_table_id
  is_public = true
}

module "pvt_subnet" {
  source = "./modules/subnet"
  vpc_id = module.vpc.id
  route_table_id = route_table_id
  is_public = false
}