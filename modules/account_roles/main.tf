# Admin role

module "admin_role" {
  source = "../assumable_role"
  name   = "${var.prefix}-admin"

  max_session_duration = var.max_session_duration

  principals = local.principals
}

module "admin_role_policy" {
  source    = "../role_policies/admin"
  role_name = module.admin_role.name
}

# Developer role

module "developer_role" {
  source = "../assumable_role"
  name   = "${var.prefix}-developer"

  max_session_duration = var.max_session_duration

  principals = local.principals
}

module "developer_role_policy" {
  source    = "../role_policies/developer"
  role_name = module.developer_role.name
}

# Read/only role

module "read_only_role" {
  source = "../assumable_role"
  name   = "${var.prefix}-read_only"

  max_session_duration = var.max_session_duration

  principals = local.principals
}

module "read_only_role_policy" {
  source    = "../role_policies/read_only"
  role_name = module.read_only_role.name
}

# CI role

module "ci_role" {
  source = "../assumable_role"
  name   = "${var.prefix}-ci"

  max_session_duration = var.max_session_duration

  principals = local.principals
}

module "ci_role_policy" {
  source    = "../role_policies/ci"
  role_name = module.ci_role.name

  infra_bucket_arn        = var.infra_bucket_arn
  sbt_releases_bucket_arn = var.sbt_releases_bucket_arn
}

module "image_builder" {
  source            = "./image-builder"
  target_account_id = var.ami_distribution_account_id
}

# This defines a couple of standard roles in our account which are
# used by the InfoSec team in D&T.
#
# These roles are used by automated scanning tools to check certain aspects
# of our accounts, e.g. scanning EC2 instances for known vulnerabilities.
#
# See the indiviudal role modules for detailed permission sets.
#
# Note: we sometimes apply slightly more restrictive permission sets
# than in the D&T-supplied roles; see individual roles for details.

module "cloudhealth" {
  source = "./cloudhealth"
}

module "qualys" {
  source = "./qualys"
}

module "threataware" {
  source = "./threataware"
}

# This is the GitHub OIDC identity provider.
module "github_oidc" {
  source = "./github-oidc"
}