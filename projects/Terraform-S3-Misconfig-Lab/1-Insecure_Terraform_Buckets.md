# 🔧 Chapter 1: Insecure Terraform Buckets

## 🎯 Objective

Use Terraform to provision intentionally misconfigured S3 buckets that violate common cloud security best practices. This sets up the baseline for detection and remediation in later steps.

---

## 🛠️ Misconfigurations Simulated

- ✅ Public read or write access enabled (ACL or bucket policy)
- ✅ No server-side encryption (SSE)
- ✅ Bucket versioning disabled
- ✅ No access logging
- ✅ Missing secure transport enforcement (no HTTPS-only policy)

---

## 📦 Terraform Configuration (Example)

```hcl
resource "aws_s3_bucket" "bad_bucket" {
  bucket = "insecure-terraform-bucket"

  acl    = "public-read"

  versioning {
    enabled = false
  }

  server_side_encryption_configuration {
    # Intentionally omitted
  }

  tags = {
    Environment = "Dev"
  }
}
```

---

## 🚀 Deployment Steps
1- Navigate to the terraform/insecure directory
2- Initialize Terraform:

```bash
terraform init
```

Deploy infrastructure:
```bash
terraform apply
```

### 📸 Evidence
Screenshots and raw Terraform code are located in:
- artifacts/terraform_deploy_screenshots/
- terraform/insecure/

[Next ➡️ Chapter 2: Detection and Investigation](./2-Detection_and_Investigation.md)
