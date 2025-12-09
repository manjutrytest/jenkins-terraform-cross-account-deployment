# IAM Roles for Cross-Account Access
# This module creates the necessary IAM roles for cross-account deployment

# Role in customer account that allows source account to assume it
resource "aws_iam_role" "cross_account_role" {
  name = "TerraformCrossAccountRole-${var.customer_name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.source_account_id}:root"
        }
        Action = "sts:AssumeRole"
        Condition = {
          StringEquals = {
            "sts:ExternalId" = var.external_id
          }
        }
      }
    ]
  })

  tags = {
    Name        = "TerraformCrossAccountRole-${var.customer_name}"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Customer    = var.customer_name
  }
}

# Policy for the cross-account role
resource "aws_iam_role_policy" "cross_account_policy" {
  name = "TerraformCrossAccountPolicy"
  role = aws_iam_role.cross_account_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:*",
          "vpc:*",
          "elasticloadbalancing:*",
          "autoscaling:*",
          "cloudwatch:*",
          "s3:*",
          "rds:*",
          "iam:GetRole",
          "iam:GetRolePolicy",
          "iam:ListRolePolicies",
          "iam:ListAttachedRolePolicies"
        ]
        Resource = "*"
      }
    ]
  })
}
