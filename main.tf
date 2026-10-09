module "core" {
  source = "./modules/core"

  vpc_cidr             = "10.0.0.0/16"
  azs                  = ["us-east-1a", "us-east-1b"]
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  db_subnet_cidrs      = ["10.0.5.0/24", "10.0.6.0/24"]
}

module "database" {
  source = "./modules/database"

  db_subnet_ids = module.core.db_subnet_ids
  db_sg_id      = module.core.db_sg_id
  db_name       = "appdb"
  db_user       = "admin"
  multi_az      = false
}

module "app" {
  source = "./modules/app"

  vpc_id             = module.core.vpc_id
  private_subnet_ids = module.core.private_subnet_ids
  app_alb_sg_id      = module.core.app_alb_sg_id
  app_instance_sg_id = module.core.app_instance_sg_id
  db_secret_arn      = module.database.db_secret_arn
}

module "web" {
  source = "./modules/web"

  vpc_id             = module.core.vpc_id
  public_subnet_ids  = module.core.public_subnet_ids
  web_alb_sg_id      = module.core.web_alb_sg_id
  web_instance_sg_id = module.core.web_instance_sg_id
  app_alb_dns        = module.app.alb_dns
}