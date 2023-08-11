# Note: we run prod/staging VPCs for the identity account to isolate
# resources that interact with personally identifiable information (PII).

module "identity_vpc_prod" {
  source = "../../modules/vpc"

  vpc_name   = "identity-services-prod"
  cidr_block = "172.72.0.0/16"
}

module "identity_vpc_stage" {
  source = "../../modules/vpc"

  vpc_name   = "identity-services-stage"
  cidr_block = "172.73.0.0/16"
}
