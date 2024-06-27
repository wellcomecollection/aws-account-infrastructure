module "experience_gha" {
  source          = "../../modules/github_repo_role"
  policy_document = data.aws_iam_policy_document.github_actions_assume_role_policy.json
  github_repositories = [
    "wellcomecollection/wellcomecollection.org",
  ]
  role_name                = "experience"
  github_oidc_provider_arn = module.experience_account.openid_connect_provider_arn
}

data "aws_iam_policy_document" "github_actions_assume_role_policy" {

  # Below here are actions for deploying the prismic linting project int he experience repo
  statement {
    actions = [
      "s3:putObject",
    ]
    resources = [
      "arn:aws:s3:::dash.wellcomecollection.org/prismic-linting/report.json"
    ]
  }

  statement {
    actions = [
      "cloudfront:CreateInvalidation",
    ]

    resources = [
      "arn:aws:cloudfront::${local.account_id}:distribution/EIOS79GG23UUY",
    ]
  }
}

output "github_actions_assume_role_arn" {
  value = module.s3_dash_write_assume_role.role_arn
}