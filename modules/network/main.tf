module "vpc" {
  source       = "./vpc"
  project_name = var.project.name
  vpc_cidr     = var.network.vpc.cidr
}

module "subnets" {
  source               = "./subnets"
  project_name         = var.project.name
  vpc_id               = module.vpc.vpc_id
  availability_zones   = var.network.availability_zones
  public_subnet_cidrs  = var.network.subnets.public
  app_subnet_cidrs     = var.network.subnets.app
  db_subnet_cidrs      = var.network.subnets.db
}

module "routing" {
  source            = "./routing"
  project_name      = var.project.name
  vpc_id            = module.vpc.vpc_id
  igw_id            = module.vpc.igw_id
  public_subnet_ids = module.subnets.public_subnet_ids
  app_subnet_ids    = module.subnets.app_subnet_ids
  db_subnet_ids     = module.subnets.db_subnet_ids
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.subnets.public_subnet_ids
}

output "app_subnet_ids" {
  value = module.subnets.app_subnet_ids
}

output "db_subnet_ids" {
  value = module.subnets.db_subnet_ids
}

output "nat_gateway_id" {
  value = module.routing.nat_gateway_id
}

output "eip_address" {
  value = module.routing.eip_address
}
