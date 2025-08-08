resource "aws_vpc" "eComm_VPC" {
cidr_block           = var.vpc_cidr
region               = var.region
instance_tenancy     = "default"
enable_dns_hostnames = "true"

tags = {
  Name = "${var.project_name}-vpc"
}
}