# ------------------------------------------------------------------------------
# Retrieve the effective Account ID, User ID, and ARN in which
# Terraform is authorized.  This is used to calculate the session
# names for assumed roles.
# ------------------------------------------------------------------------------
data "aws_caller_identity" "current" {}

locals {
  # This is a goofy but necessary way to determine if
  # terraform.workspace contains the substring "prod"
  production_workspace = replace(terraform.workspace, "prod", "") != terraform.workspace
}
