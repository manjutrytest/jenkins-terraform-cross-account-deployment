# Troubleshooting Guide

## Issue: Jenkins Failed to Start on First Boot

This is a common issue. Here's how to fix it:

### Option 1: SSH and Fix (RECOMMENDED)

```bash
# SSH to the instance
ssh -i windows-os-harden-keypair.pem ec2-user@13.61.193.111

# Run these commands on the instance:
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl restart jenkins

# Wait 30 seconds, then check status
sleep 30
sudo systemctl status jenkins

# Get the initial password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

### Option 2: Use the Fix Script

```bash
# Copy the fix script to the instance
scp -i windows-os-harden-keypair.pem fix-jenkins.sh ec2-user@13.61.193.111:~

# SSH and run it
ssh -i windows-os-harden-keypair.pem ec2-user@13.61.193.111
bash fix-jenkins.sh
```

### Option 3: Recreate with User Data Fix

If the above doesn't work, I can update the user data script and recreate the instance.

---

## Verify Jenkins is Running

```bash
# Check if Jenkins is listening on port 8080
curl http://13.61.193.111:8080

# Or from the instance:
ssh -i windows-os-harden-keypair.pem ec2-user@13.61.193.111
curl http://localhost:8080
```

---

## Get Initial Password

Once Jenkins is running:

```bash
ssh -i windows-os-harden-keypair.pem ec2-user@13.61.193.111
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

---

## Check Jenkins Logs

```bash
ssh -i windows-os-harden-keypair.pem ec2-user@13.61.193.111
sudo journalctl -u jenkins -f
```

---

## Alternative: Deploy Customer Infrastructure Without Jenkins

If you want to proceed without Jenkins, you can deploy directly with Terraform:

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
  -var="external_id=dxBnHgcCoSZulEasrkN8WGDmfKqvQieh"

# Apply
terraform apply \
  -var-file=../../../config/customers/customer-821706771879.tfvars \
  -var="external_id=dxBnHgcCoSZulEasrkN8WGDmfKqvQieh"
```

**Note:** You must first create the IAM role in customer account (821706771879) using `setup-customer-iam-role.sh`

---

## What to Do Next

1. **Try Option 1 above** - SSH and restart Jenkins
2. **Wait 2-3 minutes** for Jenkins to fully start
3. **Access Jenkins** at http://13.61.193.111:8080
4. **Get password** and complete setup

Let me know if you need help with any of these steps!
