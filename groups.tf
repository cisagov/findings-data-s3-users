# An IAM group for all the folks who want read-write access to the
# findings data S3 bucket.
resource "aws_iam_group" "findings_data_s3_users" {
  name = "findings_data_s3_users"
}

# The policy for our IAM group that lets the users read/write to
# the findings data S3 bucket.
resource "aws_iam_group_policy" "findings_data_s3_users" {
  group  = aws_iam_group.findings_data_s3_users.id
  policy = data.aws_iam_policy_document.findings_data_s3_doc.json
}
