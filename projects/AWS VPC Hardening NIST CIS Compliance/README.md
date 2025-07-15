# AWS Cloud Security Lab: GDPR, NIST, & CIS VPC Hardening  

## 🔐 Project Overview  
This lab project demonstrates the end-to-end design, deployment, and hardening of an enterprise-grade AWS VPC, aligned with key security frameworks:
- GDPR – Technical safeguards for Articles 32–34 (data protection, breach detection, response)
- NIST 800-53 – Across access control, audit, system integrity, and incident response families
- CIS AWS Foundations Benchmark – Controls 1–5, including IAM, monitoring, data protection, and patching

## ✅ What Makes This Project Unique
- **Full Lifecycle Security** – From network segmentation and identity governance to detection and incident response
- **Modular & Reproducible** – Each phase is isolated into logical “steps” that mirror how enterprise teams implement controls
- **Hands-On Validation** – Each security control is validated with live testing, from attack simulation to automated response
- **Cost-Conscious Compliance** – All implementations tested using free-tier AWS, with limitations documented and workarounds explored

---

## 📁 Documentation Structure
Each step includes architecture diagrams, configuration screenshots, CLI output, and compliance mappings.

| Step | Title | Description |
|------|-------|-------------|
| [▶ Step 1](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/steps/1%20VPC%20Architecture/README.md) | **VPC Architecture & Network Segmentation** | Multi-tier subnet design with routing, NACLs, and security groups |
| [▶ Step 2](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/steps/2%20IAM%20Hardening/README.md) | **IAM Hardening & Identity Governance** | Break-glass admin, MFA, least privilege roles, and compliance monitoring |
| [▶ Step 3](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/steps/3%20Monitor%20Threats/README.md) | **Threat Detection & Continuous Monitoring** | GuardDuty and CloudTrail integrated with real and simulated threat validation |
| [▶ Step 4](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/steps/4%20Encrypt%20Data/README.md) | **Data Protection & Encryption** | KMS-backed encryption for EBS, S3, TLS enforcement, CloudTrail protection |
| [▶ Step 5](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/steps/5%20Respond%20Incidents/README.md) | **Patch Management & System Hardening** | Automated patching via SSM Patch Manager, with compliance scanning |
| [▶ Step 6](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/steps/6%20Simulated%20Detection%20Response/README.md) | **Incident Response Automation & Simulation** | GuardDuty-to-Lambda integration that isolates EC2 instances in response to simulated attacks |

---

## 🧭 Framework Mapping & GDPR Alignment 
| Framework               | Category / Article                   | Summary                                                 | Alignment in Lab                                               |
| ----------------------- | ------------------------------------ | ------------------------------------------------------- | -------------------------------------------------------------- |
| **NIST 800-53**         | **AC – Access Control**              | Enforce least privilege, restrict admin access          | IAM roles, security group segmentation, scoped permissions     |
|                         | **SI – System Integrity**            | Detect and remediate flaws                              | GuardDuty, patch baselines, vulnerability scans                |
|                         | **IR – Incident Response**           | Respond to and contain security events                  | GuardDuty + EventBridge + Lambda EC2 quarantine                |
|                         | **AU – Audit & Accountability**      | Capture and protect logs                                | CloudTrail, KMS encryption for audit logs                      |
|                         | **SC – System & Comm. Protection**   | Protect data in transit and at rest                     | EBS/S3 encryption, TLS, KMS enforcement                        |
| **CIS AWS Foundations** | **1.1–1.23**                         | Identity and Access Management (IAM)                    | MFA, no root use, IAM roles, password policies                 |
|                         | **2.1–2.3**                          | Logging & Monitoring                                    | CloudTrail, VPC Flow Logs, GuardDuty                           |
|                         | **3.1–3.14**                         | Networking                                              | VPC segmentation, NACLs, least privilege security groups       |
|                         | **4.1–4.5**                          | Monitoring, Response & Recovery                         | GuardDuty, patching, EventBridge automated response            |
|                         | **5.1–5.3**                          | Data Protection                                         | S3/EBS encryption, TLS, KMS key rotation                       |
| **GDPR**                | **Art. 32 – Security of Processing** | Ensure data protection via technical and org safeguards | Encryption, IAM hardening, GuardDuty, patch management         |
|                         | **Art. 33 – Breach Notification**    | Detect and notify within 72 hours                       | GuardDuty detection, tagging + Lambda isolation                |
|                         | **Art. 34 – Breach Communication**   | Inform data subjects when risk is high                  | Tagging of compromised EC2, isolation supports incident triage |

---

## 📌 Notes  
- **Validated** - Each implementation was functionally tested (where AWS sandbox limits allowed), with logs and screenshots captured
- **Realistic** - Where true attack behavior couldn’t be triggered (e.g. GuardDuty sample findings), simulations were used to prove logic
- **Repeatable** - All configurations use AWS-native tools—ready to scale or replicate in a real org
