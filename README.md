# AWS account infrastructure

[![Build status](https://badge.buildkite.com/83b7791f3699dd7475ce26497852c2f1b8951877f29b03b2f8.svg)](https://buildkite.com/wellcomecollection/aws-account-infrastructure)

This repo contains the Terraform configurations for all the AWS accounts owned and managed by Wellcome Collection.
In particular, it defines some of the pieces which are common to all our accounts (IAM roles, networking, permissions, etc.).

This setup is documented at <https://docs.wellcomecollection.org/aws-account-setup/>

## What's in this repo

*   [`accounts`](./accounts) – Terraform configuration for each of our AWS accounts, one folder per account
*   [`docs`](./docs) – the source files for [the GitBook site](https://docs.wellcomecollection.org/aws-account-setup/)
*   [`modules`](./modules) – some Terraform modules for the AWS account configuration
*   [`scripts`](./scripts) – a handful of Python scripts for working with our AWS accounts
