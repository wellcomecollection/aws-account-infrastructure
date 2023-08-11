data "aws_caller_identity" "current" {}

locals {
  platform_account_id = "760097843905"
  this_account_id     = data.aws_caller_identity.current.account_id

  account_ids = distinct([
    local.platform_account_id,
    local.this_account_id
  ])

  principals = [for account_id in local.account_ids : "arn:aws:iam::${account_id}:root"]
}
