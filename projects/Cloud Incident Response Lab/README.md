# 🛡️ Cloud Incident Response Lab (AWS)

## Overview
This lab simulates a realistic AWS security breach scenario and guides you through a structured cloud incident response process.  
The objective is to demonstrate how to **detect, investigate, contain, and remediate** a security incident in AWS using native services, logs, and best practices.

---

## 🔍 Use Case
A compromised, over-permissioned IAM user (`crypto-actor`) is leveraged to launch unauthorized EC2 instances used for cryptocurrency mining.

---

## 💻 Tools & Services Used
- **AWS IAM** – User and permission management  
- **AWS CloudTrail** – API activity logging and audit  
- **AWS GuardDuty** – Threat detection service  
- **AWS CloudWatch Logs** – Monitoring and log aggregation  
- **AWS Config** – Resource compliance tracking  
- **Optional:** AWS Lambda, EventBridge, and SNS for alerting automation  

---

## 🧭 Lab Steps

| Step | Description |
|---|---|
| 1 | **Simulate the Incident:** Create misconfigured IAM users with excessive permissions and simulate suspicious behavior such as launching EC2 instances from foreign IPs. |
| 2 | **Investigate:** Use GuardDuty findings, CloudTrail logs, and IAM activity history to trace the breach timeline and identify attack vectors. |
| 3 | **Contain & Remediate:** Terminate unauthorized EC2 instances, disable compromised credentials, and apply least privilege IAM policies. |
| 4 | **Lessons Learned:** Summarize findings and create actionable recommendations for preventing future incidents. |

---

## 📄 Project Files

| File | Description |
|---|---|
| [Chapter 1: Incident Simulation – Unauthorized EC2 Launch for Crypto Mining](./1-Incident_Simulation.md) | Walkthrough of simulating the cloud breach scenario. |
| [Chapter 2: Investigation Report](./2-Investigation.md) | Step-by-step investigation using GuardDuty and CloudTrail logs. |
| [Chapter 3: Containment and Remediation](./3-Containment_and_Remediation.md) | Incident containment and remediation actions. |
| [Chapter 4: Lessons Learned](./4-Lessons_Learned.md) | Summary of the incident, lessons learned, and security recommendations. |

---

## 📸 Screenshots / Evidence
All key actions—including IAM user creation, EC2 launches, GuardDuty findings, and remediation steps—are documented with screenshots and JSON logs in the `artifacts/` folder.

---

## 📈 Outcome
- Completed an end-to-end AWS cloud incident response simulation  
- Gained practical experience with AWS native security tooling (IAM, CloudTrail, GuardDuty)  
- Developed documentation and evidence artifacts suitable for IR training and audit  

---

## 📚 Further Improvements
- Automate detection and remediation with AWS Lambda triggered by GuardDuty findings  
- Integrate real-time alerting via Amazon SNS, Slack, or email using EventBridge  
- Expand scenarios to include S3 data exfiltration or IAM privilege escalation detections  
- Implement continuous compliance checks with AWS Config Rules  

---

## ➡️ Next Steps
Explore the [Chapter 1: Incident Simulation – Unauthorized EC2 Launch for Crypto Mining](./1-Incident_Simulation.md) to start the lab!
