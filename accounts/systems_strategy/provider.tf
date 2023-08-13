provider "aws" {
  region = "eu-west-1"

  assume_role {
    role_arn = "arn:aws:iam::487094370410:role/systems_strategy-admin"
  }
}
