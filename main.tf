terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = "~> 1.0"
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

locals {
  terraform_s3_bucket_arn      = "arn:aws:s3:::tenzin-io"
  terraform_dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:130900203380:table/tenzin-io"
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
    "ecr-manage"        = aws_iam_policy.ecr_manage.arn,
    "ecr-publish"       = aws_iam_policy.ecr_publish.arn,
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

resource "aws_iam_policy" "ecr_manage" {
  name_prefix = "GitHubActions-ECRManage-"
  description = "Permissions to manage ECR repositories"
  policy      = data.aws_iam_policy_document.ecr_manage.json
}

resource "aws_iam_policy" "ecr_publish" {
  name_prefix = "GitHubActions-ECRPublish-"
  description = "Permissions to publish image to ECR repositories"
  policy      = data.aws_iam_policy_document.ecr_publish.json
}