
---

### 📄 `4-Lessons_Learned.md`

```markdown
# 📘 Chapter 4: Lessons Learned

## 🧠 Summary

This lab demonstrated how insecure S3 configurations can be introduced via Terraform, and how to detect and remediate them using IaC scanning, AWS Config, and secure provisioning practices.

---

## 🔍 What Went Wrong

- Terraform deployed S3 buckets with:
  - Public access enabled
  - No encryption
  - Versioning/logging missing

- Static analysis tools were not enforced in CI/CD

---

## ✅ What Went Well

- AWS Config successfully detected risky resources
- tfsec flagged insecure HCL before deployment
- Secure templates remediated all issues

---

## 🛠️ Recommendations

- Use **IaC scanning tools** (e.g., tfsec, Checkov) in pipelines
- Enforce **policy-as-code** with OPA or Sentinel
- Enable **AWS Config** rules organization-wide
- Prefer **IAM roles + secure defaults** in Terraform modules
- Rotate access keys, apply tagging for visibility

---

## 📈 Takeaways

- Terraform simplifies repeatable provisioning — including risky misconfigurations
- Policy-as-code and static scanning are essential in shift-left security
- Cloud-native tools like AWS Config help detect drift and policy violations

---

## 📚 Next Steps (Optional)

- Add GitHub Actions workflow for IaC scanning
- Expand misconfiguration testing to other services (IAM, EC2, RDS)
- Integrate EventBridge for real-time misconfig alerting
