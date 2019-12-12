variable "aws_region" {
  description = "The AWS region to deploy into (e.g. us-east-1)."
  default     = "us-east-1"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created"
  default     = {}
}

variable "findings_data_s3_bucket" {
  description = "The name of the S3 bucket where findings data is stored.  Note that in production workspaces, '-production' is automatically appended this bucket name.  In non-production workspaces, '-<workspace_name>' is automatically appended to this bucket name."
}

variable "usernames" {
  type        = list(string)
  description = "The usernames associated with the accounts to be created.  The format first.last is recommended."
}
