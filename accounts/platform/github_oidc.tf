data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}

locals {
  // These values are published by GitHub and are used to verify the OIDC provider:
  // https://github.blog/changelog/2023-06-27-github-actions-update-on-oidc-integration-with-aws/
  // https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc_verify-thumbprint.html 
  github_oidc_thumbprints = [
    "6938fd4d98bab03faadb97b34396831e3780aea1",
    "1c58a3a8518e8759bf075b76b750d4f2df264fcd",
  ]

  github_repositories = [
    "wellcomecollection/catalogue-api",
  ]
}

// The repositories that are allowed to assume the github_actions_assume_role
variable "github_repositories" {
  type = list(string)
  default = [
    "wellcomecollection/catalogue-api",
    "wellcomecollection/catalogue-pipeline",
    "wellcomecollection/storage-service",
    "wellcomecollection/concepts-pipeline",
  ]
}

// This is used to provide federated access to the AWS account for GitHub Actions
// See: https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services

resource "aws_iam_openid_connect_provider" "github" {
  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = concat(
    local.github_oidc_thumbprints,
    [data.tls_certificate.github.certificates[0].sha1_fingerprint],
  )

  url = "https://token.actions.githubusercontent.com"
}

data "aws_iam_policy_document" "github_actions_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test = "StringLike"
      values = [
        for repo in var.github_repositories :
        "repo:%{if length(regexall(":+", repo)) > 0}${repo}%{else}${repo}:*%{endif}"
      ]
      variable = "token.actions.githubusercontent.com:sub"
    }

    condition {
      test     = "StringEquals"
      values   = ["sts.amazonaws.com"]
      variable = "token.actions.githubusercontent.com:aud"
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.github.arn]
      type        = "Federated"
    }
  }

  version = "2012-10-17"
}

resource "aws_iam_role" "github_actions" {
  name_prefix          = "github-actions-"
  description          = "Inital role assumed by the GitHub OIDC provider"
  max_session_duration = 3600 // Minimum session duration in seconds, 1 hour
  assume_role_policy   = data.aws_iam_policy_document.github_actions_assume_role.json

  depends_on = [aws_iam_openid_connect_provider.github]
}

resource "aws_iam_role_policy" "github_actions_assume_role_policy" {
  policy = data.aws_iam_policy_document.github_actions_assume_role_policy.json
  role   = aws_iam_role.github_actions.name
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
  value = aws_iam_role.github_actions.arn
}