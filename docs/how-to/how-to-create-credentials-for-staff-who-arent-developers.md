# How to get credentials for staff who aren't developers

There are some staff who work in our AWS estate, but who aren't developers and who can't use the aws-azure-login CLI tool.

For example, Collections staff who need to access born-digital archives in our S3 buckets.

For these staff, we create per-person IAM users and give them the IAM access keys.
These users have tightly scoped permissions to do exactly the task in question, and nothing more.

These per-person IAM users are managed in Terraform in our (private) [iam-users repository](https://github.com/wellcomecollection/iam-users/).
