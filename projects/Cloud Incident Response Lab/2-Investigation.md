# 🔍 Investigation Report

## Summary
GuardDuty detected that an EC2 instance made DNS queries to a known crypto mining domain (`xmr.crypto-pool.fr`). The instance was launched by a compromised IAM user (`crypto-actor`) with excessive permissions.

## 📆 Timeline of Events (All times in MDT)
- **15:17** – IAM user `crypto-actor` was created and granted AdministratorAccess
- **15:19** – Access key was created for the user
- **16:26** – Attacker (via compromised keys) launched a t2.micro EC2 instance in us-east-2
- **~16:30–16:45** – Suspicious activity simulated from the EC2 instance (DNS to crypto mining domain)
- **17:02** – GuardDuty generated a finding: EC2 queried a Bitcoin-related domain (`xmr.crypto-pool.fr`)

## Findings

### GuardDuty
- **Finding Type:** CryptoCurrency:EC2/BitcoinTool.B!DNS
- **Instance ID:** i-0123456789abcdef0
- **Domain Queried:** xmr.crypto-pool.fr
- **Source IP:** `18.220.214.60`

### CloudTrail
- **RunInstances call** by `crypto-actor`
- **Source IP:** `18.116.35.29`
- **Region:** us-east-2

### IAM
- `crypto-actor` created and given AdministratorAccess
- Access key used for CLI access and EC2 launch

## Initial Assessment
The attack vector appears to be:
1. Over-permissioned IAM user
2. Credential exposure (possibly hardcoded or leaked)
3. Attacker launched an EC2 instance to mine crypto

## 📦 Artifacts Collected

| File | Description |
|------|-------------|
| [`guardduty_finding.json`](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Cloud%20Incident%20Response%20Lab/artifacts/Crytpocurrency%20GuardDuty%20Finding.json) | Raw JSON of GuardDuty alert showing crypto mining detection |
| [`cloudtrail_runinstances.json`](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Cloud%20Incident%20Response%20Lab/artifacts/CloudTrail%20RunInstance%20Event.json) | CloudTrail log showing EC2 launch by compromised user |
| [`cloudtrail_createuser.json`](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Cloud%20Incident%20Response%20Lab/artifacts/CreateUser%20Log.json) | Log of IAM user `crypto-actor` being created |
| [`cloudtrail_createaccesskey.json`](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Cloud%20Incident%20Response%20Lab/artifacts/Create%20Access%20Key%20Log.json) | Log of access key creation for `crypto-actor` |
| [`cloudtrail_attachuserpolicy.json`](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Cloud%20Incident%20Response%20Lab/artifacts/AttachUserPolicy%20Log.json) | Log showing attachment of `AdministratorAccess` policy |
