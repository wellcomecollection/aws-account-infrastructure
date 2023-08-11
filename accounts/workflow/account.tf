module "workflow_account" {
  source = "../modules/account/aws"

  prefix = "workflow"

  infra_bucket_arn = "arn:aws:s3:::wellcomecollection-workflow-infra"
}
