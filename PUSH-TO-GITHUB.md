# Push to GitHub Instructions

## Option 1: Create New Repository on GitHub

1. Go to https://github.com/new
2. Repository name: `jenkins-terraform-cross-account-deployment`
3. Description: `Cross-account infrastructure deployment with Jenkins and Terraform`
4. Choose: **Private** (recommended for infrastructure code)
5. **Do NOT** initialize with README, .gitignore, or license
6. Click **Create repository**

## Option 2: Push to Existing Repository

If you already have a repository, use its URL in the commands below.

## Push Commands

```bash
# Add your GitHub repository as remote
git remote add origin https://github.com/YOUR_USERNAME/jenkins-terraform-cross-account-deployment.git

# Or if using SSH:
# git remote add origin git@github.com:YOUR_USERNAME/jenkins-terraform-cross-account-deployment.git

# Push to GitHub
git branch -M main
git push -u origin main
```

## Verify

After pushing, verify on GitHub:
- All files are present
- .gitignore is working (no .terraform/ or terraform.tfstate files)
- README.md displays correctly

## Next Steps

1. Configure Jenkins to use this repository
2. Add GitHub credentials to Jenkins if private repo
3. Create Jenkins pipeline job pointing to `jenkins/Jenkinsfile`

## Important Notes

- Sensitive files are excluded via .gitignore
- terraform.tfvars files are not committed (use template.tfvars as reference)
- Update placeholder values before deploying
