locals {
  tfstate_s3_bucket_arn      = "arn:aws:s3:::tenzin-io"
  tfstate_dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:130900203380:table/tenzin-io"
  repos = {
    "tenzin-io/cloudflare-dns" = {
      claim = "repo:tenzin-io/cloudflare-dns:ref:refs/heads/main"
    }
    "tenzin-io/github-actions-iam-roles" = {
      claim             = "repo:tenzin-io/tenzin-io/github-actions-iam-roles:ref:refs/heads/main"
      extra_permissions = [aws_iam_policy.this_repo_permissions.arn]
    }
  }
}
