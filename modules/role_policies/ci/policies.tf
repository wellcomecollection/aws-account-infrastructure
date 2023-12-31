data "aws_iam_policy_document" "ci_permissions" {
  statement {
    actions = [
      # This list of actions is based on an example from the AWS docs,
      # with some read-only actions added based on the IAM Visual Editor.
      # https://docs.aws.amazon.com/AmazonECR/latest/userguide/repository-policy-examples.html
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGet*",
      "ecr:Describe*",
      "ecr:Get*",
      "ecr:List*",
      "ecr:TagResource",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr-public:BatchCheckLayerAvailability",
      "ecr-public:Describe*",
      "ecr-public:Get*",
      "ecr-public:GetAuthorizationToken",
      "ecr-public:List*",
      "ecr-public:TagResource",
      "ecr-public:PutImage",
      "ecr-public:InitiateLayerUpload",
      "ecr-public:UploadLayerPart",
      "ecr-public:CompleteLayerUpload",
      # Required for updating and checking Lambdas
      "lambda:UpdateFunctionCode",
      "lambda:GetFunctionConfiguration",
      # This is required for uploading to public repositories; see https://docs.aws.amazon.com/AmazonECR/latest/public/public-repository-policy-examples.html
      "sts:GetServiceBearerToken",
    ]

    resources = [
      "*",
    ]
  }

  dynamic "statement" {
    for_each = var.infra_bucket_arn == "" ? [] : [{}]

    content {
      actions = [
        "s3:*",
      ]

      resources = [
        var.infra_bucket_arn,
        "${var.infra_bucket_arn}/*",
      ]
    }
  }

  statement {
    actions = [
      "s3:Get*",
      "s3:List*",
    ]

    resources = [
      var.sbt_releases_bucket_arn,
      "${var.sbt_releases_bucket_arn}/*",
    ]
  }

  statement {
    actions = [
      "ecs:List*",
      "ecs:Describe*",
      "ecs:UpdateService",
      "ecs:TagResource"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    actions = [
      "ssm:PutParameter",
    ]

    resources = [
      "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.current.account_id}:parameter/*",
    ]
  }

  statement {
    actions = [
      "ssm:GetParameter*",
    ]

    resources = [
      "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.current.account_id}:parameter/*/images/*",
    ]
  }

  statement {
    actions = [
      "iam:GetUser",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "sns:Publish*",
    ]

    resources = [
      "*",
    ]
  }

  # This policy allows the CI role to assume itself, this is useful when
  # a Build script has had the CI role assumption hard coded.
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.role_name}",
    ]
  }
}

data "aws_caller_identity" "current" {}
