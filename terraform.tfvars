github_repo_to_permissions = {
  "tenzin-io/vault-config"             = ["terraform-backend"]
  "tenzin-io/dev-k8s"                  = ["terraform-backend"]
  "tenzin-io/cloudflare-dns"           = ["terraform-backend"]
  "tenzin-io/test-actions-workflows"   = ["terraform-backend"]
  "tenzin-io/github-actions-aws-roles" = ["terraform-backend", "iam-manage"]
}