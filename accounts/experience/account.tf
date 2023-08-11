module "experience_account" {
  source = "../../modules/account_roles"

  prefix = "experience"

  infra_bucket_arn = "arn:aws:s3:::wellcomecollection-experience-infra"
}
