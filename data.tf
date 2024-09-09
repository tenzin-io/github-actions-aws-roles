data "aws_iam_policy_document" "github_actions_role" {
  for_each = var.github_repo_to_permissions
  statement {
    sid     = "TrustGitHubToken"
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${each.key}:*"]
    }

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github_actions.arn]
    }
  }
}

data "aws_iam_policy_document" "terraform_backend" {
  statement {
    sid       = "TerraformBackend"
    effect    = "Allow"
    resources = [local.terraform_s3_bucket_arn]
    actions   = ["s3:ListBucket"]
  }

  statement {
    sid       = "TerraformWorkspace"
    effect    = "Allow"
    resources = ["${local.terraform_s3_bucket_arn}/terraform/*"]

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]
  }

  statement {
    sid       = "TerraformStateLocking"
    effect    = "Allow"
    resources = [local.terraform_dynamodb_table_arn]

    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem",
    ]
  }
}

data "aws_iam_policy_document" "iam_manage" {
  statement {
    sid       = "ManageIAM"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "iam:CreateOpenIDConnectProvider",
      "iam:CreatePolicy",
      "iam:GetOpenIDConnectProvider",
      "iam:GetPolicy",
      "iam:GetRolePolicy",
      "iam:GetPolicyVersion",
      "iam:CreatePolicyVersion",
      "iam:DeletePolicyVersion",
      "iam:CreateRole",
      "iam:AttachRolePolicy",
      "iam:GetRole",
      "iam:ListRolePolicies",
      "iam:ListAttachedRolePolicies",
      "iam:ListInstanceProfilesForRole",
      "iam:DetachRolePolicy",
      "iam:DeleteRole",
      "iam:DeleteRolePolicy",
      "iam:ListPolicyVersions",
      "iam:DeleteOpenIDConnectProvider",
      "iam:DeletePolicy",
      "iam:UpdateOpenIDConnectProviderThumbprint",
    ]
  }
}

data "aws_iam_policy_document" "ecr_manage" {
  statement {
    sid       = "ManageECR"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ecr:*",
      "ecr-public:*",
    ]
  }
}

data "aws_iam_policy_document" "ecr_publish" {
  statement {
    sid       = "PublishECR"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ecr-public:BatchCheckLayerAvailability",
      "ecr-public:CompleteLayerUpload",
      "ecr-public:InitiateLayerUpload",
      "ecr-public:PutImage",
      "ecr-public:UploadLayerPart",
      "ecr-public:GetRepositoryPolicy",
      "ecr-public:DescribeRepositories",
      "ecr-public:GetRepositoryCatalogData",
      "ecr-public:ListTagsForResource",
      "ecr-public:GetAuthorizationToken",
      "sts:GetServiceBearerToken",
    ]
  }
}