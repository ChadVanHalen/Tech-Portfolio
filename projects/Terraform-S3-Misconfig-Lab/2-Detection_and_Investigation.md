
---

### 📄 `2-Detection_and_Investigation.md`

```markdown
# 🔍 Chapter 2: Detection and Investigation

## 🎯 Objective

Detect and analyze insecure S3 configurations deployed via Terraform using AWS-native tools and static code analysis.

---

## 🧪 Tools Used

- **AWS Config**: Real-time detection of non-compliant resources
- **tfsec / Checkov / Terrascan**: Static scanning of Terraform code
- **AWS CLI / Console**: Manual inspection and validation

---

## 🔎 Findings

### AWS Config

- Non-compliant S3 buckets flagged for:
  - Public access
  - Lack of encryption
  - Logging not enabled

### tfsec Example Output

```bash
[WARNING] aws-s3-enable-bucket-encryption
  Bucket does not have encryption enabled
```

## 🛠️ Validation Commands
```bash
aws s3api get-bucket-acl --bucket insecure-terraform-bucket
aws s3api get-bucket-encryption --bucket insecure-terraform-bucket
aws s3api get-bucket-logging --bucket insecure-terraform-bucket
```
## 📸 Artifacts
Logs and screenshots:
- artifacts/aws_config_findings.json
- artifacts/tfsec_output.txt

[Next ➡️ Chapter 3: Remediation](./3-Remediation.md)
