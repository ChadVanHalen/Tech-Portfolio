# Patch Management & System Hardening

## Project Overview
Automated security patching aligned with CIS AWS 4.4 and NIST 800-53 SI-2 (Flaw Remediation)

## Technical Specifications
- Cloud Platform: AWS
- Operating System: Amazon Linux 2023
- Key Components: AWS Systems Manager

# Implementation Walkthrough

## 1. CIS Compliant Patch Baseline
Created a custom patch baseline to enforce secure policy updates:
- Auto-approved: Critical/Security patches only (with 7 day delay for testing)
- OS Coverage: Amazon Linux 2

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%205/1%20Create%20a%20patch%20baseline%20following%20CIS%20AWS%204.4.png)

### Compliance Alignment:
- CIS AWS 4.4: "Automate patch management for EC2 instances"
- NIST 800-53 SI-2: "Install security updates within 15 days"

## 2. Patch Policy Deployment
Configured automated patching via AWS Systems Manager:
- Scan & install weekly security updates
- Rollout Strategy: 10% concurrency with 2% error threshold

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%205/2%20Create%20a%20patch%20manager%20config%20using%20my%20new%20baseline%20for%20Amazon%20Linux%202.png)

## 3. Compliance Validation
Verified hardening via:
- Pre-patch scan - since these were recent deployments, they were all up to date anyway
- Post-patch scan - 100% compliance achieved

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%205/3%20Confirm%20my%20JumpBox%20node%20is%20showing%20as%20compliant%20to%20the%20hardened%20baseline.png)

## 4. Maintenance Window Automation
Scheduled patching with zero downtime:
- CRON schedule of cron(0 2 ? * SUN *) - Weekly on Sunday at 2 AM UTC 
- Task: AWS-RunPatchBaseline with reboot if required

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%205/4%20I%20create%20a%20Maintenance%20Window%20that%20will%20run%20the%20AutoPatchBaseline%20task%20every%20Sunday%20at%202%20am.png)

# Key Takeaways
- Proactive Vulnerability Management: Reduces exposure window for critical flaws
- CIS/NIST Alignment: Demonstrates compliance with:
  - CIS 4.4 (Automated Patching)
  - NIST SI-2 (15 remediation SLA)

---

### ▶️ Related: GuardDuty-Based Response to Compromised Instances

While patching helps prevent vulnerabilities, monitoring and response are critical when prevention fails. See [Step 6 – Incident Response Automation & Simulation](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/steps/6%20Simulated%20Detection%20Response/README.md) for a demonstration of real-time threat mitigation.
