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
