data "aws_availability_zones" "zones" {}

locals {
  availability = var.map_public_ips_on_launch ? "public" : "private"

  az_names = data.aws_availability_zones.zones.names
}

resource "aws_subnet" "subnet" {
  # Subnets cannot span multiple availability zones, so we need to create
  # at least one subnet in each AZ.
  for_each          = toset(local.az_names)
  availability_zone = each.key

  cidr_block = cidrsubnet(var.cidr_block.prefix, var.cidr_block.newbits, index(local.az_names, each.key))

  vpc_id = var.vpc_id

  map_public_ip_on_launch = var.map_public_ips_on_launch

  tags = {
    Name         = "${var.name}-${each.key}-${index(local.az_names, each.key)}"
    Availability = local.availability
  }
}

resource "aws_route_table" "table" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.name
  }
}

resource "aws_route_table_association" "network" {
  for_each = aws_subnet.subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.table.id
}
