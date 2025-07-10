# 🧾 Chapter 5: Response Playbook – Unauthorized EC2 Launch via Compromised IAM
## 🎯 Purpose
This playbook outlines a repeatable incident response process for a common cloud security event: unauthorized EC2 launch via a compromised IAM user, often used for crypto mining or malicious workloads.

This guide is adapted from the simulated incident documented in Chapters 1–4.

## 📍 Trigger Indicators
| Source     | Indicator                                                       |
| ---------- | --------------------------------------------------------------- |
| GuardDuty  | `CryptoCurrency:EC2/BitcoinTool.B!DNS` or similar DNS findings  |
| CloudTrail | `RunInstances` call from unusual IP or user                     |
| Billing    | Sudden spike in EC2 usage or cost alerts                        |
| VPC Flow   | Outbound connections to known mining pools or strange IP ranges |

## 🕵️‍♂️ Triage Checklist
- Is GuardDuty enabled in all active regions?
- Confirm the finding via CloudTrail (RunInstances, AuthorizeSecurityGroupIngress)
- Identify the IAM user/role responsible for the launch
- Correlate timestamps between:
  - IAM activity (user creation, policy changes)
  - EC2 launch
  - DNS queries
- Check billing console for anomalous spikes

## 🔧 Containment Steps (CLI or Console)

### 1. 🔴 Stop or Terminate the EC2 Instance

```bash
aws ec2 stop-instances --instance-ids i-0352761c1d073a1a6
```

Or for complete removal:
```bash
aws ec2 terminate-instances --instance-ids i-0352761c1d073a1a6
```

### 2. 🚫 Disable the Compromised Access Key
```bash
aws iam update-access-key \
  --user-name crypto-actor \
  --access-key-id AKIA... \
  --status Inactive
```

### 3. 🔒 Detach Admin Permissions
```bash
aws iam detach-user-policy \
  --user-name crypto-actor \
  --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
```

### 4. 🧹 Local Credential Cleanup (on analyst machine)
```bash
rm ~/.aws/credentials
```

## ✅ Remediation Actions
| Action                                            | Description                                     |
| ------------------------------------------------- | ----------------------------------------------- |
| 🔐 Require MFA for IAM users                      | Enforce MFA at user/account level               |
| 📉 Rotate or delete unused access keys            | Regular key hygiene and rotation                |
| 🛑 Replace broad policies with scoped group roles | Avoid `AdministratorAccess` on IAM users        |
| 📡 Ensure logging is active                       | GuardDuty, CloudTrail (multi-region), Flow Logs |
| ⚠️ Set up real-time alerting                      | EventBridge → SNS or Slack alerting             |
| 🔁 Regular security reviews                       | IAM Access Analyzer, AWS Config for misconfigs  |


## 📘 Sample IR Log Template
You can document and timestamp actions using a simple log like this:

```text
[2025-07-09 17:02 MDT] GuardDuty Finding triggered: BitcoinTool.B!DNS
[2025-07-09 17:08 MDT] Confirmed instance i-0352761c1d073a1a6 launched by user crypto-actor
[2025-07-09 17:10 MDT] Terminated EC2 instance
[2025-07-09 17:11 MDT] Disabled access key AKIA...
[2025-07-09 17:13 MDT] Detached Admin policy from IAM user
[2025-07-09 17:15 MDT] Rotated credentials, began cleanup
```

## 🧭 Notes
- CloudTrail Lookup Filter (example):

```bash
aws cloudtrail lookup-events \
  --lookup-attributes AttributeKey=EventName,AttributeValue=RunInstances
```

- EventBridge Rule (starter):
Use to forward GuardDuty findings to Slack/SNS

```json
{
  "source": ["aws.guardduty"],
  "detail-type": ["GuardDuty Finding"],
  "detail": {
    "type": ["CryptoCurrency:EC2/BitcoinTool.B!DNS"]
  }
}
```

# 📈 Outcome
This playbook ensures a timely, consistent, and auditable response to unauthorized EC2 activity tied to IAM compromise—one of the most common missteps in AWS security.
