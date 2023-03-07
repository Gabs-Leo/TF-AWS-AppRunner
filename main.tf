module "vpc" {
  source = "./modules/vpc"
  environment = var.environment
  project_region = var.project_region
  project_name = var.project_name
}

module "pub_subnet" {
  source = "./modules/subnet"
  project_name = var.project_name
  project_region = var.project_region
  environment = var.environment
  vpc_id = module.vpc.id

  route_table_id = module.pub_route_table.id
  is_public = true
}

module "pvt_subnet" {
  source = "./modules/subnet"
  project_name = var.project_name
  project_region = var.project_region
  environment = var.environment
  vpc_id = module.vpc.id

  route_table_id = module.pvt_route_table.id
  cidr = "10.10.30.0/24"
  is_public = false
}

module "pub_route_table" {
  source = "./modules/route_table"
  environment = var.environment
  project_region = var.project_region
  project_name = var.project_name
  internet_gateway_id = module.vpc.internet_gateway_id
  vpc_id = module.vpc.id

  is_public = true
}

module "pvt_route_table" {
  source = "./modules/route_table"
  environment = var.environment
  project_region = var.project_region
  project_name = var.project_name
  internet_gateway_id = module.vpc.internet_gateway_id
  vpc_id = module.vpc.id

  is_public = false
}