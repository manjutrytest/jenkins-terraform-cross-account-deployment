# Deployment Guide

## Quick Start

### 1. Add New Customer

Create a new tfvars file in `config/customers/`:

```bash
cp config/customers/customer-821706771879.tfvars config/customers/customer-NEW.tfvars
```

Edit with customer-specific values.

### 2. Run Jenkins Pipeline

1. Open Jenkins job
2. Click "Build with Parameters"
3. Select ACTION: `plan`
4. Enter CUSTOMER_CONFIG: `customer-821706771879`
5. Click "Build"

### 3. Review and Apply

After plan succeeds:
1. Run again with ACTION: `apply`
2. Review changes
3. Approve deployment

## Manual Deployment (Without Jenkins)

```bash
cd terraform/environments/customer

# Initialize
terraform init \
  -backend-config="bucket=terraform-state-047861165149" \
  -backend-config="key=customers/customer-821706771879/terraform.tfstate" \
  -backend-config="region=eu-north-1"

# Plan
terraform plan \
  -var-file=../../../config/customers/customer-821706771879.tfvars \
  -var="external_id=YOUR_EXTERNAL_ID"

# Apply
terraform apply \
  -var-file=../../../config/customers/customer-821706771879.tfvars \
  -var="external_id=YOUR_EXTERNAL_ID"
```

## Outputs

After deployment, get outputs:

```bash
terraform output -json
```

Key outputs:
- `instance_id`: EC2 instance ID
- `instance_public_ip`: Public IP
- `elastic_ip`: Elastic IP (if allocated)
- `vpc_id`: VPC ID
