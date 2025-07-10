# 📘 Chapter 4: Lessons Learned

## 🧠 Summary

This incident simulation demonstrated how a misconfigured IAM user (`crypto-actor`) with excessive privileges and exposed access keys could be leveraged to launch unauthorized EC2 instances for malicious purposes (crypto mining). Through AWS-native tools such as CloudTrail and GuardDuty, the activity was detected and responded to, though with some delay due to free-tier sandbox limitations.

---

## 🔍 What Went Wrong

### 🔓 Over-permissioned IAM User
- The IAM user was granted the `AdministratorAccess` policy, violating the principle of least privilege.
- Broad permissions allowed the attacker to launch EC2 instances, bypassing basic safeguards.

### 🔑 Access Key Mismanagement
- The access key was created and stored locally without any safeguards (e.g., environment variables, short-lived credentials, or encryption).
- No MFA was enabled, making the account more vulnerable.

### 🕵️‍♂️ Detection Delay
- A **30-minute delay** occurred before GuardDuty generated a finding, which could be significant in a real-world breach scenario.
- The EC2 was launched in **us-east-1** while GuardDuty and CloudTrail were initially configured for **us-east-2**, causing initial confusion.

---

## ✅ What Went Well

### ✅ AWS CloudTrail Tracing
- All key events — user creation, access key usage, and EC2 launch — were captured by CloudTrail for audit and investigation.

### ✅ GuardDuty Detection
- GuardDuty eventually detected the suspicious activity via DNS calls to a known Bitcoin mining domain.

### ✅ Containment
- The instance was promptly terminated, the access key was disabled, and IAM permissions were corrected.
- Cleanup was thorough, and actions were logged for future audit.

---

## 🛠️ Recommendations

### 🔐 Enforce Least Privilege
- IAM users should be assigned permissions through tightly scoped policies and **groups**, not direct `AdministratorAccess`.

### 🔑 Enforce MFA and Credential Hygiene
- Require MFA for all IAM users.
- Use short-lived, temporary credentials via IAM roles and avoid long-lived access keys.

### 📡 Enable GuardDuty in All Regions
- Ensure GuardDuty is active **across all AWS regions**, not just the default or most-used ones.

### 📬 Set Up Real-Time Alerting
- Integrate GuardDuty findings with **Amazon SNS**, **Slack**, or **email alerts** via **EventBridge** to reduce detection time.

### 🧪 Regularly Test IR Procedures
- Simulated breaches like this should be part of ongoing incident response exercises to build team familiarity with AWS detection and containment workflows.

---

## 📈 Outcome

This exercise provided hands-on experience with:

- Simulating a cloud-based breach
- Investigating incidents using native AWS tools (CloudTrail, GuardDuty)
- Executing containment and remediation using the CLI and console
- Documenting incidents in a structured, reusable format

---

## 📚 Next Steps (Optional Improvements)

- Automate remediation with **Lambda** triggered by GuardDuty findings
- Add detection scenarios for **S3 data exfiltration** or **IAM privilege escalation**
- Include alerts for non-compliant IAM configurations using **AWS Config Rules**

⬅️ [Back to Chapter 3: Containment and Remediation](3-Containment_and_Remediation.md)
➡️ [Continue to Chapter 5: Response Playbook »](5-Response_Playbook.md)
