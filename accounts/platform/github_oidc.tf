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

module "gha_scala_formatting_role" {
  source          = "../../modules/github_repo_role"
  policy_document = data.aws_iam_policy_document.gha_scala_formatting.json
  github_repositories = [
    "wellcomecollection/catalogue-api",
  ]
  role_name                = "scala_formatting"
  github_oidc_provider_arn = module.aws_account.openid_connect_provider_arn
}

data "aws_iam_policy_document" "gha_scala_formatting" {
  statement {
    actions = [
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
    ]

    resources = [
      "arn:aws:ecr:eu-west-1:760097843905:repository/wellcome/sbt_wrapper",
      "arn:aws:ecr:eu-west-1:760097843905:repository/pyfound/black"
    ]
  }
  statement {
    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = [
      "*"
    ]
  }
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    resources = [
      aws_iam_role.s3_scala_releases_read.arn
    ]
  }
}

output "gha_scala_formatting_role_arn" {
  value = module.gha_scala_formatting_role.role_arn
}