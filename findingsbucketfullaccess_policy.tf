# IAM policy document that allows full access to the findings data S3 bucket.
data "aws_iam_policy_document" "findingsbucketfullaccess_policy_doc" {
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

# The IAM policy for that allows full access to the findings data S3 bucket
resource "aws_iam_policy" "findingsbucketfullaccess_policy" {
  description = var.findingsbucketfullaccess_policy_description
  name        = var.findingsbucketfullaccess_policy_name
  policy      = data.aws_iam_policy_document.findingsbucketfullaccess_policy_doc.json
}
