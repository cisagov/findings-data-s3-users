# An IAM group for all the folks who want read-write access to the
# findings data S3 bucket.
resource "aws_iam_group" "findings_data_s3_users" {
  name = "findings_data_s3_users"
}

resource "aws_iam_group_policy_attachment" "findingsbucketfullaccess_policy_attachment" {
  group      = aws_iam_group.findings_data_s3_users.name
  policy_arn = aws_iam_policy.findingsbucketfullaccess_policy.arn
}
