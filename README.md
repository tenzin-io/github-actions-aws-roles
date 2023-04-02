# README
A Terraform repository to create AWS IAM roles for GitHub Action runners to assume when running code in GitHub organization repositories.

# IAM Permissions
The minimum set of IAM permissions needed to execute this Terraform configuration.
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "dynamodb:PutItem",
                "s3:GetObject",
                "dynamodb:GetItem",
                "iam:CreateOpenIDConnectProvider",
                "iam:CreatePolicy",
                "iam:GetOpenIDConnectProvider",
                "iam:GetPolicy",
                "iam:GetPolicyVersion",
                "iam:CreateRole",
                "iam:AttachRolePolicy",
                "iam:GetRole",
                "iam:ListRolePolicies",
                "iam:ListAttachedRolePolicies",
                "s3:PutObject",
                "iam:ListInstanceProfilesForRole",
                "iam:DetachRolePolicy",
                "iam:DeleteRole",
                "iam:ListPolicyVersions",
                "iam:DeleteOpenIDConnectProvider",
                "iam:DeletePolicy"
            ],
            "Resource": "*"
        }
    ]
}
```

