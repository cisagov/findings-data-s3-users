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

variable "findings_data_s3_users_group_name" {
  default     = "findings_data_s3_users"
  description = "The base name of the group to be created for findings data S3 bucket access users. This value has the Terraform workspace appended."
  type        = string
}

variable "findingsbucketfullaccess_policy_description" {
  default     = "Allows full access to the S3 bucket where findings data is stored."
  description = "The description to associate with the IAM policy that allows full access to the findings data S3 bucket."
  type        = string
}

variable "findingsbucketfullaccess_policy_name" {
  default     = "FindingsBucketFullAccess"
  description = "The base name to associate with the IAM policy that allows full access to the findings data S3 bucket.  Note that in production workspaces, '-production' is automatically appended this bucket name.  In non-production workspaces, '-<workspace_name>' is automatically appended to this bucket name."
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created."
  default     = {}
}
