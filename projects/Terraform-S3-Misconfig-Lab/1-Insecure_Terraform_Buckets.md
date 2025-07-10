# 🧨 Chapter 1: Incident Simulation – Unauthorized EC2 Launch for Crypto Mining

We’re kicking off this project by doing the one thing you're never supposed to do in production: misconfigure everything on purpose.

This chapter sets the stage for a simulated breach in AWS, using Terraform to spin up vulnerable infrastructure that mimics what happens when access control is lax, monitoring is absent, and someone thinks "*" is a good idea for IAM permissions.

## 🎯 Goals

- Spin up an over-permissioned IAM user (terraform-crypto-actor)
- Create a public S3 bucket serving a file to the internet
- Open SSH to the world with a poorly locked-down security group
- Use that misconfigured user to launch and access an EC2 instance
- Generate enough bad behavior to trigger AWS-native detection tools later

---

## 🛠️ What Terraform Deployed

| Resource                            | Purpose                                                 |
| ----------------------------------- | ------------------------------------------------------- |
| `aws_iam_user`                      | User with full wildcard (`*:*`) permissions             |
| `aws_s3_bucket`                     | Publicly readable S3 bucket                             |
| `aws_s3_bucket_policy`              | Explicit public access to bucket objects                |
| `aws_s3_bucket_public_access_block` | Disabled safety features that would block public access |
| `aws_s3_object`                     | Uploaded an `index.html` file to act as exposed content |
| `aws_security_group`                | SSH wide open to the world (`0.0.0.0/0`)                |
| `aws_iam_user_login_profile`        | Console login manually granted for the attacker user    |

Terraform config is stored in the root directory, and all screenshots are collected under artifacts/.

---

## Artifacts & Evidence
1. ✅ Terraform setup and applied locally
→ Initialized Terraform on my Windows machine and configured AWS CLI with my non-root Admin account.
![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots/2%20Run%20terraform%20apply%20using%20the%20configured%20terraform%20code.png)

2. ✅ IAM user created with full access policy
![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots/4%20Confirm%20user%20with%20over%20permissions%20created.png)

3. ✅ S3 bucket created with public read access
![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots/5%20Confirm%20bucket%20exists%20with%20html%20object.png)

4. 🌐 HTML file publicly accessible
→ Confirmed in browser from an unauthenticated device:
![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots/6%20Confirm%20the%20html%20object%20is%20visible%20from%20my%20external%20browser.png)

5. ✅ Security group allows unrestricted SSH
![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots/7%20Confirm%20open%20ssh%20security%20group%20is%20created%20within%20the%20VPC.png)

6. 🔑 Logged in as the attacker IAM user via AWS Console
![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots/8%20I%20log%20into%20the%20console%20as%20the%20misconfigured%20user.png)

7. 🚀 Launched an EC2 instance as the attacker
![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots/9%20As%20the%20misconfigured%20user%20I%20launch%20an%20EC2.png)

8. 💻 SSH’d into the EC2 instance using the attacker identity
![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Terraform-S3-Misconfig-Lab/artifacts/screenshots/10%20Show%20the%20user%20logged%20into%20the%20EC2.png)

All steps from deployment to EC2 compromise are documented in artifacts/, complete with timestamps and terminal output where relevant.

---

## 🛑 What Went Wrong (On Purpose)

| Misconfiguration                      | Impact                                                       |
| ------------------------------------- | ------------------------------------------------------------ |
| **Over-permissioned IAM user**        | Total compromise risk: privilege escalation, resource abuse  |
| **Public S3 bucket**                  | Sensitive data could be exfiltrated without detection        |
| **ACLs and bucket policies disabled** | Circumvented AWS’s default protections                       |
| **World-open SSH access**             | Broad attack surface for brute force / remote code execution |
| **IAM user with console login**       | Full GUI access for attacker; nothing blocking this behavior |


# 🔚 Summary
This lab mirrors common entry points seen in real cloud incidents: exposed S3 buckets, overly broad IAM access, and remote server access via poorly configured security groups. You’ll find similar conditions in a surprising number of leaked cloud breach reports.

The purpose of this chapter isn’t just chaos — it’s to create signals we can detect later, like GuardDuty alerts, CloudTrail logs, and IAM misuse. That’s when the real IR work begins.

---

# 🔜 Next Up: Detection & Investigation
With our trap set, we’re ready to flip perspectives. In Chapter 2, we’ll investigate what just happened — simulating the defender side by analyzing GuardDuty findings, CloudTrail logs, and IAM behavior.

[Next ➡️ Chapter 2: Detection and Investigation](./2-Detection_and_Investigation.md)
