variable "source_account_id" {
  description = "Source AWS account ID (Management account)"
  type        = string
  default     = "047861165149"
}

variable "customer_name" {
  description = "Customer name for resource naming"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "external_id" {
  description = "External ID for additional security"
  type        = string
  sensitive   = true
}
