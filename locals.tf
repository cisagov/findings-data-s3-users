# ------------------------------------------------------------------------------
# Retrieve the effective Account ID, User ID, and ARN in which
# Terraform is authorized.  This is used to calculate the session
# names for assumed roles.
# ------------------------------------------------------------------------------
data "aws_caller_identity" "current" {}

# Retrieve information about the findings data bucket we will be providing access
# for with this workspace.
data "aws_s3_bucket" "findings_data" {
  bucket = local.findings_data_s3_bucket
}

locals {
  # Determine if this is a Production workspace by checking
  # if terraform.workspace begins with "prod"
  production_workspace = length(regexall("^prod", terraform.workspace)) == 1

  findings_data_s3_bucket = local.production_workspace ? format("%s-production", var.findings_data_s3_bucket) : format("%s-%s", var.findings_data_s3_bucket, terraform.workspace)

  findingsbucketfullaccess_policy_name = local.production_workspace ? format("%s-production", var.findingsbucketfullaccess_policy_name) : format("%s-%s", var.findingsbucketfullaccess_policy_name, terraform.workspace)

  findings_data_s3_users_group_name = local.production_workspace ? format("%s-production", var.findings_data_s3_users_group_name) : format("%s-%s", var.findings_data_s3_users_group_name, terraform.workspace)
}
