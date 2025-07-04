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
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc[0].id
}
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc[0].id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
resource "aws_route_table_association" "public-rta" {
  for_each       = aws_subnet.public-subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public-rt.id
}
resource "aws_subnet" "private-subnet" {
  for_each          = var.create_vpc ? { for idx, cidr in var.private_subnets_cidr : cidr => idx } : {}
  vpc_id            = aws_vpc.vpc[0].id
  cidr_block        = each.key
  availability_zone = element(["us-east-1a", "us-east-1b"], index(var.private_subnets_cidr, each.key))
}

resource "aws_nat_gateway" "ngw" {
  for_each      = aws_subnet.public-subnet
  subnet_id     = aws_subnet.public-subnet[each.key].id
  allocation_id = aws_eip.nat_ip.id
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc[0].id


  route {
    cidr_block = "0.0.0.0/0"

  }
}

resource "aws_route_table_association" "private-rta" {
  for_each       = aws_subnet.private-subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_eip" "nat_ip" {
  domain = "vpc"
}


