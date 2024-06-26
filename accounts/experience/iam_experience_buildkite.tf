data "aws_caller_identity" "current" {}

locals {
  aws_region = "eu-west-1"
  account_id = data.aws_caller_identity.current.account_id
}

resource "aws_iam_role_policy" "experience_ci" {
  role   = module.experience_account.ci_role.name
  policy = data.aws_iam_policy_document.experience_ci_combined.json
}

data "aws_iam_policy_document" "experience_ci_combined" {
  source_policy_documents = [
    module.github_deployment_secrets.secret_access_policy_document_json,
    data.aws_iam_policy_document.experience_ci.json
  ]
}

module "github_deployment_secrets" {
  source = "git::github.com/wellcomecollection/github-deployments-buildkite-plugin.git//secrets-tf?ref=v0.2.4"
}

data "aws_iam_policy_document" "experience_ci" {
  # Deploy front-end static websites
  dynamic "statement" {
    for_each = [
      "arn:aws:s3:::dash.wellcomecollection.org",
      "arn:aws:s3:::cardigan.wellcomecollection.org",
      "arn:aws:s3:::toggles.wellcomecollection.org",
      "arn:aws:s3:::weco-lambdas"
    ]

    content {
      actions = [
        "s3:*"
      ]

      resources = [
        statement.value,
        "${statement.value}/*",
      ]
    }
  }

  statement {
    sid = "GetPrismicSecrets"

    actions = [
      "secretsmanager:GetSecretValue",
    ]

    resources = [
      "arn:aws:secretsmanager:${local.aws_region}:${local.account_id}:secret:prismic-model/*",
    ]
  }

  statement {
    sid = "GetBuildSecrets"

    actions = [
      "secretsmanager:GetSecretValue",
    ]

    resources = [
      "arn:aws:secretsmanager:${local.aws_region}:${local.account_id}:secret:builds/*",
    ]
  }

  statement {
    sid = "GetWebAppSecrets"

    actions = [
      "secretsmanager:GetSecretValue",
    ]

    resources = [
      "arn:aws:secretsmanager:${local.aws_region}:${local.account_id}:secret:civicuk/api_key*",
    ]
  }

  statement {
    sid = "GetApiSecrets"

    actions = [
      "secretsmanager:GetSecretValue",
    ]

    resources = [
      "arn:aws:secretsmanager:${local.aws_region}:${local.account_id}:secret:catalogue_api/items/*",
    ]
  }

  statement {
    sid = "FlushPa11yCache"

    actions = [
      "cloudfront:CreateInvalidation",
    ]

    resources = [
      "arn:aws:cloudfront::${local.account_id}:distribution/EIOS79GG23UUY",
    ]
  }
}
