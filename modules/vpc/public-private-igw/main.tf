resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block_vpc

  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = var.name
  }
}

module "public_subnets" {
  source = "../public-igw"
  name   = "${var.name}-public"

  vpc_id = aws_vpc.vpc.id

  cidr_block = var.cidr_block_public
}

module "private_subnets" {
  source = "../subnets"
  name   = "${var.name}-private"

  vpc_id = aws_vpc.vpc.id

  cidr_block = var.cidr_block_private
}

module "nat" {
  source = "../nat"

  name = var.name

  subnet_id      = module.public_subnets.subnets[0]
  route_table_id = module.private_subnets.route_table_id
}
