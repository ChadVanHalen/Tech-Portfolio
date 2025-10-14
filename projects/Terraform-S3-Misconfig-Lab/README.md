# Terraform Security Lab: Finding and Fixing AWS Misconfigurations

## Overview
I built a hands-on lab to understand how dangerous misconfigurations slip into cloud environments through Infrastructure as Code (IaC). The goal was simple: intentionally create insecure AWS resources using Terraform, then find and fix them using real security tools.

This project mirrors exactly how many real cloud breaches start - with overly permissive configurations deployed through automation.

---

## What I Built (And Broke)
I wrote Terraform code that deployed three critical misconfigurations:

- Wildcard IAM Policy: Created an IAM user with "*:*" permissions
- Public S3 Bucket: Deployed a bucket with public read access enabled
- Open SSH Access: Configured a security group allowing SSH from 0.0.0.0/0

Then I acted as an attacker would: logged in as the over-privileged user, launched EC2 instances, and accessed the public S3 bucket.

---

## Key Findings 
### Detection Gaps Are Real
AWS GuardDuty caught the S3 misconfigurations but missed the EC2 instance launch, IAM key creation, and SSH activity. This highlighted that even native AWS security services have blind spots.

### Manual Investigation Fills the Gaps
CloudTrail logs revealed the full attack chain that GuardDuty missed. The IAM user's activities - from key creation to instance launch - were all visible in CloudTrail, just not flagged as suspicious.

### Remediation Requires Code Changes
Fixing issues in the AWS Console isn't enough. I had to update the Terraform code to prevent the same misconfigurations from reappearing on the next deployment.

---

## Tools & Techniques Used
- Terraform for infrastructure provisioning
- AWS GuardDuty for security monitoring
- AWS CloudTrail for log analysis
- Manual investigation to connect the dots

---

## Project Files

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

## Key Takeaways
1. IaC security starts before deployment - Static analysis tools could have caught these issues pre-deployment
2. Multiple detection layers are essential - No single tool catches everything
3. Remediation isn't complete until the code is fixed - Console changes are temporary fixes
