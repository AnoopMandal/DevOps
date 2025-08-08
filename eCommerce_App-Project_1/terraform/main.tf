module "vpc" {
  source       = "../modules/vpc"
  vpc_cidr     = var.cidr
  region       = var.region
  project_name = var.project_name
}