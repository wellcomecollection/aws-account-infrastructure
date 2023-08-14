locals {
  default_tags = {
    TerraformConfigurationURL = "https://github.com/wellcomecollection/aws-account-infrastructure/tree/main/accounts/systems_strategy"
  }
}

provider "aws" {
  region = "eu-west-1"

  assume_role {
    role_arn = "arn:aws:iam::487094370410:role/systems_strategy-admin"
  }

  default_tags {
    tags = local.default_tags
  }
}
