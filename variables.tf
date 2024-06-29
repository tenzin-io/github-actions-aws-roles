variable "github_repo_to_permissions" {
  type        = map(list(string))
  description = "A list of permissions to allow for the GitHub repo.  Valid value(s): terraform_backend, iam_manage"
}
