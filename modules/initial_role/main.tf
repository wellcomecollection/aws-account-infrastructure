resource "aws_iam_role" "role" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role_with_saml.json

  max_session_duration = local.max_session_duration
}

data "aws_iam_policy_document" "assume_role_with_saml" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [var.federated_principal]
    }

    actions = ["sts:AssumeRoleWithSAML"]

    condition {
      test     = "StringEquals"
      values   = ["https://signin.aws.amazon.com/saml"]
      variable = "SAML:aud"
    }
  }

  # This statement allows you to "double hop" between assumed roles
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [var.aws_principal]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy" "allow_assume_roles" {
  role   = aws_iam_role.role.name
  policy = data.aws_iam_policy_document.allow_assume_all_assumable_roles.json
}

resource "aws_iam_policy" "policy" {
  name   = var.name
  policy = data.aws_iam_policy_document.allow_assume_all_assumable_roles.json
}

data "aws_iam_policy_document" "allow_assume_all_assumable_roles" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    resources = var.assumable_roles
  }
}
