// this is required here in the child module to ensure correct resolution 
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
    }
  }
}
// creates a gha secret at the org level

// secret value for role-to-assume in workflows that need to pull from ecr
resource "github_actions_organization_secret" "gha_scala_formatting_role_arn" {
  secret_name     = "GHA_SCALA_FORMATTING_ROLE_ARN"
  visibility      = "private"
  plaintext_value = module.gha_scala_formatting_role.role_arn
}