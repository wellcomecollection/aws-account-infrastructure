output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "public_route_table_id" {
  value = module.vpc.public_route_table_id
}

output "private_route_table_id" {
  value = module.vpc.private_route_table_id
}

output "nat" {
  value = module.vpc.nat
}

output "vpc" {
  value = module.vpc.vpc
}

output "cidr_block_public" {
  value = local.cidr_block_public
}

output "cidr_block_private" {
  value = local.cidr_block_private
}
