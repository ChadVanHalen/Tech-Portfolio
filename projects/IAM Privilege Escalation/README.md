# 🔐 IAM Privilege Escalation Lab

This short lab demonstrates a common AWS IAM misconfiguration that allows a user to escalate privileges by abusing the `iam:PassRole` permission.

## 🧠 Objective

- Simulate a misconfigured IAM policy that enables privilege escalation
- Abuse the policy to assume a higher-privileged role
- Fix the policy and explain least privilege principles
- Visualize the risk path with policy analysis tools

---

## 🛠️ Lab Steps

1. Create a user with an IAM policy that includes `iam:PassRole` on an overly permissive role
2. Use AWS CLI or Console to assume a higher-privileged role (e.g., `AdminRole`)
3. Perform actions as the escalated identity
4. Remediate the policy and apply least privilege

---

## 🧪 Key Findings

| Misconfig | Impact | Fix |
|-----------|--------|-----|
| `iam:PassRole` to admin role | Enables privilege escalation | Restrict resource scope and add condition keys |

---

## 📁 Artifacts

- `policy-bad.json` – Insecure IAM policy
- `policy-fixed.json` – Secure replacement
- Screenshots of escalation path
- CLI output of assumed role credentials

---

## 🎯 Skills Demonstrated

- IAM policy crafting & abuse
- Least privilege and role chaining
- Cloud security risk analysis
