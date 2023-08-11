module "reporting_account" {
  source = "../../modules/account_roles"

  prefix = "reporting"

  infra_bucket_arn = "arn:aws:s3:::wellcomecollection-reporting-infra"
}
