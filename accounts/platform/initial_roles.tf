# This defines the initial IAM roles that users assume when they
# log into our AWS estate.
#
# See https://docs.wellcomecollection.org/aws-account-setup/users-iam-roles-accounts-and-so-on/what-is-an-initial-role#which-initial-role-do-you-use

module "super_dev_initial_role" {
  source = "../../modules/initial_role"

  name = "platform-superdev"

  federated_principal = module.account_federation.principal
  aws_principal       = local.aws_principal

  max_session_duration = "4 hrs"

  assumable_roles = [
    # Platform
    module.aws_account.admin_role.arn,
    module.aws_account.developer_role.arn,
    module.aws_account.read_only_role.arn,

    # Identity
    local.identity_account_roles["admin_role_arn"],
    local.identity_account_roles["developer_role_arn"],
    local.identity_account_roles["read_only_role_arn"],

    # Workflow
    local.workflow_account_roles["admin_role_arn"],
    local.workflow_account_roles["developer_role_arn"],
    local.workflow_account_roles["read_only_role_arn"],

    local.workflow_account_roles["workflow_support_role_arn"],

    # Digirati
    local.digirati_account_roles["admin_role_arn"],
    local.digirati_account_roles["developer_role_arn"],
    local.digirati_account_roles["read_only_role_arn"],

    # Storage
    local.storage_account_roles["admin_role_arn"],
    local.storage_account_roles["developer_role_arn"],
    local.storage_account_roles["read_only_role_arn"],

    # Experience
    local.experience_account_roles["admin_role_arn"],
    local.experience_account_roles["developer_role_arn"],
    local.experience_account_roles["read_only_role_arn"],

    # Data
    local.data_account_roles["developer_role_arn"],
    local.data_account_roles["read_only_role_arn"],
    local.data_account_roles["admin_role_arn"],

    # Reporting
    local.reporting_account_roles["developer_role_arn"],
    local.reporting_account_roles["read_only_role_arn"],
    local.reporting_account_roles["admin_role_arn"],

    # Digitisation
    local.digitisation_account_roles["developer_role_arn"],
    local.digitisation_account_roles["read_only_role_arn"],
    local.digitisation_account_roles["admin_role_arn"],

    # Catalogue
    local.catalogue_account_roles["developer_role_arn"],
    local.catalogue_account_roles["read_only_role_arn"],
    local.catalogue_account_roles["admin_role_arn"],

    # Microsites account
    local.microsites_account_roles["developer_role_arn"],
    local.microsites_account_roles["read_only_role_arn"],
    local.microsites_account_roles["admin_role_arn"],

    # Systems strategy account
    local.systems_strategy_account_roles["developer_role_arn"],
    local.systems_strategy_account_roles["read_only_role_arn"],
    local.systems_strategy_account_roles["admin_role_arn"],

    # CI Roles
    local.ci_agent_role_arn,
    module.aws_account.ci_role.arn,
    local.catalogue_account_roles["ci_role_arn"],
    local.data_account_roles["ci_role_arn"],
    local.digirati_account_roles["ci_role_arn"],
    local.reporting_account_roles["ci_role_arn"],
    local.storage_account_roles["ci_role_arn"],
    local.data_account_roles["ci_role_arn"],
    local.workflow_account_roles["ci_role_arn"],
    local.identity_account_roles["ci_role_arn"],
    local.digitisation_account_roles["ci_role_arn"],
    local.experience_account_roles["ci_role_arn"],

    aws_iam_role.s3_scala_releases_read.arn,

    # Route 53
    "arn:aws:iam::267269328833:role/wellcomecollection-assume_role_hosted_zone_update",
  ]
}

module "platform_dev_initial_role" {
  source = "../../modules/initial_role"

  name = "platform-dev"

  federated_principal = module.account_federation.principal
  aws_principal       = local.aws_principal

  assumable_roles = [
    # Platform
    module.aws_account.developer_role.arn,
    module.aws_account.read_only_role.arn,

    # Digirati
    local.digirati_account_roles["developer_role_arn"],
    local.digirati_account_roles["read_only_role_arn"],

    # Workflow
    local.workflow_account_roles["developer_role_arn"],
    local.workflow_account_roles["read_only_role_arn"],

    # Storage
    local.storage_account_roles["developer_role_arn"],
    local.storage_account_roles["read_only_role_arn"],

    # Experience
    local.experience_account_roles["developer_role_arn"],
    local.experience_account_roles["read_only_role_arn"],

    # Data
    local.data_account_roles["developer_role_arn"],
    local.data_account_roles["read_only_role_arn"],

    # Reporting
    local.reporting_account_roles["developer_role_arn"],
    local.reporting_account_roles["read_only_role_arn"],

    # Catalogue
    local.catalogue_account_roles["developer_role_arn"],
    local.catalogue_account_roles["read_only_role_arn"],

    # Digitisation
    local.digitisation_account_roles["developer_role_arn"],
    local.digitisation_account_roles["read_only_role_arn"],

    # Scala lib read Role
    aws_iam_role.s3_scala_releases_read.arn,

    # CI Roles
    module.aws_account.ci_role.arn,
    local.catalogue_account_roles["ci_role_arn"],
    local.data_account_roles["ci_role_arn"],
    local.digirati_account_roles["ci_role_arn"],
    local.reporting_account_roles["ci_role_arn"],
    local.storage_account_roles["ci_role_arn"],
    local.workflow_account_roles["ci_role_arn"],
    local.digitisation_account_roles["ci_role_arn"],
    local.experience_account_roles["ci_role_arn"],
  ]
}

module "storage_dev_initial_role" {
  source = "../../modules/initial_role"

  name = "storage-dev"

  federated_principal = module.account_federation.principal
  aws_principal       = local.aws_principal

  assumable_roles = [
    # Platform
    module.aws_account.read_only_role.arn,

    # Workflow
    local.workflow_account_roles["developer_role_arn"],
    local.workflow_account_roles["read_only_role_arn"],

    # Digirati
    local.digirati_account_roles["developer_role_arn"],
    local.digirati_account_roles["read_only_role_arn"],

    # Storage
    local.storage_account_roles["developer_role_arn"],
    local.storage_account_roles["read_only_role_arn"],

    # Scala lib read Role
    aws_iam_role.s3_scala_releases_read.arn,
  ]
}

module "workflow_dev_initial_role" {
  source = "../../modules/initial_role"

  name = "workflow-dev"

  federated_principal = module.account_federation.principal
  aws_principal       = local.aws_principal

  assumable_roles = [
    # Workflow
    local.workflow_account_roles["admin_role_arn"],
    local.workflow_account_roles["developer_role_arn"],
    local.workflow_account_roles["read_only_role_arn"],

    local.workflow_account_roles["workflow_support_role_arn"],
  ]
}

module "data_analyst_initial_role" {
  source = "../../modules/initial_role"

  name = "data-analyst"

  federated_principal = module.account_federation.principal
  aws_principal       = local.aws_principal

  assumable_roles = [
    module.aws_account.read_only_role.arn,
    local.experience_account_roles["read_only_role_arn"],
    local.workflow_account_roles["read_only_role_arn"],

    local.storage_account_roles["read_only_role_arn"],
    local.reporting_account_roles["read_only_role_arn"],
    local.data_account_roles["read_only_role_arn"],
  ]
}

module "data_dev_initial_role" {
  source = "../../modules/initial_role"

  name = "data-dev"

  federated_principal = module.account_federation.principal
  aws_principal       = local.aws_principal

  assumable_roles = [
    # Platform
    # Currently the admin role is needed as we have a lot of
    # infra in the platform account that should be in the catalogue account
    module.aws_account.admin_role.arn,
    module.aws_account.developer_role.arn,
    module.aws_account.read_only_role.arn,
    module.aws_account.ci_role.arn,

    # Data
    local.data_account_roles["admin_role_arn"],
    local.data_account_roles["developer_role_arn"],
    local.data_account_roles["read_only_role_arn"],
    local.data_account_roles["ci_role_arn"],

    # Reporting
    local.reporting_account_roles["developer_role_arn"],
    local.reporting_account_roles["read_only_role_arn"],
    local.reporting_account_roles["ci_role_arn"],

    # Catalogue
    local.catalogue_account_roles["developer_role_arn"],
    local.catalogue_account_roles["read_only_role_arn"],
    local.catalogue_account_roles["ci_role_arn"],

    # Experience
    local.experience_account_roles["developer_role_arn"],
    local.experience_account_roles["read_only_role_arn"],

    # Scala lib read Role
    aws_iam_role.s3_scala_releases_read.arn,
  ]
}

module "digitisation_dev_initial_role" {
  source = "../../modules/initial_role"

  name = "digitisation-dev"

  federated_principal = module.account_federation.principal
  aws_principal       = local.aws_principal

  assumable_roles = [
    # Platform
    module.aws_account.read_only_role.arn,

    # Digitisation
    local.digitisation_account_roles["developer_role_arn"],
    local.digitisation_account_roles["read_only_role_arn"],

    # Workflow
    local.workflow_account_roles["read_only_role_arn"],
    local.workflow_account_roles["workflow_support_role_arn"],

    # Storage
    local.storage_account_roles["read_only_role_arn"],

    # Scala lib read Role
    aws_iam_role.s3_scala_releases_read.arn,
  ]
}

module "digitisation_admin_initial_role" {
  source = "../../modules/initial_role"

  name = "digitisation-admin"

  federated_principal = module.account_federation.principal
  aws_principal       = local.aws_principal

  assumable_roles = [
    # Platform
    module.aws_account.read_only_role.arn,

    # Digitisation
    local.digitisation_account_roles["admin_role_arn"],
    local.digitisation_account_roles["developer_role_arn"],
    local.digitisation_account_roles["read_only_role_arn"],

    # Workflow
    local.workflow_account_roles["read_only_role_arn"],
    local.workflow_account_roles["workflow_support_role_arn"],

    # Storage
    local.storage_account_roles["read_only_role_arn"],

    # Scala lib read Role
    aws_iam_role.s3_scala_releases_read.arn,
  ]
}

module "digirati_dev_initial_role" {
  source = "../../modules/initial_role"

  name = "digirati-dev"

  federated_principal = module.account_federation.principal
  aws_principal       = local.aws_principal

  assumable_roles = [
    # Platform
    module.aws_account.read_only_role.arn,

    # Digirati
    local.digirati_account_roles["admin_role_arn"],
    local.digirati_account_roles["developer_role_arn"],
    local.digirati_account_roles["read_only_role_arn"],
    local.digirati_account_roles["ci_role_arn"],

    # Workflow
    local.workflow_account_roles["read_only_role_arn"],

    # Storage
    local.storage_account_roles["read_only_role_arn"]
  ]
}
