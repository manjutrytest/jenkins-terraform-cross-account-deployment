# Quick Start Guide

## ✅ Step 1: Jenkins Server (COMPLETED)

Jenkins server is deployed and installing software.

**Jenkins URL:** http://13.61.193.111:8080 (wait 5-10 minutes)

---

## 🔄 Step 2: Get Jenkins Password (DO THIS NOW)

Wait 5-10 minutes, then run:

```bash
ssh -i windows-os-harden-keypair.pem ec2-user@13.61.193.111
cat /home/ec2-user/jenkins-initial-password.txt
```

---

## 🔐 Step 3: Setup Customer IAM Role

**Switch to customer account (821706771879)** and run:

```bash
cd jenkins-terraform-cross-account-deployment
bash setup-customer-iam-role.sh
```

This creates the IAM role that allows Jenkins to deploy infrastructure.

---

## 🎯 Step 4: Configure Jenkins

1. Open http://13.61.193.111:8080
2. Enter initial admin password
3. Install suggested plugins
4. Create admin user
5. Add credential:
   - Manage Jenkins → Manage Credentials
   - Add Secret Text
   - ID: `terraform-external-id`
   - Secret: `dxBnHgcCoSZulEasrkN8WGDmfKqvQieh`

---

## 🚀 Step 5: Create Pipeline & Deploy

1. New Item → Pipeline → Name: `customer-infrastructure-deployment`
2. Pipeline from SCM → Git → Your repo URL
3. Script Path: `jenkins/Jenkinsfile`
4. Save
5. Build with Parameters:
   - ACTION: `plan`
   - CUSTOMER_CONFIG: `customer-821706771879`
6. Review plan
7. Build again with ACTION: `apply`

---

## 📝 Important Information

**External ID:** dxBnHgcCoSZulEasrkN8WGDmfKqvQieh (save this!)

**Source Account:** 047861165149  
**Customer Account:** 821706771879  
**Region:** eu-north-1

**Your IP:** 49.37.131.183 (Jenkins access restricted to this)

---

## 📚 Documentation

- Full setup: `docs/SETUP.md`
- Jenkins config: `docs/JENKINS-CONFIG.md`
- Deployment guide: `docs/DEPLOYMENT.md`
- IAM setup: `docs/IAM-SETUP.md`
- Access info: `JENKINS-ACCESS-INFO.md`
- Deployment info: `DEPLOYMENT-INFO.txt`
