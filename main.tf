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

resource "aws_iam_role" "actions_assume" {
  for_each            = local.repos
  name_prefix         = "GitHubActionsRole-"
  assume_role_policy  = data.aws_iam_policy_document.actions_assume[each.key].json
  managed_policy_arns = flatten([aws_iam_policy.tfstate_permissions.arn, try(each.value.extra_permissions, [])])
}

resource "aws_iam_policy" "tfstate_permissions" {
  policy = data.aws_iam_policy_document.tfstate_permissions.json
}

resource "aws_iam_policy" "this_repo_permissions" {
  policy = data.aws_iam_policy_document.this_repo_permissions.json
}
