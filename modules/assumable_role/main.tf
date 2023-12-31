resource "aws_iam_role" "role" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  max_session_duration = local.max_session_duration
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.principals
    }

    actions = ["sts:AssumeRole"]
  }
}
