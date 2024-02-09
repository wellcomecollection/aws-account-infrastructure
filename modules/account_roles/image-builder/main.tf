# This role allows AWS image builder to assume a role in the target account to distribute the image.

# create an aws iam rone in terraform called EC2ImageBuilderDistributionCrossAccountRole with a trust relationship specifiying another AWS account via a varaible
resource "aws_iam_role" "EC2ImageBuilderDistributionCrossAccountRole" {
  name = "EC2ImageBuilderDistributionCrossAccountRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Sid = "",
        Principal = {
          AWS = var.target_account_id
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "EC2ImageBuilderDistributionCrossAccountRoleAttachment" {
  name = "EC2ImageBuilderDistributionCrossAccountRoleAttachment"
  roles = [aws_iam_role.EC2ImageBuilderDistributionCrossAccountRole.name]
  policy_arn = "arn:aws:iam::aws:policy/EC2ImageBuilderCrossAccountDistributionAccess"
}