terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = "~> 1.9"
  backend "s3" {
    bucket       = "tenzin-cloud"
    key          = "terraform/github-actions-iam-roles.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"
}

locals {
  terraform_s3_bucket_arn = "arn:aws:s3:::tenzin-cloud"
}

#
# See this post for the official thumbprint list for github actions
# https://github.blog/changelog/2023-06-27-github-actions-update-on-oidc-integration-with-aws/
#
resource "aws_iam_openid_connect_provider" "github_actions" {
  url            = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1",
    "1c58a3a8518e8759bf075b76b750d4f2df264fcd"
  ]
}

resource "aws_iam_role" "github_actions_role" {
  for_each           = var.github_repo_to_permissions
  name               = format("%s", replace(each.key, "/", "."))
  assume_role_policy = data.aws_iam_policy_document.github_actions_role[each.key].json
  managed_policy_arns = compact([for permission in each.value : lookup({
    "terraform-backend" = aws_iam_policy.terraform_backend.arn,
    "iam-manage"        = aws_iam_policy.iam_manage.arn,
  }, permission, null)])
}

resource "aws_iam_policy" "terraform_backend" {
  name_prefix = "GitHubActions-TerraformBackendManage-"
  description = "Permissions to manage Terraform backend"
  policy      = data.aws_iam_policy_document.terraform_backend.json
}

resource "aws_iam_policy" "iam_manage" {
  name_prefix = "GitHubActions-IAMRoleManage-"
  description = "Permissions to manage IAM roles that other GitHub repos can assume when using GitHub actions"
  policy      = data.aws_iam_policy_document.iam_manage.json
}
