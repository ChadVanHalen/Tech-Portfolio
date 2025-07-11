# 🛡️ Terraform Security Templates + S3 Misconfiguration Lab

## Overview
A hands-on lab focused on terraforming secure AWS infrastructure with an emphasis on detecting and remediating common misconfigurations, especially around S3 buckets (e.g., public exposure, lack of encryption, improper ACLs).

## Use Case
- Simulate insecure Terraform templates that provision S3 buckets with risky configurations (public read/write, missing encryption).
- Detect these misconfigurations using tools like AWS Config Rules, Terraform Sentinel (or open source alternatives), and Terraform plan/diff scanning tools.
- Investigate and remediate by updating Terraform code and applying secure templates.
- Teach secure IaC (Infrastructure as Code) practices to avoid cloud security missteps.

## Core Learning Objectives
- Learn Terraform basics with AWS resources.
- Identify S3 bucket misconfigurations via Terraform code and AWS scanning tools.
- Practice remediating insecure configurations in IaC before deployment.
- Understand continuous compliance via Terraform policy-as-code.

## Suggested Tools & Services
- Terraform CLI + AWS Provider
- AWS S3
- AWS Config Rules (managed rules for S3 bucket encryption, public access blocks)
- Terraform Sentinel (if licensed) or Open Policy Agent (OPA) + Conftest as open alternatives
- Terraform Cloud/Enterprise (optional, for policy enforcement)
- Static code analysis tools like tfsec, checkov, or terrascan

## Possible Structure / Steps

| Step | Description                                                                                   |
| ---- | --------------------------------------------------------------------------------------------- |
| 1    | Create intentionally insecure Terraform S3 bucket templates                                   |
| 2    | Deploy Terraform and observe resulting S3 misconfigurations                                   |
| 3    | Use AWS Config + CLI tools + tfsec to detect issues                                           |
| 4    | Investigate findings and create reports                                                       |
| 5    | Remediate Terraform templates to enforce best practices (encryption, private access, no ACLs) |
| 6    | Implement policy-as-code checks with OPA/Conftest or Sentinel                                 |
| 7    | Re-deploy and verify compliance                                                               |
| 8    | Write lessons learned and security best practices for IaC                                     |

# 🛡️ Terraform Security Templates + S3 Misconfiguration Lab

## 📘 Overview

This lab simulates common security misconfigurations in AWS S3 buckets using Terraform, and demonstrates how to detect, investigate, and remediate these issues using infrastructure-as-code best practices and native AWS tooling.

The goal is to build secure-by-default infrastructure while gaining hands-on experience with:

- Terraform provisioning
- S3 security risks
- Static code analysis
- Policy-as-code (OPA/Sentinel)
- AWS Config compliance

---

## 🔍 Use Case

Simulate the following insecure configurations via Terraform:

- Public S3 bucket access (ACLs or bucket policies)
- Lack of default encryption
- Versioning disabled
- Logging not enabled

Then, identify and fix them through detection tools and Terraform remediation.

---

## 💻 Tools & Services Used

| Tool | Purpose |
|------|---------|
| **Terraform** | Provision AWS resources (insecure vs. secure) |
| **AWS S3** | Target service for security misconfigurations |
| **AWS Config** | Detect non-compliant bucket configurations |
| **AWS CLI** | Inspect and verify configurations |

---

## 🧭 Steps

| Step | Description |
|------|-------------|
| 1. Insecure Infrastructure | Use Terraform to create misconfigured S3 buckets |
| 2. Detect Misconfigurations | Use AWS Config and tfsec to identify violations |
| 3. Investigate | Review audit logs and code to trace risks |
| 4. Remediate | Update Terraform code to align with best practices |
| 5. Prevent Future Issues | Implement policy-as-code validation |
| 6. Lessons Learned | Summarize outcomes and security takeaways |

---

## 📂 Project Files

| File | Description |
|------|-------------|
| [`Incident Simulation – Unauthorized EC2 Launch for Crypto Mining`](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/1-Insecure_Terraform_Buckets.md) | Walkthrough of creating insecure S3 buckets via Terraform |
| [`Chapter 2: Investigation Report`](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/3-Remediation.md) | Detection using AWS Config and static analysis tools |
| [`Chapter 3: Containment & Remediation`](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/3-Remediation.md) | Secure Terraform templates and best practices |
| [`Chapter 4: Lessons Learned`](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/4-Lessons_Learned.md) | Summary and recommendations for secure IaC |
| [`terraform/insecure/`](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/terraform/insecure/main.tf) | Sample Terraform code with insecure S3 setup |
| [`terraform/secure/`](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/terraform/secure/main.tf) | Secure-by-default version of the same infrastructure |
| [`artifacts/`](https://github.com/ChadVanHalen/Tech-Portfolio/tree/main/projects/Terraform-S3-Misconfig-Lab/artifacts) | Evidence, screenshots, and analysis results |

---

## 📸 Evidence

All key misconfigurations and remediations are captured via screenshots, AWS Config findings, and tfsec output in the [`artifacts/`](https://github.com/ChadVanHalen/Tech-Portfolio/tree/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots) folder.

---

## 📈 Outcome

✅ Understand Terraform IaC risks  
✅ Learn how to detect misconfigurations before deployment  
✅ Practice secure-by-default provisioning  
✅ Implement policy-as-code and continuous compliance
