# Initial role

This module creates an IAM role which can be assumed by a given list of IAM principals.

These IAM principals can be in a different account -- for example, this could create an IAM role in account A that can be assumed by users in accounts B and C.

It's a wrapper around the `aws_iam_role` resource.
