# 🛡️ Cloud Incident Response Lab (AWS)

## Overview
This lab simulates a real-world AWS breach scenario and walks through a structured cloud incident response process. The goal is to demonstrate how to detect, investigate, contain, and remediate a security incident in AWS using native services and logs.

> 🔍 Use Case: This project simulates a compromised IAM user who launches unauthorized EC2 instances for crypto mining.

---

## 💻 Tools & Services Used
- AWS IAM
- AWS CloudTrail
- AWS GuardDuty
- AWS CloudWatch Logs
- AWS Config
- Optional: AWS Lambda, EventBridge, SNS for alerting automation

---

## 🧭 Steps

| Step | Description |
|------|-------------|
| **1. Simulate the Incident** | Create misconfigured IAM policies and simulate suspicious behavior (e.g., login from unfamiliar IP, launching EC2 instances) |
| **2. Investigate** | Use GuardDuty findings, CloudTrail logs, and IAM history to trace the breach |
| **3. Contain & Remediate** | Disable access, isolate instances, correct IAM policies |
| **4. Lessons Learned** | Write a summary and create a basic IR playbook for AWS |

---

## 📄 Project Files
| File | Description |
|------|-------------|
| `1-Incident_Simulation.md` | Walkthrough of simulating a cloud breach scenario |
| `2-Investigation.md` | Step-by-step investigation using AWS logs |
| `3-Containment_and_Remediation.md` | Fixing the issue and restoring security posture |
| `4-Lessons_Learned.md` | Summary and recommendations for prevention |

---

## 📸 Screenshots / Evidence
All key actions are logged in CloudTrail and visualized through screenshots in the `artifacts/` folder.

---

## 📈 Outcome
- Demonstrated end-to-end incident response process
- Practical experience with AWS logging, detection, and IAM remediation
- Created documentation and artifacts for future IR training/playbooks

---

## 📚 Further Improvements
- Automate detection and remediation with Lambda + EventBridge
- Add Slack/SNS alerting for suspicious behavior
- Expand to include S3 data exfiltration scenario

