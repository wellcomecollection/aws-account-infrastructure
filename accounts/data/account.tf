module "data_account" {
  source = "../modules/account/aws"

  prefix = "data"

  infra_bucket_arn = "arn:aws:s3:::wellcomecollection-datascience-infra"
}
