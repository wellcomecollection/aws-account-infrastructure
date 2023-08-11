module "storage_account" {
  source = "../modules/account/aws"

  prefix = "storage"

  infra_bucket_arn = "arn:aws:s3:::wellcomecollection-storage-infra"
}
