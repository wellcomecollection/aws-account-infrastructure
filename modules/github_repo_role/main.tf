// The repositories that are allowed to assume the github_actions_assume_role
variable "github_repositories" {
  type = list(string)
}

variable "github_oidc_provider_arn" {
  type = string
}

variable "role_name" {
  type = string
}

variable "policy_document" {
  type = string
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
      identifiers = [var.github_oidc_provider_arn]
      type        = "Federated"
    }
  }

  version = "2012-10-17"
}

resource "aws_iam_role" "github_actions" {
  name_prefix          = "gha-${var.role_name}-"
  description          = "Inital role assumed by the GitHub OIDC provider"
  max_session_duration = 3600 // Minimum session duration in seconds, 1 hour
  assume_role_policy   = data.aws_iam_policy_document.github_actions_assume_role.json
}

resource "aws_iam_role_policy" "github_actions_assume_role_policy" {
  policy = var.policy_document
  role   = aws_iam_role.github_actions.name
}

output "role_arn" {
  value = aws_iam_role.github_actions.arn
}