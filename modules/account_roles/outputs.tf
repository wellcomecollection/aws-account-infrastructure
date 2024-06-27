output "admin_role" {
  value = module.admin_role
}

output "developer_role" {
  value = module.developer_role
}

output "read_only_role" {
  value = module.read_only_role
}

output "ci_role" {
  value = module.ci_role
}

output "openid_connect_provider_arn" {
  value = module.github_oidc.openid_connect_provider_arn
}