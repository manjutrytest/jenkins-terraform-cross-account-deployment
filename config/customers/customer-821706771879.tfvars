# Customer Configuration
# Account ID: 821706771879
# Region: eu-north-1

customer_account_id = "821706771879"
customer_name       = "customer-demo"
aws_region          = "eu-north-1"
environment         = "production"

# VPC Configuration
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
availability_zones   = ["eu-north-1a", "eu-north-1b"]

# Security - Restrict RDP access to your IP range
rdp_allowed_cidrs = ["49.37.131.183/32"]

# EC2 Configuration
instance_type    = "t3.medium"
ebs_volume_size  = 40
allocate_eip     = true
