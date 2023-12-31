output "admin_role_arn" {
  value = module.data_account.admin_role.arn
}

output "developer_role_arn" {
  value = module.data_account.developer_role.arn
}

output "read_only_role_arn" {
  value = module.data_account.read_only_role.arn
}

output "ci_role_arn" {
  value = module.data_account.ci_role.arn
}

output "datascience_vpc_private_subnets" {
  value = module.datascience_vpc.private_subnets
}

output "datascience_vpc_public_subnets" {
  value = module.datascience_vpc.public_subnets
}

output "datascience_vpc_id" {
  value = module.datascience_vpc.vpc.id
}
