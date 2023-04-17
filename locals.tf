locals {
  tfstate_s3_bucket_arn      = "arn:aws:s3:::tenzin-io"
  tfstate_dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:130900203380:table/tenzin-io"
  repos = {
    "tenzin-io/homelab-vault-config" = {
      claim       = "repo:tenzin-io/homelab-vault-config:ref:refs/heads/main"
      permissions = [aws_iam_policy.terraform_backend_manage.arn]
    }
    "tenzin-io/homelab-k8s-oracle" = {
      claim       = "repo:tenzin-io/homelab-k8s-oracle:ref:refs/heads/main"
      permissions = [aws_iam_policy.terraform_backend_manage.arn, aws_iam_policy.parameter_store_read.arn]
    }
    "tenzin-io/homelab-k8s-vault" = {
      claim       = "repo:tenzin-io/homelab-k8s-vault:ref:refs/heads/main"
      permissions = [aws_iam_policy.terraform_backend_manage.arn, aws_iam_policy.parameter_store_read.arn]
    }
    "tenzin-io/homelab-k8s-v1" = {
      claim       = "repo:tenzin-io/homelab-k8s-v1:ref:refs/heads/main"
      permissions = [aws_iam_policy.terraform_backend_manage.arn, aws_iam_policy.parameter_store_read.arn]
    }
    "tenzin-io/secrets-management" = {
      claim       = "repo:tenzin-io/secrets-management:ref:refs/heads/main"
      permissions = [aws_iam_policy.terraform_backend_manage.arn, aws_iam_policy.parameter_store_manage.arn]
    }
    "tenzin-io/cloudflare-dns" = {
      claim       = "repo:tenzin-io/cloudflare-dns:ref:refs/heads/main"
      permissions = [aws_iam_policy.terraform_backend_manage.arn]
    }
    "tenzin-io/github-actions-aws-roles" = {
      claim       = "repo:tenzin-io/github-actions-aws-roles:ref:refs/heads/main"
      permissions = [aws_iam_policy.terraform_backend_manage.arn, aws_iam_policy.iam_role_manage.arn]
    }
  }
}
