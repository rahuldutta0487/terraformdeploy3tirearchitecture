data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

module "network" {
  source  = "./modules/network"
  project = var.project
  network = var.network
}

module "alb" {
  source            = "./modules/alb"
  project_name      = var.project.name
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
}

module "web_asg" {
  source               = "./modules/web_asg"
  project_name         = var.project.name
  vpc_id               = module.network.vpc_id
  alb_sg_id            = module.alb.security_group_id
  subnet_ids           = module.network.public_subnet_ids
  ami_id               = data.aws_ami.amazon_linux.id
  instance_type        = var.web_asg.instance_type
  key_name             = var.web_asg.key_name
  target_group_arn     = module.alb.target_group_arn
  asg_min_size         = var.web_asg.min_size
  asg_desired_capacity = var.web_asg.desired_capacity
  asg_max_size         = var.web_asg.max_size
  ssh_allowed_cidrs    = var.web_asg.ssh_allowed_cidrs
}

module "app_asg" {
  source               = "./modules/app_asg"
  project_name         = var.project.name
  vpc_id               = module.network.vpc_id
  web_sg_id            = module.web_asg.security_group_id
  subnet_ids           = module.network.app_subnet_ids
  ami_id               = data.aws_ami.amazon_linux.id
  instance_type        = var.app_asg.instance_type
  key_name             = var.app_asg.key_name
  asg_min_size         = var.app_asg.min_size
  asg_desired_capacity = var.app_asg.desired_capacity
  asg_max_size         = var.app_asg.max_size
}

module "db" {
  source         = "./modules/db"
  project_name   = var.project.name
  vpc_id         = module.network.vpc_id
  app_sg_id      = module.app_asg.security_group_id
  db_subnet_ids  = module.network.db_subnet_ids
  instance_class = var.db.instance_class
  db_name        = var.db.name
  username       = var.db.username
  password       = var.db.password
}
