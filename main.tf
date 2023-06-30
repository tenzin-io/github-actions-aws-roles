terraform {
  backend "s3" {
    bucket         = "tenzin-io"
    key            = "terraform/github-actions-iam-roles.state"
    dynamodb_table = "tenzin-io"
    region         = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_openid_connect_provider" "github_actions" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

resource "aws_iam_role" "github_actions_role" {
  for_each           = var.github_repo_to_permissions
  name_prefix        = "GitHubActionsRole-"
  assume_role_policy = data.aws_iam_policy_document.github_actions_role[each.key].json
  managed_policy_arns = compact([for permission in each.value : lookup({
    "terraform_backend" = aws_iam_policy.terraform_backend.arn,
    "iam_manage"        = aws_iam_policy.iam_manage.arn
  }, permission, null)])
}

resource "aws_iam_policy" "terraform_backend" {
  name_prefix = "GitHubActions-TerraformBackendManage-"
  description = "Permissions to manage Terraform remote backend"
  policy      = data.aws_iam_policy_document.terraform_backend.json
}

resource "aws_iam_policy" "iam_manage" {
  name_prefix = "GitHubActions-IAMRoleManage-"
  description = "Permissions to manage IAM roles that other GitHub repos can assume when using GitHub actions"
  policy      = data.aws_iam_policy_document.iam_manage.json
}
