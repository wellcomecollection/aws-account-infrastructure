locals {
  default_tags = {
    TerraformConfigurationURL = "https://github.com/wellcomecollection/aws-account-infrastructure/tree/main/accounts/identity"
  }
}

provider "aws" {
  region = "eu-west-1"

  assume_role {
    role_arn = "arn:aws:iam::770700576653:role/identity-admin"
  }

  default_tags {
    tags = local.default_tags
  }
}

provider "aws" {
  region = "eu-west-1"
  alias  = "platform"

  assume_role {
    role_arn = "arn:aws:iam::760097843905:role/platform-admin"
  }

  default_tags {
    tags = local.default_tags
  }
}
