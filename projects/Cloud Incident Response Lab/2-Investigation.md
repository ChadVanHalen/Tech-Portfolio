🕵️ Step 2: Investigation
🎯 Objective
Investigate the GuardDuty alert using:

GuardDuty finding details

CloudTrail logs

IAM activity

EC2 instance metadata (if needed)

🧭 Investigation Flow
✅ 1. Start with the GuardDuty Finding
Go to GuardDuty > Findings, click on the crypto alert, and collect the following:

⛳ Key Fields to Document:
Field	Description
Finding Type	Should be CryptoCurrency:EC2/BitcoinTool.B!DNS
Resource ID	EC2 instance ID
Account ID	Your AWS account number
Region	Should be us-east-2
Instance Details	Includes public IP, tags, and launch time
Action	Should show DnsRequestAction and queried domain (e.g., xmr.crypto-pool.fr)
Time of Finding	Time GuardDuty flagged the activity
Severity	Likely "Medium" or "High"
Threat Purpose	"Unauthorized resource usage"

📝 Save this as a JSON file or screenshot for documentation.

✅ 2. Use CloudTrail to Trace Initial Compromise
Go to CloudTrail > Event history and filter:

plaintext
Copy
Edit
Event source: ec2.amazonaws.com
Event name: RunInstances
Username: crypto-actor
Look for the RunInstances call from the over-permissioned IAM user.

⛳ Key Fields:
Field	Value
Event time	When EC2 was launched
Source IP	Should reflect the VPN (foreign IP)
User identity	Should show the crypto-actor IAM user
Region	Should be us-east-2
Request parameters	AMI, instance type, key name
Response elements	Instance ID (i-xxxxxxxxxxxxx)

📝 Export or copy the log entry to your artifacts folder.

✅ 3. Investigate IAM Access
Still in CloudTrail, search for:

plaintext
Copy
Edit
Event name: CreateAccessKey
Username: crypto-actor
Then:

plaintext
Copy
Edit
Event name: AttachUserPolicy or PutUserPolicy
Username: crypto-actor
⛳ What you’re confirming:
Who created the crypto-actor IAM user and when

Whether AdministratorAccess was attached manually

Any suspicious policy changes or console logins

📝 Document this timeline:

IAM user created

Access key generated

Permissions granted

EC2 instance launched

GuardDuty alert triggered

✅ 4. Optional: Check EC2 Metadata (Advanced Attribution)
If you want to simulate deeper attacker behavior, SSH back into the EC2 instance and run:

bash
Copy
Edit
curl http://169.254.169.254/latest/meta-data/iam/security-credentials/
This shows what credentials the instance has — if an attacker exfiltrated this and used it elsewhere, GuardDuty would raise an InstanceCredentialExfiltration alert.

For now, it’s just useful to understand what IAM role or profile (if any) the instance has.
