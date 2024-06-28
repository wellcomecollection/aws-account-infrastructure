locals {
  // These values are published by GitHub and are used to verify the OIDC provider:
  // https://github.blog/changelog/2023-06-27-github-actions-update-on-oidc-integration-with-aws/
  // https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc_verify-thumbprint.html 
  github_oidc_thumbprints = [
    "6938fd4d98bab03faadb97b34396831e3780aea1",
    "1c58a3a8518e8759bf075b76b750d4f2df264fcd",
  ]
}

data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}

// This is used to provide federated access to the AWS account for GitHub Actions
// See: https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services
resource "aws_iam_openid_connect_provider" "github" {
  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = concat(
    local.github_oidc_thumbprints,
    [data.tls_certificate.github.certificates[0].sha1_fingerprint],
  )

  url = "https://token.actions.githubusercontent.com"
}

output "openid_connect_provider_arn" {
  value = aws_iam_openid_connect_provider.github.arn
}