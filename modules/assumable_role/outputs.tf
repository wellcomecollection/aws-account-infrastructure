# Note: we export the same outputs as the `aws_iam_role` resource,
# so this module can be used as a drop-in replacement.

output "arn" {
  value = aws_iam_role.role.arn
}

output "name" {
  value = aws_iam_role.role.name
}
