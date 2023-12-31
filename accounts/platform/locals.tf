locals {
  account_id        = data.aws_caller_identity.current.account_id
  aws_principal     = "arn:aws:iam::${local.account_id}:root"
  ci_agent_role_arn = data.terraform_remote_state.builds.outputs.ci_role_arn

  aws_region = "eu-west-1"

  catalogue_account_roles        = data.terraform_remote_state.accounts_catalogue.outputs
  data_account_roles             = data.terraform_remote_state.accounts_data.outputs
  digirati_account_roles         = data.terraform_remote_state.accounts_digirati.outputs
  digitisation_account_roles     = data.terraform_remote_state.accounts_digitisation.outputs
  experience_account_roles       = data.terraform_remote_state.accounts_experience.outputs
  reporting_account_roles        = data.terraform_remote_state.accounts_reporting.outputs
  storage_account_roles          = data.terraform_remote_state.accounts_storage.outputs
  workflow_account_roles         = data.terraform_remote_state.accounts_workflow.outputs
  identity_account_roles         = data.terraform_remote_state.accounts_identity.outputs
  microsites_account_roles       = data.terraform_remote_state.accounts_microsites.outputs
  systems_strategy_account_roles = data.terraform_remote_state.accounts_systems_strategy.outputs

  secrets_base_arn = "arn:aws:secretsmanager:${local.aws_region}:${local.account_id}:secret:"
}