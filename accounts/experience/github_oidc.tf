module "s3_dash_write_assume_role" {
  source = "../../modules/github_repo_role"
  policy_document = data.aws_iam_policy_document.github_actions_assume_role_policy.json
  github_repositories = [
    "wellcomecollection/wellcomecollection.org",
  ]
  role_name = "s3_dash_write"
  github_oidc_provider_arn = module.experience_account.openid_connect_provider_arn
}

// We allow the GitHub Actions role to assume the appropriate role to perform build actions
data "aws_iam_policy_document" "github_actions_assume_role_policy" {
  statement {
    actions = ["s3:*"]
    resources = [
      "arn:aws:s3:::dash.wellcomecollection.org"
    ]
  }
}

output "github_actions_assume_role_arn" {
  value = module.s3_dash_write_assume_role.role_arn
}