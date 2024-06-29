# Terraform backend state repository
github_repo_to_permissions = {
  "tenzin-io/homelab-vault-config"     = ["terraform-backend"]
  "tenzin-io/dev-k8s"                  = ["terraform-backend"]
  "tenzin-io/cloudflare-dns"           = ["terraform-backend"]
  "tenzin-io/github-actions-aws-roles" = ["terraform-backend", "iam-manage"]
  "tenzin-io/aws-tenzin-terraform"     = ["terraform-backend", "ecr-manage"]
  "tenzin-io/test-actions-workflows"   = ["terraform-backend"]
}