#!/bin/bash
# Script to create IAM role in customer account
# Run this in the customer account (821706771879)

set -e

CUSTOMER_NAME="customer-demo"
SOURCE_ACCOUNT_ID="047861165149"
EXTERNAL_ID="${1:-}"

if [ -z "$EXTERNAL_ID" ]; then
    echo "Usage: $0 <external-id>"
    exit 1
fi

echo "Creating IAM role in customer account..."

# Create trust policy
cat > /tmp/trust-policy.json <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${SOURCE_ACCOUNT_ID}:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "${EXTERNAL_ID}"
        }
      }
    }
  ]
}
EOF

# Create role
aws iam create-role \
    --role-name "TerraformCrossAccountRole-${CUSTOMER_NAME}" \
    --assume-role-policy-document file:///tmp/trust-policy.json \
    --description "Role for cross-account Terraform deployment"

# Attach policies
aws iam attach-role-policy \
    --role-name "TerraformCrossAccountRole-${CUSTOMER_NAME}" \
    --policy-arn "arn:aws:iam::aws:policy/PowerUserAccess"

echo "Role created successfully!"
echo "Role ARN: arn:aws:iam::$(aws sts get-caller-identity --query Account --output text):role/TerraformCrossAccountRole-${CUSTOMER_NAME}"

rm /tmp/trust-policy.json
