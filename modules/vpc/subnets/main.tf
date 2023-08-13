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

  cidr_block = cidrsubnet(var.cidr_block, var.cidrsubnet_newbits, index(local.az_names, each.key))

  vpc_id = var.vpc_id

  map_public_ip_on_launch = var.map_public_ips_on_launch

  tags = {
    Name         = "${var.name}-${each.key}-${index(local.az_names, each.key)}"
    Availability = local.availability
  }
}

moved {
  from = aws_subnet.subnet[0]
  to   = aws_subnet.subnet["eu-west-1a"]
}

moved {
  from = aws_subnet.subnet[1]
  to   = aws_subnet.subnet["eu-west-1b"]
}

moved {
  from = aws_subnet.subnet[2]
  to   = aws_subnet.subnet["eu-west-1c"]
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

moved {
  from = aws_route_table_association.network[0]
  to   = aws_route_table_association.network["eu-west-1a"]
}

moved {
  from = aws_route_table_association.network[1]
  to   = aws_route_table_association.network["eu-west-1b"]
}

moved {
  from = aws_route_table_association.network[2]
  to   = aws_route_table_association.network["eu-west-1c"]
}
