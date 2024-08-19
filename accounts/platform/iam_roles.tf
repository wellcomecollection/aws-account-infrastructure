data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = [local.aws_principal]
      type        = "AWS"
    }
  }
}

# Developer S3 Scala library access

resource "aws_iam_role" "s3_scala_releases_read" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy" "s3_scala_releases_read" {
  policy = data.aws_iam_policy_document.s3_scala_releases_read.json
  role   = aws_iam_role.s3_scala_releases_read.name
}

data "aws_iam_policy_document" "s3_scala_releases_read" {
  statement {
    actions = [
      "s3:Get*",
      "s3:List*",
    ]

    resources = [
      "arn:aws:s3:::releases.mvn-repo.wellcomecollection.org/*",
    ]
  }
}

# Pull from platform ECR 

resource "aws_iam_role" "platform_ecr_read" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy" "platform_ecr_read" {
  policy = data.aws_iam_policy_document.platform_ecr_read.json
  role   = aws_iam_role.platform_ecr_read.name
}

data "aws_iam_policy_document" "platform_ecr_read" {
  statement {
    actions = [
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer"
    ]

    resources = [
      "760097843905.dkr.ecr.eu-west-1.amazonaws.com/*",
    ]
  }
}

