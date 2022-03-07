# An IAM group for all the folks who want read-write access to the
# findings data S3 bucket.
resource "aws_iam_group" "findings_data_s3_users" {
  name = "findings_data_s3_users"
}

data "aws_s3_bucket" "findings_data" {
  bucket = local.production_workspace ? format("%s-production", var.findings_data_s3_bucket) : format("%s-%s", var.findings_data_s3_bucket, terraform.workspace)
}

# IAM policy documents that allow reading and writing to the findings data
# S3 bucket. This will be applied to the IAM group we are creating.
data "aws_iam_policy_document" "findings_data_s3_doc" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      data.aws_s3_bucket.findings_data.arn,
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]

    resources = [
      "${data.aws_s3_bucket.findings_data.arn}/*"
    ]
  }
}

# The policy for our IAM group that lets the users read/write to
# the findings data S3 bucket.
resource "aws_iam_group_policy" "findings_data_s3_users" {
  group  = aws_iam_group.findings_data_s3_users.id
  policy = data.aws_iam_policy_document.findings_data_s3_doc.json
}
