# Jenkins Server Setup in Source Account
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket  = "terraform-state-047861165149"
    key     = "jenkins-server/terraform.tfstate"
    region  = "eu-north-1"
    encrypt = true
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      ManagedBy = "Terraform"
      Project   = "Jenkins-Setup"
    }
  }
}

# VPC for Jenkins
module "jenkins_vpc" {
  source = "../modules/vpc"

  customer_name        = "jenkins"
  environment          = "management"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  rdp_allowed_cidrs    = []
}

# S3 Bucket for Terraform State
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.state_bucket_name

  tags = {
    Name      = "Terraform State Bucket"
    ManagedBy = "Terraform"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Jenkins Server
module "jenkins" {
  source = "../modules/jenkins"

  jenkins_name        = var.jenkins_name
  instance_type       = var.jenkins_instance_type
  vpc_id              = module.jenkins_vpc.vpc_id
  subnet_id           = module.jenkins_vpc.public_subnet_ids[0]
  allowed_cidrs       = var.allowed_cidrs
  key_name            = var.key_name
  state_bucket_name   = aws_s3_bucket.terraform_state.id
}
