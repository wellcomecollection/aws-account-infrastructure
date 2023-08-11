data "aws_caller_identity" "current" {}

locals {
  aws_region = "eu-west-1"
  account_id = data.aws_caller_identity.current.account_id
}

resource "aws_iam_role_policy" "catalogue_ci" {
  role   = module.catalogue_account.ci_role.name
  policy = data.aws_iam_policy_document.catalogue_ci.json
}

data "aws_iam_policy_document" "catalogue_ci" {
  # Secrets required for internal model checker to run
  statement {
    actions = [
      "secretsmanager:GetSecretValue",
    ]

    resources = [
      "arn:aws:secretsmanager:${local.aws_region}:${local.account_id}:secret:elasticsearch/pipeline_storage_*",
    ]
  }
}
