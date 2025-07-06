# AWS Cloud Security LabL NIST & CIS VPC Hardening  

## 🔐 Project Overview  
This project documents my hands-on journey to architect, deploy, and secure an enterprise-grade AWS VPC while aligning with **NIST 800-53** and **CIS AWS Benchmark** security standards.  

### Key Distinctions
- **Full Lifecycle Security**: Combines preventative, detective, and responsive controls across the entire VPC lifecycle.  
- **Modular Design**: Split into clear, progressive “steps” that simulate real-world workflows—from segmentation to response.
- **Validation-Driven**: Each control is implemented and validated through AWS-native services and sandboxed attack simulations.

---

## 📁 Documentation Structure
All implementation details—including screenshots, configuration files, and compliance evidence—are organized within each step's dedicated repository section above. Navigate using the chapter links below:

| Step | Title | Description |
|------|-------|-------------|
| [▶ Step 1](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/steps/1%20VPC%20Architecture/README.md) | **VPC Architecture & Network Segmentation** | Subnet isolation, routing, NACLs, and security group design |
| [▶ Step 2](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/steps/2%20IAM%20Hardening/README.md) | **IAM Hardening & Identity Governance** | MFA enforcement, least privilege roles, IAM boundary design |
| [▶ Step 3](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/steps/3%20Monitor%20Threats/README.md) | **Threat Detection & Continuous Monitoring** | GuardDuty, VPC Flow Logs, CloudTrail, and detection validation |
| [▶ Step 4](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/steps/4%20Encrypt%20Data/README.md) | **Data Protection & Encryption** | EBS/S3 encryption, TLS setup, KMS key enforcement |
| [▶ Step 5](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/steps/5%20Respond%20Incidents/README.md) | **Patch Management & System Hardening** | CIS-aligned patch automation, baselines, and SSM maintenance |
| [▶ Step 6](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/steps/6%20Simulated%20Detection%20Response/README.md) | **Incident Response Automation & Simulation** | Simulated GuardDuty detection triggering automated EC2 quarantine |

---

## 🧭 Compliance Focus  
This project maps hands-on AWS security implementations to key NIST and CIS benchmarks, including but not limited to:
- NIST 800-53: AC, SC, SI, IR, and AU families
- CIS AWS Foundations: Controls 1–5

Where possible, each step includes references to the specific controls being addressed.

---

## 📌 Notes  
- This project was built using **free-tier AWS resources** to demonstrate low-cost compliance validation.
- All automation logic, screenshots, and testing were performed within a **sandbox environment** for safe experimentation.

---
