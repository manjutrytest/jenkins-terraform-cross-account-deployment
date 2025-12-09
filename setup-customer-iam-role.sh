#!/bin/bash
# Run this script in CUSTOMER ACCOUNT (821706771879) to create IAM role

set -e

CUSTOMER_NAME="customer-demo"
SOURCE_ACCOUNT_ID="YOUR_SOURCE_ACCOUNT_ID"
EXTERNAL_ID="YOUR_SECURE_EXTERNAL_ID"

echo "=========================================="
echo "Creating IAM Role in Customer Account"
echo "=========================================="
echo ""
echo "Customer Account: 821706771879"
echo "Source Account: ${SOURCE_ACCOUNT_ID}"
echo "Role Name: TerraformCrossAccountRole-${CUSTOMER_NAME}"
echo ""

# Verify we're in the right account
CURRENT_ACCOUNT=$(aws sts get-caller-identity --query Account --output text)
if [ "$CURRENT_ACCOUNT" != "821706771879" ]; then
    echo "ERROR: You are in account ${CURRENT_ACCOUNT}"
    echo "Please switch to customer account 821706771879"
    exit 1
fi

echo "✓ Verified: Running in customer account 821706771879"
echo ""

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

echo "Creating IAM role..."
aws iam create-role \
    --role-name "TerraformCrossAccountRole-${CUSTOMER_NAME}" \
    --assume-role-policy-document file:///tmp/trust-policy.json \
    --description "Role for cross-account Terraform deployment from source account" \
    --region eu-north-1

echo ""
echo "Attaching PowerUserAccess policy..."
aws iam attach-role-policy \
    --role-name "TerraformCrossAccountRole-${CUSTOMER_NAME}" \
    --policy-arn "arn:aws:iam::aws:policy/PowerUserAccess"

echo ""
echo "=========================================="
echo "✓ Role created successfully!"
echo "=========================================="
echo ""
echo "Role ARN: arn:aws:iam::821706771879:role/TerraformCrossAccountRole-${CUSTOMER_NAME}"
echo ""
echo "Next steps:"
echo "1. Go back to source account (047861165149)"
echo "2. Run Jenkins deployment"
echo ""

rm /tmp/trust-policy.json
