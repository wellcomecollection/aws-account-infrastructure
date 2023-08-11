data "aws_caller_identity" "current" {}

# This defines who can be allowed to assume these roles.
#
# The rule is:
#
#   - Anybody in the current account
#   - Anybody in the platform account (which is where all our "initial roles"
#     are defined)
#
# Note that this alone does not allow every IAM entity in these two accounts
# to assume these roles.  Each entity also needs an IAM policy that allows
# it to assume the role.
#
# If you have a user and a role, then the user can only assume the role if:
#
#   1)  That user has an IAM policy that says "this user can assume
#       the role", and
#   2)  The role has an IAM policy that says "this role can be assumed
#       by this user"
#
# This module only provides (2).
#
locals {
  platform_account_id = "760097843905"
  this_account_id     = data.aws_caller_identity.current.account_id

  account_ids = distinct([
    local.platform_account_id,
    local.this_account_id
  ])

  principals = [for account_id in local.account_ids : "arn:aws:iam::${account_id}:root"]
}
