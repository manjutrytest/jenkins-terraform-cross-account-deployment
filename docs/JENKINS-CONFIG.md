# Jenkins Configuration Guide

## Initial Setup

1. **Install Plugins**
   - Go to: Manage Jenkins → Manage Plugins
   - Install:
     - Pipeline
     - Git
     - AWS Credentials Plugin
     - Credentials Binding Plugin

2. **Add AWS Credentials**
   - Go to: Manage Jenkins → Manage Credentials
   - Add "Secret text" credential:
     - ID: `terraform-external-id`
     - Secret: Generate a secure random string (save this!)

3. **Configure GitHub**
   - Go to: Manage Jenkins → Configure System
   - Add GitHub server (if using private repo)
   - Add GitHub credentials

## Create Pipeline Job

1. **New Item** → Pipeline
2. **Name**: `customer-infrastructure-deployment`
3. **Pipeline**:
   - Definition: Pipeline script from SCM
   - SCM: Git
   - Repository URL: Your GitHub repo URL
   - Script Path: `jenkins/Jenkinsfile`

4. **Save**

## Test Deployment

1. Click "Build with Parameters"
2. Select:
   - ACTION: `plan`
   - CUSTOMER_CONFIG: `customer-821706771879`
   - AUTO_APPROVE: false
3. Click "Build"

## Security Best Practices

1. **Restrict Jenkins Access**
   - Update security group to allow only your IP
   - Enable Jenkins security realm
   - Create user accounts

2. **Secure External ID**
   - Use a strong random string (32+ characters)
   - Store securely in Jenkins credentials
   - Share with customer for role setup

3. **Enable HTTPS**
   - Configure SSL certificate
   - Use Application Load Balancer
   - Redirect HTTP to HTTPS

## Troubleshooting

**Can't access Jenkins:**
- Check security group allows your IP on port 8080
- Verify instance is running
- Check Jenkins service: `sudo systemctl status jenkins`

**Terraform fails:**
- Verify IAM role has correct permissions
- Check external ID matches in both accounts
- Verify S3 bucket exists and is accessible
