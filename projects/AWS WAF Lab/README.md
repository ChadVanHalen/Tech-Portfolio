# 🛡️ AWS WAF Lab: Blocking Malicious Traffic

A mini-lab showing how AWS WAF can block malicious web traffic (SQLi, XSS) using custom rules and rate limiting.

## 🧠 Objective

- Deploy a WAF in front of a web app (ALB or CloudFront)
- Simulate common web attacks
- Configure WAF rules to block or log traffic
- Visualize attack patterns via CloudWatch

---

## ⚙️ Setup Overview

| Component | Notes |
|----------|-------|
| Web App | Simple EC2 + ALB or S3 + CloudFront |
| WAF | Associated with the front-end service |
| Rules | Custom rules for SQLi, XSS, bad IPs |
| Logs | CloudWatch for blocked request insights |

---

## 🧪 Test Scenarios

- SQL Injection (e.g., `' OR 1=1 --`)
- Cross-site scripting (`<script>alert(1)</script>`)
- Burp Suite or curl-based payload testing

---

## 📁 Artifacts

- `waf-rules.json` – Custom WAF rules
- Blocked request screenshot from logs
- ALB or CloudFront integration steps
- CloudWatch metrics visualization

---

## 🎯 Skills Demonstrated

- Cloud-native perimeter defense
- WAF rule tuning and false positive management
- CloudWatch log analysis

