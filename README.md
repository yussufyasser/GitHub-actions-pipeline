# 🚀 GitHub Actions Pipeline: MongoDB Deployment on AWS EKS

This project implements a **fully automated DevOps pipeline** using GitHub Actions to deploy a scalable MongoDB-backed application on Amazon Web Services (AWS). It integrates infrastructure provisioning, configuration management, and container orchestration using the following tools:

- **Terraform** – to define and provision AWS infrastructure (EC2 instances, VPC, subnets, security groups)
- **Ansible** – to configure MongoDB and set up the environment on EC2 instances
- **Kubernetes (EKS)** – to deploy a containerized application within a managed cluster
- **GitHub Actions** – to orchestrate the entire CI/CD workflow from code to production

---

## 🎯 Project Purpose

The main objective of this project is to simulate a **production-ready deployment environment** that reflects real-world DevOps workflows. The focus is on:

- **Infrastructure-as-Code (IaC)**: Enabling repeatable, scalable, and version-controlled infrastructure setup.
- **Configuration Automation**: Seamlessly configuring MongoDB with no manual intervention.
- **Secure Deployment**: Using private EC2 instances and a Bastion host to securely access resources.
- **Cloud-native delivery**: Deploying services into Kubernetes (AWS EKS) for portability and resilience.
- **CI/CD Best Practices**: Leveraging GitHub Actions for multi-stage, event-driven automation.

This project serves as a template or starting point for DevOps teams, cloud engineers, and developers aiming to:

- Implement infrastructure provisioning pipelines
- Automate database deployments securely
- Deploy cloud-native applications to EKS
- Learn DevOps and CI/CD integrations using modern tools

---

## 📁 Project Structure

```bash
.
├── ansible/
│   ├── install_ansible.sh
│   ├── mongodb-playbook.yml
│   └── roles/
│       └── mongodb_role/
│           ├── defaults/
│           ├── handlers/
│           ├── meta/
│           ├── tasks/
│           ├── tests/
│           └── vars/
├── kubernetes/
│   ├── deployment.yaml
│   └── service.yaml
└── terraform/
    ├── Modules/
    │   ├── EC2/
    │   └── Security-Groups/
    ├── backend.tf
    ├── main.tf
    ├── outputs.tf
    ├── provider.tf
    └── variables.tf
```

## 🧰 Components Used

- **Terraform**: Provisions EC2 instances, VPCs, and security groups
- **Ansible**: Installs and configures MongoDB on EC2
- **Kubernetes**: Deploys application and services
- **GitHub Actions**: Automates the full workflow

---

## 🏗️ Infrastructure (Terraform)

### EC2 Instances

- **MongoDB**: Private instance without public IP
- **Bastion Host**: Public instance for SSH access to MongoDB

### Modules

- `Modules/EC2`: EC2 instances definitions
- `Modules/Security-Groups`: Security groups for Bastion and MongoDB

---

## ⚙️ Configuration (Ansible)

### Role: `mongodb_role`

Performs:

- Adds MongoDB YUM repo
- Installs MongoDB
- Configures `mongod.conf` to allow remote connections
- Starts and enables `mongod` service

### Playbook: `mongodb-playbook.yml`

Executed by GitHub Actions against the MongoDB EC2 instance using dynamic inventory and SSH proxying through Bastion.

---

## ☸️ Kubernetes

- Deploys application using `deployment.yaml` and `service.yaml`
- Creates a `ConfigMap` with MongoDB's private IP for internal access

---

## 🔁 CI/CD Workflows

### `EKS_Deploy.yml`

- Triggered manually
- Deletes old EKS cluster (if exists)
- Creates new EKS cluster using `eksctl`

### `Terraform Infra & Ansible MongoDB & Kubernetes Deploy.yml`

- Triggered after `EKS_Deploy` completes
- Retrieves EKS VPC/subnet/security group data
- Applies Terraform
- Installs MongoDB with Ansible
- Deploys Kubernetes manifests

---

## 🔐 Secrets Required

Store the following in GitHub Secrets:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`
- `EC2_SSH_KEY_B64` (Base64-encoded EC2 private key)

---

## 🚀 How to Use

1. **Trigger EKS Cluster Setup**
   - Manually run the `EKS_Deploy` workflow

2. **Infrastructure + App Deployment**
   - Automatically triggered workflow will:
     - Provision EC2 + Security Groups
     - Install MongoDB with Ansible
     - Deploy app to EKS

3. **Monitor Services**
   - View logs in GitHub Actions tab
   - Use `kubectl get svc` to access your deployed app

---

## 📌 Notes

- MongoDB runs on a private EC2 instance
- Bastion host is used for secure SSH tunneling
- All infrastructure is reproducible via IaC

---
