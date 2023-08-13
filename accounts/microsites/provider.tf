provider "aws" {
  region = "eu-west-1"

  assume_role {
    role_arn = "arn:aws:iam::782179017633:role/microsites-admin"
  }
}
