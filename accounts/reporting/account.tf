module "reporting_account" {
  source = "../modules/account/aws"

  prefix = "reporting"

  infra_bucket_arn = "arn:aws:s3:::wellcomecollection-reporting-infra"
}
