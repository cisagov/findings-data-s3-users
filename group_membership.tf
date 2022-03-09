# Put the users in the IAM group that gives them full access permission to the
# findings data S3 bucket.
resource "aws_iam_user_group_membership" "user" {
  for_each = toset(var.users)

  user = data.aws_iam_user.users[each.value].user_name

  groups = [
    aws_iam_group.findings_data_s3_users.name,
  ]
}
