
---

### 📄 `3-Remediation.md`

```markdown
# 🔐 Chapter 3: Remediation

## 🎯 Objective

Update the Terraform configuration to follow security best practices for S3. Re-deploy and verify that the resources now comply with AWS Config rules and pass static checks.

---

## ✅ Best Practices Applied

- 🔒 Block public access at the bucket level
- 🔐 Enable default encryption (SSE-S3 or SSE-KMS)
- 🕒 Enable versioning
- 📜 Enforce HTTPS-only access
- 📈 Enable server access logging

---

## 🛠️ Updated Terraform Example

```hcl
resource "aws_s3_bucket" "secure_bucket" {
  bucket = "secure-terraform-bucket"

  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  logging {
    target_bucket = "s3-logging-bucket"
    target_prefix = "logs/"
  }

  tags = {
    Security = "Compliant"
  }
}
```

## 📦 Re-deployment
- Navigate to terraform/secure/
- Run:

```bash
terraform init
terraform apply
```

## ✅ Verification
Check via:
- tfsec
- aws s3api calls
- AWS Config showing compliant status

## 📸 Artifacts
- Screenshots and validated output in:
- artifacts/secure_validation_results/

[Next ➡️ Chapter 4: Lessons Learned](./4-Lessons_Learned.md)
