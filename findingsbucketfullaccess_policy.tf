# IAM policy documents that allow reading and writing to the findings data
# S3 bucket. This will be applied to the IAM group we are creating.
data "aws_iam_policy_document" "findings_data_s3_doc" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:ListBucketVersions",
    ]

    resources = [
      data.aws_s3_bucket.findings_data.arn,
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:DeleteObject",
      "s3:DeleteObjectTagging",
      "s3:GetObject",
      "s3:GetObjectTagging",
      "s3:GetObjectVersion",
      "s3:PutObject",
      "s3:PutObjectTagging",
    ]

    resources = [
      "${data.aws_s3_bucket.findings_data.arn}/*"
    ]
  }
}
