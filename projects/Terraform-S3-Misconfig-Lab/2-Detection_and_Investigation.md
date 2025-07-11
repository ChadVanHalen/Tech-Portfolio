# 📘 Chapter 2: Investigation Report

## 🔎 Overview
With the environment breached and suspicious activity carried out by the misconfigured IAM user (`terraform-crypto-actor`), the next phase focused on detection and investigation.
While AWS GuardDuty provided some helpful initial findings, it notably did not detect the full scope of the malicious behavior.
This gap emphasized the importance of combining GuardDuty, CloudTrail, and manual log analysis to complete the picture.

---

## 🧪 Simulated Attacker Behavior
As the misconfigured IAM user, the following actions were performed to emulate realistic attacker behavior:
1. Console Access + Access Keys
The `terraform-crypto-actor` user logged into the AWS console and generated a new set of programmatic access keys.

2. S3 Activity
Using the AWS CLI, the actor attempted to:
- Upload files to the misconfigured S3 bucket (`PutObject`)
- List bucket contents (`ListBuckets`, `ListObjects`)

3. EC2 Activity
The attacker launched a new EC2 instance in the same region (`us-east-2`) via the AWS Console.

4. SSH Access
The attacker SSH’d into the EC2 instance using the misconfigured security group that allowed port 22 from `0.0.0.0/0`.

---

## 🧠 GuardDuty Findings
GuardDuty successfully generated two findings related to the S3 misconfiguration:
| Finding                                     | Severity | Description                                               |
| ------------------------------------------- | -------- | --------------------------------------------------------- |
| `Policy:S3/BucketBlockPublicAccessDisabled` | Low      | The public access block was turned off for the S3 bucket. |
| `Policy:S3/BucketAnonymousAccessGranted`    | High     | Public anonymous access was granted to the S3 bucket.     |

### 📁 Artifacts:
- [GuardDuty_AnonymousAccessGranted.json](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots/2%201%20Amazon%20S3%20Public%20Anonymous%20Access%20was%20granted%20for%20the%20S3%20bucket%20misconfig-demo-bucket-chad-unique.json)
- [GuardDuty_BlockPublicAccessDisabled.json](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots/2%201%20Amazon%20S3%20Block%20Public%20Access%20was%20disabled%20for%20the%20S3%20bucket%20misconfig-demo-bucket-chad-unique.json)

### 📍Notably Missing Findings:
Despite malicious actions being taken (including EC2 provisioning and S3 enumeration/upload attempts), GuardDuty did not generate findings for:
- IAM user key creation
- EC2 instance launch
- S3 bucket usage
- SSH activity from a VPN IP

This was expected in some cases:
- GuardDuty relies on threat intelligence feeds and behavioral anomalies, and not all actions are inherently “suspicious.”
- The user operated from an IP not on AWS’s known threat list.
- Some detections may only trigger after repeated abuse or known malware use (e.g., Bitcoin mining tools).

---

## CloudTrail Investigation
Because GuardDuty’s findings were limited, CloudTrail became essential for reconstructing events.
1. IAM User Activity
Using CloudTrail log filtering by user terraform-crypto-actor, a number of relevant events were observed.

2. EC2 Instance Launch
While RunInstances wasn’t directly logged, the relevant action appeared under StartInstances.

📁 Artifacts:
- [CloudTrail_StartInstance.json](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots/2%202%20StartInsatance%20log.json)
- ![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots/2%202%20StartInstance%20event.png)

These logs helped confirm:
- The IAM user launched an EC2 instance
- The instance launched in the same region as GuardDuty was active

---

## 📌 Key Takeaways
- Detection doens't always mean alerting. GuardDuty is powerful, but it is only one later in a larger incident response strategy
- CloudTrail is critical when GuardDuty is silent. Logs don't lie... Even when the alarms are quiet
- Simulated attacker actions may not trigger detections if done from benign IPs, or without specific threat signatures

- ---

⬅️ [Back to Chapter 1: Incident Simulation](./1-Insecure_Terraform_Buckets.md)
➡️ [Continue to Chapter 3: Remediation »](./3-Remediation.md)
