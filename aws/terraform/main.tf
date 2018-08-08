provider "aws" {
  region     = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

module "sg" {
  source  = "./modules/sg"
  sg_name = "${var.site_name}"
}

module "rds" {
  source       = "./modules/rds"
  db_name      = "${var.site_name}"
  sg_id        = "${module.sg.mysql_sg_id}"
  build_tables = "${var.build_tables}"
  db_username  = "${var.db_username}"
  db_password  = "${var.db_password}"
}

module "cognito" {
  source = "./modules/cognito"

  pool_name = "${var.site_name}"
}

output "db_endpoint" {
  value = "${module.rds.db_endpoint}"
}

output "user_pool_id" {
  value = "${module.cognito.user_pool_id}"
}

output "app_client_id" {
  value = "${module.cognito.app_client_id}"
}
