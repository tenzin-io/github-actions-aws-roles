# README
A Terraform repository to create AWS IAM roles for GitHub Action runners to assume when running code in GitHub organization repositories.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.github_actions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_policy.iam_manage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.terraform_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.github_actions_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_policy_document.github_actions_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.iam_manage](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.terraform_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_repo_to_permissions"></a> [github\_repo\_to\_permissions](#input\_github\_repo\_to\_permissions) | n/a | `map(list(string))` | n/a | yes |
| <a name="input_terraform_dynamodb_table_arn"></a> [terraform\_dynamodb\_table\_arn](#input\_terraform\_dynamodb\_table\_arn) | n/a | `string` | n/a | yes |
| <a name="input_terraform_s3_bucket_arn"></a> [terraform\_s3\_bucket\_arn](#input\_terraform\_s3\_bucket\_arn) | n/a | `string` | n/a | yes |
<!-- END_TF_DOCS -->
