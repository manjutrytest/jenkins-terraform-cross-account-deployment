# Jenkins Server Setup Guide

## Step 1: Prerequisites

Before deploying Jenkins, you need:

1. **AWS CLI configured** with credentials for source account (047861165149)
2. **EC2 Key Pair** in eu-north-1 region
3. **Your public IP** for security group access

## Step 2: Create EC2 Key Pair (if you don't have one)

```bash
aws ec2 create-key-pair \
  --key-name jenkins-key \
  --region eu-north-1 \
  --query 'KeyMaterial' \
  --output text > jenkins-key.pem

chmod 400 jenkins-key.pem
```

## Step 3: Deploy Jenkins Server

```bash
cd terraform/jenkins-setup

# Edit terraform.tfvars with your key name
# key_name = "jenkins-key"
# allowed_cidrs = ["YOUR_IP/32"]

# Initialize (first time only - will create S3 bucket)
terraform init -backend=false

# Create S3 bucket first
terraform apply -target=aws_s3_bucket.terraform_state -auto-approve

# Now initialize with backend
terraform init -force-copy

# Deploy Jenkins
terraform apply
```

## Step 4: Access Jenkins

After deployment completes (5-10 minutes):

1. Get Jenkins URL from output
2. SSH to instance to get initial password:

```bash
ssh -i jenkins-key.pem ec2-user@<JENKINS_PUBLIC_IP>
cat /home/ec2-user/jenkins-initial-password.txt
```

3. Open Jenkins URL in browser: `http://<JENKINS_PUBLIC_IP>:8080`
4. Enter initial admin password
5. Install suggested plugins

## Step 5: Configure Jenkins

See JENKINS-CONFIG.md for detailed configuration steps.
