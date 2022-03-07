# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "findings_data_s3_bucket" {
  type        = string
  description = "The name of the S3 bucket where findings data is stored.  Note that in production workspaces, '-production' is automatically appended this bucket name.  In non-production workspaces, '-<workspace_name>' is automatically appended to this bucket name."
}

variable "users" {
  type        = list(string)
  description = "A list of the usernames for the users that should be given access to the S3 bucket that manages Assessment findings data."
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "aws_region" {
  type        = string
  description = "The AWS region to deploy into (e.g. us-east-1)."
  default     = "us-east-1"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created."
  default     = {}
}
