# IAM Cross-Account Setup

## Customer Account Role (821706771879)

Create this role in the customer account to allow source account access:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::047861165149:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "YOUR_SECURE_EXTERNAL_ID"
        }
      }
    }
  ]
}
```

Role Name: `TerraformCrossAccountRole-customer-demo`

## Source Account Jenkins Role (047861165149)

Jenkins EC2 instance should have this policy attached:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "arn:aws:iam::821706771879:role/TerraformCrossAccountRole-*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::terraform-state-047861165149",
        "arn:aws:s3:::terraform-state-047861165149/*"
      ]
    }
  ]
}
```
