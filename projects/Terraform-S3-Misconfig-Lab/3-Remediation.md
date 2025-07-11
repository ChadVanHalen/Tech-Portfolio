# 🛠️ Chapter 3: Containment & Remediation

## 🔎 Overview
Following the investigation of attacker activity and exposed infrastructure, this phase focused on immediate containment and longer-term remediation steps.
Actions taken were aligned with best practices in AWS incident response and infrastructure-as-code hygiene.

Key goals:
- Remove attacker persistence (IAM credentials, compute instances)
- Lock down exposed resources (S3, SSH)
- Reflect all changes in Terraform (`main.tf`) to ensure state integrity and avoid reintroducing vulnerabilities

---

## 🚫 EC2 Instance Termination

**Action**:  
Terminated the EC2 instance launched by the malicious IAM user.

**Why It Matters**:  
Unapproved instances may be used for malicious activity like crypto mining or lateral movement. Removing them eliminates ongoing cost and risk.

📁 **Artifact**:  
- ![Screenshot 3-1: EC2 instance terminated](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots/3%201%20Stopped%20EC2%20instance%20launced%20by%20malicious%20user.png)

---

## 🔐 IAM User Cleanup

**Actions Taken**:
1. Deleted access keys for `terraform-crypto-actor`
2. Removed the dangerous `*:*` inline policy
3. Deleted the IAM user entirely

**Why It Matters**:  
Wildcard IAM permissions are a major risk. Removing the malicious user and keys eliminates their access vector.

📁 **Artifacts**:
- ![Screenshot 3-2: Access Keys Deleted](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots/3%202%20Deleted%20Access%20Keys%20from%20IAM%20user.png)
- ![Screenshot 3-3: Overprivileged Permissions Removed](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots/3%203%20Remove%20over%20provisioned%20permissions.png)
- ![Screenshot 3-4: IAM User Deleted](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots/3%204%20Deleted%20malicious%20user.png)

---

## ☁️ S3 Bucket Lockdown

**Actions Taken**:
1. Removed the bucket policy granting `s3:GetObject` to `Principal: "*"`
2. Enabled **Block Public Access** settings

**Why It Matters**:  
Public S3 buckets are a top source of accidental data leaks. Blocking all public access ensures data stays internal.

📁 **Artifacts**:
- ![Screenshot 3-5: Public Read Removed](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots/3%205%20Remove%20S3%20bucket%20permission%20to%20public%20read%20get%20object.png)
- ![Screenshot 3-6: Block Public Access Enabled](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots/3%206%20Block%20public%20access%20in%20the%20S3%20bucket.png)

---

## 🔐 Security Group Hardening

**Action**:  
Deleted the security group that allowed SSH access from `0.0.0.0/0`.

**Why It Matters**:  
Open SSH ports are one of the most scanned and exploited surfaces. Limiting access by CIDR prevents brute force attacks.

📁 **Artifact**:
- ![Screenshot 3-7: Open SSH SG Deleted](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots/3%207%20Delete%20open%20SSH%20security%20group.png)

---

## 🧱 Terraform Remediation

After making changes in the AWS Console, Terraform was updated to reflect the secure desired state. These changes ensure future deployments remain secure and prevent drift.

### ✂️ Malicious IAM User Removed
**Action**:  
Commented out the IAM user and its policy from `main.tf`

📁 **Artifact**:  
- ![Screenshot 3-8: IAM User Commented Out](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots/3%208%20Comment%20out%20malicious%20user%20in%20Terraform.png)

---

### 🔐 S3 Bucket Secured in Code

**Action**:  
- Removed public bucket policy block
- Added `aws_s3_bucket_public_access_block` to enforce safe config

📁 **Artifact**:  
- ![Screenshot 3-9: Secure Bucket Configuration](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots/3%209%20Keeping%20the%20bucket%20but%20adjusting%20settings%20to%20enforce%20safe%20deployment.png)

---

### 🔐 SSH Access Restricted

**Action**:  
Security group retained, but SSH CIDR block changed to trusted IP only (`YOUR.IP.ADDRESS.HERE/32`)

📁 **Artifact**:  
- ![Screenshot 3-10: Restricted Security Group](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots/3%2010%20Keeping%20security%20groups%20but%20limiting%20vulnerbailities.png)

---

---

## 📄 Terraform Plan & Apply Confirmation

After updating the Terraform configuration, a `terraform plan` and `terraform apply` were executed to enforce the secure infrastructure state.

### 🔍 Plan Output
Validated that:
- The insecure IAM user and policy were removed
- Public bucket policy was deleted
- Public access blocks were enforced
- Open SSH rules were eliminated or updated

### ✅ Apply Output
Confirmed that:
- All changes were applied successfully
- Infrastructure now aligns with secure configuration in `main.tf`

📁 **Artifact**:
- ![Screenshot: Terraform Apply](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots/3%2011%20Ran%20new%20secure%20IaC%20via%20Terraform.png)

---

## 📂 Terraform File References

To aid comparison and transparency, both the original insecure configuration and the remediated version are available below:

- 🔓 [Original Insecure main.tf](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/terraform/insecure/main.tf)
- 🔐 [Secure Remediated main.tf](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/terraform/secure/main.tf)

---

## 📌 Key Takeaways

- Infrastructure misconfigurations must be addressed both operationally (in AWS Console) and declaratively (in Terraform).
- IAM users with wildcard access should never exist in production.
- Public S3 access and open SSH are high-risk defaults that must be explicitly locked down.
- Remediation must be reflected in IaC or the same issues will reappear on the next `terraform apply`.

---

⬅️ [Back to Chapter 2: Investigation](2-Detection_and_Investigation.md)  
➡️ [Continue to Chapter 4: Lessons Learned »](./4-Lessons_Learned.md)
