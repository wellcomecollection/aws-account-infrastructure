module "catalogue_account" {
  source = "../../modules/account_roles"

  prefix = "catalogue"

  infra_bucket_arn = "arn:aws:s3:::wellcomecollection-catalogue-infra-delta"
}
