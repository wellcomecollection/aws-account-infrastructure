module "storage_gha" {
  source          = "../../modules/github_repo_role"
  policy_document = data.aws_iam_policy_document.github_actions_assume_role_policy.json
  github_repositories = [
    "wellcomecollection/storage-service",
  ]
  role_name                = "storage"
  github_oidc_provider_arn = module.storage_account.openid_connect_provider_arn
}

data "aws_iam_policy_document" "github_actions_assume_role_policy" {

  # Allows uploading new objects into the Ingest Inspector frontend S3 bucket
  statement {
    actions = [
      "s3:PutObject",
    ]
    resources = [
      "arn:aws:s3:::wellcomecollection-ingest-inspector-frontend",
      "arn:aws:s3:::wellcomecollection-ingest-inspector-frontend/*",
    ]
  }

  # Allows reading and writing Lambda function code in S3
  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::wellcomecollection-storage-infra/lambdas/*",
    ]
  }

  # Allows updating the code of the Ingest Inspector backend Lambda function
  statement {
    actions = [
      "lambda:GetFunctionConfiguration",
      "lambda:UpdateFunctionCode"
    ]
    resources = [
      "arn:aws:lambda:eu-west-1:975596993436:function:ingest_inspector_backend",
      "arn:aws:lambda:eu-west-1:975596993436:function:daily_reporter"
    ]
  }
}

output "storage_gha_role_arn" {
  value = module.storage_gha.role_arn
}
