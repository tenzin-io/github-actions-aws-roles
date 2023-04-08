data "aws_iam_policy_document" "github_actions_role" {
  for_each = local.repos
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = [each.value.claim]
    }

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github_actions.arn]
    }
  }
}

data "aws_iam_policy_document" "terraform_backend_manage" {
  statement {
    sid       = ""
    effect    = "Allow"
    resources = [local.tfstate_s3_bucket_arn]
    actions   = ["s3:ListBucket"]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["${local.tfstate_s3_bucket_arn}/terraform/*"]

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = [local.tfstate_dynamodb_table_arn]

    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem",
    ]
  }
}

data "aws_iam_policy_document" "iam_role_manage" {
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "iam:CreateOpenIDConnectProvider",
      "iam:CreatePolicy",
      "iam:GetOpenIDConnectProvider",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:CreateRole",
      "iam:AttachRolePolicy",
      "iam:GetRole",
      "iam:ListRolePolicies",
      "iam:ListAttachedRolePolicies",
      "iam:ListInstanceProfilesForRole",
      "iam:DetachRolePolicy",
      "iam:DeleteRole",
      "iam:ListPolicyVersions",
      "iam:DeleteOpenIDConnectProvider",
      "iam:DeletePolicy",
    ]
  }
}

data "aws_iam_policy_document" "parameter_store_manage" {
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ssm:GetParameter",
      "ssm:DescribeParameters",
      "ssm:ListTagsForResource",
      "ssm:DeleteParameter",
      "ssm:PutParameter",
    ]
  }
}
