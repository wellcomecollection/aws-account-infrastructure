module "s3_scala_releases_read_assume_role" {
  source          = "../../modules/github_repo_role"
  policy_document = data.aws_iam_policy_document.github_actions_assume_role_policy.json
  github_repositories = [
    "wellcomecollection/catalogue-api",
    "wellcomecollection/catalogue-pipeline",
    "wellcomecollection/storage-service",
    "wellcomecollection/concepts-pipeline",
  ]
  role_name                = "s3_scala_releases_read"
  github_oidc_provider_arn = module.aws_account.openid_connect_provider_arn
}

// We allow the GitHub Actions role to assume the appropriate role to perform build actions
data "aws_iam_policy_document" "github_actions_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    resources = [
      aws_iam_role.s3_scala_releases_read.arn
    ]
  }
}

output "github_actions_assume_role_arn" {
  value = module.s3_scala_releases_read_assume_role.role_arn
}

module "platform_ecr_read_assume_role" {
  source          = "../../modules/github_repo_role"
  policy_document = data.aws_iam_policy_document.platform_ecr_read_assume_role_policy.json
  github_repositories = [
    "wellcomecollection/catalogue-api",
  ]
  role_name                = "platform_ecr_read"
  github_oidc_provider_arn = module.aws_account.openid_connect_provider_arn
}

// We allow the GitHub Actions role to assume the appropriate role 
data "aws_iam_policy_document" "platform_ecr_read_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    resources = [
      aws_iam_role.platform_ecr_read.arn
    ]
  }
}

output "platform_ecr_read_assume_role_arn" {
  value = module.platform_ecr_read_assume_role.role_arn
}