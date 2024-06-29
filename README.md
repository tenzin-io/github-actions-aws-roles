# README
A Terraform repository to manage access to the Terraform backend for GitHub repositories that use GitHub Actions workflows.

## Usage
- Add repository to the  `github_repo_to_permissions` with the `terraform-backend` permission.
- Run the Terraform workflow.
- Update the recently added GitHub repository's workflow.
- The IAM role name will be the repository name, where `/` has been replaced with `.`.
- The IAM role will have permissions to access the Terraform backend.

### Workflow example
```yaml
- name: Configure AWS Credentials
    uses: aws-actions/configure-aws-credentials@v4
    with:
        role-to-assume: arn:aws:iam::130900203380:role/tenzin-io.test-actions-workflows
        aws-region: us-east-1
```