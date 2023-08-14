locals {
  default_tags = {
    TerraformConfigurationURL = "https://github.com/wellcomecollection/aws-account-infrastructure/tree/main/accounts/experience"
  }
}

provider "aws" {
  region = "eu-west-1"

  assume_role {
    role_arn = "arn:aws:iam::130871440101:role/experience-admin"
  }

  default_tags {
    tags = local.default_tags
  }
}
