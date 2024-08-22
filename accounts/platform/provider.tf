locals {
  default_tags = {
    TerraformConfigurationURL = "https://github.com/wellcomecollection/aws-account-infrastructure/tree/main/accounts/platform"
  }
}

provider "aws" {
  region = "eu-west-1"

  assume_role {
    role_arn = "arn:aws:iam::760097843905:role/platform-admin"
  }

  default_tags {
    tags = local.default_tags
  }
}

# Configure the GitHub Provider
# Create a fine-grained personal access token in Github and 
# export TF_VAR_github_token=<your-token-here> before applying the tf
provider "github" {
  owner = "wellcomecollection" 
  token = "${var.github_token}"
}

variable "github_token" {
  type = string
}