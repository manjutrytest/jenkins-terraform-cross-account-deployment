output "cross_account_role_arn" {
  description = "ARN of the cross-account role"
  value       = aws_iam_role.cross_account_role.arn
}

output "cross_account_role_name" {
  description = "Name of the cross-account role"
  value       = aws_iam_role.cross_account_role.name
}
