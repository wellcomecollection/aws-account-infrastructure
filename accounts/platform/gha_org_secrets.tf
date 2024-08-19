// creates a gha secret at the org level, that workflows can access to assume specific IAM roles 

resource "github_actions_organization_secret" "gha_platform_ecr_read_role_arn" {
  secret_name     = "GHA_PLATFORM_ECR_READ_ROLE_ARN"
  visibility      = "private"
  plaintext_value = module.platform_ecr_read_assume_role.role_arn
}