# Setup Guide

## Prerequisites

1. **Source Account (047861165149)**: Jenkins server with AWS CLI and Terraform installed
2. **Customer Account (821706771879)**: IAM role for cross-account access
3. **GitHub**: Repository access configured in Jenkins
4. **S3 Bucket**: For Terraform state storage in source account

## Step 1: Create S3 Bucket for Terraform State (Source Account)

```bash
aws s3 mb s3://terraform-state-047861165149 --region eu-north-1
aws s3api put-bucket-versioning --bucket terraform-state-047861165149 --versioning-configuration Status=Enabled
aws s3api put-bucket-encryption --bucket terraform-state-047861165149 --server-side-encryption-configuration '{
  "Rules": [{"ApplyServerSideEncryptionByDefault": {"SSEAlgorithm": "AES256"}}]
}'
```

## Step 2: Create IAM Role in Customer Account (821706771879)

Run this in customer account:

```bash
cd terraform/modules/iam-roles
terraform init
terraform apply \
  -var="source_account_id=047861165149" \
  -var="customer_name=customer-demo" \
  -var="external_id=YOUR_SECURE_EXTERNAL_ID"
```

## Step 3: Configure Jenkins

1. Install plugins: Git, Pipeline, AWS Credentials
2. Add AWS credentials (source account)
3. Add secret text credential: `terraform-external-id`
4. Create pipeline job pointing to Jenkinsfile

## Step 4: Deploy Infrastructure

1. Push code to GitHub
2. Run Jenkins pipeline with ACTION=plan
3. Review plan and run with ACTION=apply

See README.md for usage details.
