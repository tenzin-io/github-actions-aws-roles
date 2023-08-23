terraform_s3_bucket_arn      = "arn:aws:s3:::tenzin-io"
terraform_dynamodb_table_arn = "arn:aws:dynamodb:us-east-1:130900203380:table/tenzin-io"

github_repo_to_permissions = {
  "tenzin-io/homelab-artifactory"      = ["terraform_backend"]
  "tenzin-io/homelab-k8s-nvidia"       = ["terraform_backend"]
  "tenzin-io/homelab-vault-config"     = ["terraform_backend"]
  "tenzin-io/homelab-k8s-oracle"       = ["terraform_backend"]
  "tenzin-io/homelab-k8s-v1"           = ["terraform_backend"]
  "tenzin-io/homelab-k8s-dev"          = ["terraform_backend"]
  "tenzin-io/cloudflare-dns"           = ["terraform_backend"]
  "tenzin-io/github-actions-aws-roles" = ["terraform_backend", "iam_manage"]
}
