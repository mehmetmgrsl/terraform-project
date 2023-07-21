resource "aws_iam_user" "admin-user" {
  name = "lucy"
  tags = {
    Description = "Tech Team Lead"
  }
}

resource "aws_iam_policy" "admin-policy" {
  name = "AdminUsers"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "*",
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "test-attach" {
  user       = aws_iam_user.admin-user.name
  policy_arn = aws_iam_policy.admin-policy.arn
}
