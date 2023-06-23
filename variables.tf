variable "terraform_s3_bucket_arn" {
  type = string
}

variable "terraform_dynamodb_table_arn" {
  type = string
}

variable "github_repo_to_permissions" {
  type = map(list(string))
}
