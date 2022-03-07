# findings-data-s3-users #

[![GitHub Build Status](https://github.com/cisagov/findings-data-s3-users/workflows/build/badge.svg)](https://github.com/cisagov/findings-data-s3-users/actions)

This is a Terraform project for creating AWS users that have permission to read
and write to the S3 bucket that is used by the
[cisagov/findings-data-import-lambda](https://github.com/cisagov/findings-data-import-lambda)
project.

## Pre-requisites ##

- [Terraform](https://www.terraform.io/) installed on your system.
- AWS CLI access
  [configured](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)
  for the appropriate account on your system.
- An accessible AWS S3 bucket to store Terraform state
  (specified in [`backend.tf`](backend.tf)).
- An accessible AWS DynamoDB database to store the Terraform state lock
  (specified in [`backend.tf`](backend.tf)).
- User accounts for all users must have been created previously. We recommend
  using the
  [`cisagov/cyhy-users-non-admin`](https://github.com/cisagov/cyhy-users-non-admin)
  repository to create users.

## Customizing Your Environment ##

Create a terraform variables file to be used for your environment (e.g.
  `production.tfvars`), based on the variables listed in [Inputs](#Inputs)
  below. Here is a sample of what that file might look like:

```hcl
aws_region = "us-east-2"

findings_data_s3_bucket = "findings-data"

users = ["john.doe". "jane.smith"]

tags = {
  Team        = "CISA Development Team"
  Application = "Findings Data Import"
  Workspace   = "production"
}
```

## Building the Terraform-based infrastructure ##

1. Create a Terraform workspace (if you haven't already done so) by running:

   ```console
   terraform workspace new <workspace_name>`
   ```

1. Create a `<workspace_name>.tfvars` file with all of the required
   variables and any optional variables desired (see [Inputs](#Inputs) below
   for details).
1. Run the command `terraform init`.
1. Create the Terraform infrastructure by running the command:

   ```console
   terraform apply -var-file=<workspace_name>.tfvars
   ```

## Tearing down the Terraform-based infrastructure ##

1. Select the appropriate Terraform workspace by running
   `terraform workspace select <workspace_name>`.
1. Destroy the Terraform infrastructure in that workspace by running
   `terraform destroy -var-file=<workspace_name>.tfvars`.

## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| aws | ~> 3.38 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 3.38 |

## Modules ##

No modules.

## Resources ##

| Name | Type |
|------|------|
| [aws_iam_group.findings_data_s3_users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_policy_attachment.findingsbucketfullaccess_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.findingsbucketfullaccess_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_user_group_membership.user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.findingsbucketfullaccess_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_user.users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_user) | data source |
| [aws_s3_bucket.findings_data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | The AWS region to deploy into (e.g. us-east-1). | `string` | `"us-east-1"` | no |
| findings\_data\_s3\_bucket | The name of the S3 bucket where findings data is stored.  Note that in production workspaces, '-production' is automatically appended this bucket name.  In non-production workspaces, '-<workspace\_name>' is automatically appended to this bucket name. | `string` | n/a | yes |
| findings\_data\_s3\_users\_group\_name | The base name of the group to be created for findings data S3 bucket access users.  Note that in production workspaces, '-production' is automatically appended this bucket name.  In non-production workspaces, '-<workspace\_name>' is automatically appended to this bucket name. | `string` | `"findings_data_s3_users"` | no |
| findingsbucketfullaccess\_policy\_description | The description to associate with the IAM policy that allows full access to the findings data S3 bucket. | `string` | `"Allows full access to the S3 bucket where findings data is stored."` | no |
| findingsbucketfullaccess\_policy\_name | The base name to associate with the IAM policy that allows full access to the findings data S3 bucket.  Note that in production workspaces, '-production' is automatically appended this bucket name.  In non-production workspaces, '-<workspace\_name>' is automatically appended to this bucket name. | `string` | `"FindingsBucketFullAccess"` | no |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |
| users | A list of the usernames for the users that should be given access to the S3 bucket that manages Assessment findings data. | `list(string)` | n/a | yes |

## Outputs ##

No outputs.

## Notes ##

Running `pre-commit` requires running `terraform init` in every directory that
contains Terraform code. In this repository, this is only the main directory.

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
