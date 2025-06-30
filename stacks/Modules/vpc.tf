resource "aws_vpc" "vpc" {
  count                = var.create_vpc ? 1 : 0
  cidr_block           = var.cidr
  instance_tenancy     = var.tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support


  tags = {
    Name = var.Name
  }

}

resource "aws_subnet" "public-subnet" {

  for_each          = var.create_vpc ? { for idx, cidr in var.public_subnets_cidr : cidr => idx } : {}
  vpc_id            = aws_vpc.vpc[0].id
  cidr_block        = each.key
  availability_zone = element(["us-east-1a", "us-east-1b"], index(var.public_subnets_cidr, each.key))

  tags = {
    Name = "public-subnet-${index(var.public_subnets_cidr, each.key) + 1}"
  }
}


