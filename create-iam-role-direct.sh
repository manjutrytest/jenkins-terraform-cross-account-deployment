#!/bin/bash
# Direct IAM role creation without CloudFormation
# Run this in customer account (821706771879)

CUSTOMER_NAME="customer-demo"
SOURCE_ACCOUNT_ID="047861165149"
EXTERNAL_ID="dxBnHgcCoSZulEasrkN8WGDmfKqvQieh"
ROLE_NAME="TerraformCrossAccountRole-${CUSTOMER_NAME}"

echo "=========================================="
echo "Creating IAM Role in Customer Account"
echo "=========================================="
echo ""

# Create trust policy file
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

echo "Creating IAM role: ${ROLE_NAME}"
aws iam create-role \
    --role-name "${ROLE_NAME}" \
    --assume-role-policy-document file:///tmp/trust-policy.json \
    --description "Role for cross-account Terraform deployment from source account" \
    --tags Key=Name,Value=${ROLE_NAME} Key=ManagedBy,Value=Script Key=Purpose,Value=CrossAccountTerraform

echo ""
echo "Attaching PowerUserAccess policy..."
aws iam attach-role-policy \
    --role-name "${ROLE_NAME}" \
    --policy-arn "arn:aws:iam::aws:policy/PowerUserAccess"

echo ""
echo "=========================================="
echo "✓ IAM Role Created Successfully!"
echo "=========================================="
echo ""
echo "Role Name: ${ROLE_NAME}"
echo "Role ARN: arn:aws:iam::821706771879:role/${ROLE_NAME}"
echo ""
echo "You can now deploy infrastructure from Jenkins!"
echo ""

# Cleanup
rm /tmp/trust-policy.json
