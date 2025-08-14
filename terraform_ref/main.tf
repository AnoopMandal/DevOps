provider "aws" {
  region = var.region
  shared_credentials_files = ["/Users/amandal5/.aws/credentials"]
  shared_config_files      = ["/Users/amandal5/.aws/config"]
  profile                  = "rashmieks"
}

# create vpc
module "vpc" {
  source                  = "./modules/vpc"
  region                  = var.region
  project_name            = var.project_name
  vpc_cidr                = var.vpc_cidr
  public_subnet_az1_cidr  = var.public_subnet_az1_cidr
  public_subnet_az2_cidr  = var.public_subnet_az2_cidr
  private_subnet_az1_cidr = var.private_subnet_az1_cidr
  private_subnet_az2_cidr = var.private_subnet_az2_cidr
  secure_subnet_az1_cidr  = var.secure_subnet_az1_cidr
  secure_subnet_az2_cidr  = var.secure_subnet_az2_cidr
}