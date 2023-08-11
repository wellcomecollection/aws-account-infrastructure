output "private_subnets" {
  value = module.private_subnets.subnets
}

output "public_subnets" {
  value = module.public_subnets.subnets
}

output "public_route_table_id" {
  value = module.public_subnets.route_table_id
}

output "private_route_table_id" {
  value = module.private_subnets.route_table_id
}

output "vpc" {
  value = aws_vpc.vpc
}

output "nat" {
  value = module.nat
}
