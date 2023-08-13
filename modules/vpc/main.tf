locals {
  vpc_name = var.name == "" ? var.vpc_name : replace(replace("${var.name}-${var.cidr_block}", "/", "-"), ".", "-")

  cidr_block_public  = cidrsubnet(var.cidr_block, 1, 0)
  cidr_block_private = cidrsubnet(var.cidr_block, 1, 1)
}

module "vpc" {
  source = "./public-private-igw"

  name = local.vpc_name

  cidr_block_vpc = var.cidr_block

  cidr_block_public = {
    prefix  = local.cidr_block_public
    newbits = 2
  }

  cidr_block_private = {
    prefix  = local.cidr_block_private
    newbits = 2
  }
}
