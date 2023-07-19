resource "aws_iam_user" "admin-user" {
    name = "lucy"
    tags = {
        Description ="Tech Team Lead"
    }
}