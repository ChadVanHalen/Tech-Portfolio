# Simulating a Cloud Incident: Unauthorized EC2 Launch (Crypto Mining)

## 🎯 Objective
Simulate a common AWS breach scenario: a compromised IAM user account launches unauthorized EC2 instances to perform crypto mining. This step sets the stage for practicing cloud incident response using native AWS tools.

## 🛠️ Setup Overview
| Component                           | Purpose                                       |
| ----------------------------------- | --------------------------------------------- |
| IAM user with excessive permissions | Simulate misconfigured least privilege        |
| EC2 instance                        | Used to simulate crypto mining workload       |
| AWS CloudTrail                      | Capture all activity for investigation        |
| GuardDuty                           | Detect suspicious activity and raise findings |


## 🧪 Simulation Steps
### ✅ 1. Create a Vulnerable IAM User
Go to IAM > Users > Add user

Username: crypto-actor

Select Programmatic access

Attach AdministratorAccess policy (simulate over-permissioning)

Create access keys (record temporarily for simulation)

💡 You’ll delete these after the simulation!

### 💻 2. Simulate a Breach: Use Access Keys to Launch EC2 Instances
Using AWS CLI with the IAM access keys:

```bash
aws configure
# Enter access key, secret key, and region (e.g., us-east-1)

# Launch an EC2 instance (e.g., t2.micro to stay within free tier)
aws ec2 run-instances \
  --image-id ami-0c02fb55956c7d316 \
  --count 1 \
  --instance-type t2.micro \
  --key-name YourKeyPairName \
  --security-groups default
```
> 🛑 This action will show up in CloudTrail and (eventually) in GuardDuty.

### ⚠️ 3. Optional: Simulate a Suspicious IP Location
If you want to simulate access from a foreign or suspicious IP:

Use a VPN to a non-local country

Or manually tag the activity as "external access" during write-up

### 🕵️ 4. Let GuardDuty Detect the Activity
GuardDuty findings may include:

UnauthorizedAccess:IAMUser/InstanceCredentialExfiltration

CryptoCurrency:EC2/BitcoinTool.B!DNS

Wait ~15 minutes for findings to populate.
If needed, enable GuardDuty under: Security > Amazon GuardDuty

### 🧼 5. Clean Up
Terminate the EC2 instance:
```bash
aws ec2 terminate-instances --instance-ids i-xxxxxxxxxxxxx
```

Delete the IAM user:
```bash
aws iam delete-user --user-name crypto-actor
```

Remove local credentials file:
```bash
rm ~/.aws/credentials
```

### 📌 Artifacts to Save
CloudTrail log snippet of EC2 launch

GuardDuty alert JSON or screenshot

IAM access key creation log

Save these in the artifacts/ folder for the investigation step.

## 🚨 Ethics Reminder
This lab is for educational and simulation purposes only.
Never run actual mining software or generate malicious traffic on AWS.
