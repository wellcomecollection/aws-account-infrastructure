module "storage_account" {
  source = "../../modules/account_roles"

  prefix = "storage"

  infra_bucket_arn = "arn:aws:s3:::wellcomecollection-storage-infra"
}
