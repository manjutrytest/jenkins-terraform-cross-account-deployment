# Jenkins Terraform Cross-Account Deployment

Production-ready solution for deploying customer infrastructure from a management account to multiple customer AWS accounts using Jenkins, Terraform, and GitHub.

## 🎯 Features

- **Cross-Account Deployment**: Securely deploy to customer AWS accounts from a central management account
- **Reusable Modules**: VPC, EC2, IAM, and Jenkins modules for consistent infrastructure
- **CI/CD Pipeline**: Automated deployment via Jenkins with approval gates
- **Secure**: IAM role assumption with external ID, encrypted S3 state, least privilege policies
- **Scalable**: Easy to add new customers by copying configuration files

## 🏗️ Architecture

```
Management Account (Source)          Customer Account (Target)
┌─────────────────────┐             ┌──────────────────────┐
│  Jenkins Server     │             │  Customer Resources  │
│  ├─ Terraform       │────────────>│  ├─ VPC              │
│  ├─ AWS CLI         │  Assumes    │  ├─ EC2 Instances    │
│  └─ GitHub          │  IAM Role   │  └─ Security Groups  │
│                     │             │                      │
│  S3 State Bucket    │             │  IAM Cross-Account   │
│  (Encrypted)        │             │  Role                │
└─────────────────────┘             └──────────────────────┘
```

## 📋 Prerequisites

- AWS accounts (source and customer)
- GitHub repository
- EC2 key pair for SSH access
- Basic knowledge of Terraform and Jenkins

## 🚀 Quick Start

See [QUICK-START.md](QUICK-START.md) for step-by-step setup instructions.

## 📁 Project Structure

```
├── terraform/
│   ├── modules/              # Reusable Terraform modules
│   │   ├── vpc/             # VPC with public/private subnets
│   │   ├── ec2/             # EC2 instances
│   │   ├── iam-roles/       # Cross-account IAM roles
│   │   └── jenkins/         # Jenkins server setup
│   ├── jenkins-setup/       # Deploy Jenkins in source account
│   └── environments/
│       └── customer/        # Customer infrastructure deployment
├── jenkins/
│   └── Jenkinsfile          # CI/CD pipeline definition
├── config/
│   └── customers/           # Customer-specific configurations
├── docs/                    # Detailed documentation
└── scripts/                 # Helper scripts

```

## 🔧 Configuration

### Add New Customer

1. Copy `config/customers/template.tfvars` to `config/customers/customer-NAME.tfvars`
2. Update with customer-specific values
3. Commit and push to GitHub
4. Run Jenkins pipeline with the new config

### Customize Infrastructure

Edit Terraform modules in `terraform/modules/` to add or modify resources.

## 📚 Documentation

- [Quick Start Guide](QUICK-START.md) - Get started in minutes
- [Setup Guide](docs/SETUP.md) - Detailed setup instructions
- [Jenkins Configuration](docs/JENKINS-CONFIG.md) - Configure Jenkins
- [Deployment Guide](docs/DEPLOYMENT.md) - Deploy infrastructure
- [IAM Setup](docs/IAM-SETUP.md) - Cross-account IAM configuration
- [Troubleshooting](TROUBLESHOOTING.md) - Common issues and solutions

## 🔒 Security Best Practices

- ✅ IAM role assumption with external ID
- ✅ Encrypted S3 backend for Terraform state
- ✅ Least privilege IAM policies
- ✅ Security groups restricted to specific IPs
- ✅ No hardcoded credentials in code
- ✅ Secrets managed via Jenkins credentials

## 🛠️ Technology Stack

- **Infrastructure as Code**: Terraform
- **CI/CD**: Jenkins
- **Version Control**: GitHub
- **Cloud Provider**: AWS
- **Compute**: EC2 (Amazon Linux 2, Windows Server)
- **Networking**: VPC, Subnets, Security Groups

## 📝 License

This project is provided as-is for internal use.

## 🤝 Contributing

1. Create a feature branch
2. Make your changes
3. Test thoroughly
4. Submit a pull request

## 📞 Support

For issues or questions, refer to the documentation in the `docs/` folder or check [TROUBLESHOOTING.md](TROUBLESHOOTING.md).
