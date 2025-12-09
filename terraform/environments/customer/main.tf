# Main Terraform configuration for customer deployment
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Provider for customer account (assumes cross-account role)
provider "aws" {
  region = var.aws_region

  assume_role {
    role_arn     = "arn:aws:iam::${var.customer_account_id}:role/TerraformCrossAccountRole-${var.customer_name}"
    session_name = "TerraformDeployment"
    external_id  = var.external_id
  }

  default_tags {
    tags = {
      ManagedBy   = "Terraform"
      Environment = var.environment
      Customer    = var.customer_name
      Project     = "CrossAccountDeployment"
    }
  }
}

# VPC Module
module "vpc" {
  source = "../../modules/vpc"

  customer_name        = var.customer_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  rdp_allowed_cidrs    = var.rdp_allowed_cidrs
}

# EC2 Module
module "ec2" {
  source = "../../modules/ec2"

  customer_name      = var.customer_name
  environment        = var.environment
  instance_type      = var.instance_type
  ebs_volume_size    = var.ebs_volume_size
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.vpc.default_security_group_id]
  allocate_eip       = var.allocate_eip
  user_data          = var.user_data
}
