locals {
  default_tags = {
    TerraformConfigurationURL = "https://github.com/wellcomecollection/aws-account-infrastructure/tree/main/accounts/storage"
  }
}

provider "aws" {
  region = "eu-west-1"

  assume_role {
    role_arn = "arn:aws:iam::975596993436:role/storage-admin"
  }

  default_tags {
    tags = local.default_tags
  }
}
