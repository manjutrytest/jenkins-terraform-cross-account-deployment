# Customer Configuration Template
# Copy this file and customize for each customer

customer_account_id = "CUSTOMER_ACCOUNT_ID"
customer_name       = "customer-name"
aws_region          = "eu-north-1"
environment         = "production"

# VPC Configuration
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
availability_zones   = ["eu-north-1a", "eu-north-1b"]

# Security - IMPORTANT: Restrict RDP access
rdp_allowed_cidrs = ["YOUR_IP_RANGE/32"]

# EC2 Configuration
instance_type    = "t3.medium"
ebs_volume_size  = 40
allocate_eip     = true

# Optional: User data script
# user_data = <<-EOF
#   <powershell>
#   # Your PowerShell script here
#   </powershell>
# EOF
