variable "terraform_s3_bucket_arn" {
  type        = string
  description = "The S3 bucket to store Terraform state files"
}

variable "terraform_dynamodb_table_arn" {
  type        = string
  description = "The DynamoDB table used for state locking"
}

variable "github_repo_to_permissions" {
  type        = map(list(string))
  description = "A list of permissions to allow for the GitHub repo.  Valid value(s): terraform_backend, iam_manage"
}
