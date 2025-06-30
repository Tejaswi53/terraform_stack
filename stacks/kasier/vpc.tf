module "vpc" {
  source               = "../Modules"
  cidr                 = var.cidr_block
  Name                 = var.Name
  create_vpc           = var.create_vpc
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  public_subnets_cidr  = var.public_subnets_cidr
}

