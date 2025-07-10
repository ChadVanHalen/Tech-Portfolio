# 🛡️ Chapter 1: Incident Simulation – Unauthorized EC2 Launch for Crypto Mining

## 🎯 Objective
Simulate a common cloud security incident: an over-permissioned IAM user’s credentials are compromised and are used to launch an EC2 instance for unauthorized cryptocurrency mining.
This simulation sets the stage for detection, investigation, and response using AWS tools.

---

## 🛠️ Simulation Steps

### 1. Create Vulnerable IAM User
- Created an IAM user named **crypto-actor**
- Granted **AdministratorAccess** to simulate poor least-privilege practices
- Created and recorded **programmatic access keys**

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Cloud%20Incident%20Response%20Lab/artifacts/1%20Create%20an%20intentionally%20over-provisioned%20IAM%20account.png)

---

### 2. Use Compromised Credentials to Launch EC2 Instance
- Used AWS CLI (`aws configure`) with the compromised access keys
- Launched a **t2.micro EC2 instance** using:
  - AMI ID: `ami-0fc5d935ebf8bc3bc`
  - Security Group: default

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Cloud%20Incident%20Response%20Lab/artifacts/3%20Using%20that%20IAM%20account's%20elevated%20access%20I%20spin%20up%20a%20new%20EC2%20instance.png)

---

### 3. Wait for GuardDuty Alert
- Initially, **no findings were triggered**
- Confirmed **GuardDuty** was enabled in **`us-east-2`**
- Verified **CloudTrail was multi-region and active**

---

### 4. Simulate Suspicious Activity from EC2
- SSH’d into the EC2 instance using its public IP and key pair
- Executed DNS queries to known crypto mining domain:
  
```bash
# 20 DNS queries to a known crypto mining pool
for i in {1..20}; do
  nslookup xmr.crypto-pool.fr
  sleep 5
done

# Simulate metadata scraping
curl http://169.254.169.254/latest/meta-data/
```

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Cloud%20Incident%20Response%20Lab/artifacts/4%20After%20no%20findings%20are%20caught%20I%20log%20into%20the%20newly%20created%20account%20and%20start%20running%20suspicious%20crypto-related%20commands.png)

---

#### 5. Detection by GuardDuty
- After ~30 minutes, GuardDuty generated a finding:
  - Type: `CryptoCurrency:EC2/BitcoinTool.B!DNS`
  - Severity: `HIGH`
  - Description: The EC2 instance `i-0352761c1d073a1a6` is querying a domain name that is associated with Bitcoin-related activity.

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Cloud%20Incident%20Response%20Lab/artifacts/5%20We%20find%20a%20BitCoin%20related%20finding%20flagged%20in%20GuardDuty.png)

[GuardDuty_Finding.json](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Cloud%20Incident%20Response%20Lab/artifacts/Crytpocurrency%20GuardDuty%20Finding.json)

---

➡️ [Continue to Chapter 2: Investigation Report »](./2-Investigation.md)
