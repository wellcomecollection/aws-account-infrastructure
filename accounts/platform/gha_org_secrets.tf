// this is required here in the child module to ensure correct resolution 
terraform {
  required_providers {
    github = {
      source = "integrations/github"
    }
  }
}

data "github_repository" "catalogue-api" {
  full_name = "wellcomecollection/catalogue-api"
}
data "github_repository" "catalogue-pipeline" {
  full_name = "wellcomecollection/catalogue-pipeline"
}
data "github_repository" "concepts-pipeline" {
  full_name = "wellcomecollection/concepts-pipeline"
}
data "github_repository" "storage-service" {
  full_name = "wellcomecollection/storage-service"
}
data "github_repository" "scala-libs" {
  full_name = "wellcomecollection/scala-libs"
}

// creates a gha secret at the org level

// secret value for role arn allowing access to formatting resources, eg. images, S3
resource "github_actions_organization_secret" "gha_scala_formatting_role_arn" {
  secret_name             = "GHA_SCALA_FORMATTING_ROLE_ARN"
  visibility              = "selected"
  selected_repository_ids = [
    data.github_repository.catalogue-api.repo_id,
    data.github_repository.catalogue-pipeline.repo_id,
    data.github_repository.concepts-pipeline.repo_id,
    data.github_repository.storage-service.repo_id,
    data.github_repository.scala-libs.repo_id
  ]
  plaintext_value         = module.gha_scala_formatting_role.role_arn
}