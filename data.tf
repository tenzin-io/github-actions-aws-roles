data "aws_iam_policy_document" "actions_assume" {
  for_each = local.repos
  statement {
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

data "aws_iam_policy_document" "tfstate_permission" {
  statement {
    effect    = "Allow"
    resources = [local.tfstate_s3_bucket_arn]
    actions   = ["s3:ListBucket"]
  }

  statement {
    effect    = "Allow"
    resources = ["${local.tfstate_s3_bucket_arn}/terraform/*"]

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]
  }

  statement {
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
