github_repo_to_permissions = {
  "tenzin-io/vault-config"             = ["terraform-backend"]
  "tenzin-io/platform-setup"           = ["terraform-backend"]
  "tenzin-io/cloudflare-dns"           = ["terraform-backend"]
  "tenzin-io/test-actions-workflows"   = ["terraform-backend"]
  "tenzin-io/github-actions-aws-roles" = ["terraform-backend", "iam-manage"]
  "tenzin-io/container-images"         = ["ecr-publish"]
  "tenzin-io/public-ecr"               = ["terraform-backend", "ecr-manage"]
}