output "admin_role_arn" {
  value = module.reporting_account.admin_role.arn
}

output "developer_role_arn" {
  value = module.reporting_account.developer_role.arn
}

output "read_only_role_arn" {
  value = module.reporting_account.read_only_role.arn
}

output "ci_role_arn" {
  value = module.reporting_account.ci_role.arn
}


