# Backend configuration for Terraform state
# Actual values will be provided via -backend-config during terraform init

terraform {
  backend "s3" {
    # bucket  = "terraform-state-047861165149"
    # key     = "customers/<customer-name>/terraform.tfstate"
    # region  = "eu-north-1"
    # encrypt = true
  }
}
