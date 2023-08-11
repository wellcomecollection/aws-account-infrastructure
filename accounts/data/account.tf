module "data_account" {
  source = "../../modules/account_roles"

  prefix = "data"

  infra_bucket_arn = "arn:aws:s3:::wellcomecollection-datascience-infra"
}
