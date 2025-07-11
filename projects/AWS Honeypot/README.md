Project: AWS Honeypot + Threat Intelligence Automation Lab
1. Project Goals
Deploy lightweight honeypots on AWS EC2 instances to capture attacker activity

Ingest external threat intelligence feeds (e.g., IP blocklists, IOC feeds)

Automate threat detection and alerting via AWS GuardDuty, Security Hub, and Lambda

Automate response workflows (e.g., isolate compromised hosts, update security groups)

2. Proposed Tech Stack
| Component               | AWS Service / Tool                                                                 | Purpose                                        |
| ----------------------- | ---------------------------------------------------------------------------------- | ---------------------------------------------- |
| Honeypot                | EC2 instances running honeytokens or open-source honeypots (e.g., Cowrie, Dionaea) | Capture attacker interactions                  |
| Threat Intel Ingestion  | Lambda + EventBridge / S3                                                          | Periodically ingest IP blocklists or IOC feeds |
| Detection & Aggregation | AWS GuardDuty + Security Hub                                                       | Centralize and analyze threat data             |
| Automation              | Lambda functions                                                                   | Automated response and enrichment              |
| Networking              | Security Groups + VPC Flow Logs                                                    | Control and monitor traffic                    |
| Notification            | SNS / CloudWatch Alarms                                                            | Alert when suspicious activity detected        |

3. Project Folder Structure
AWS-Honeypot-ThreatIntel-Automation/
├── README.md
├── terraform/                  # Infrastructure as Code to deploy honeypot and resources
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── lambda/                     # Lambda functions source code
│   ├── threat_intel_ingest.py
│   ├── automate_response.py
│   └── utils.py
├── scripts/                    # Helper scripts (e.g., deploy honeypots, setup honeypot software)
│   └── setup_honeypot.sh
├── docs/                       # Additional documentation, threat intel sources, architecture diagrams
│   └── architecture_diagram.png
└── config/                     # Configuration files like threat intel feed URLs or IP lists
    └── threat_intel_sources.json

4. README Outline
Title
AWS Honeypot + Threat Intelligence Automation Lab
Overview
This lab demonstrates deploying honeypots on AWS EC2 instances integrated with external threat intelligence feeds. It uses AWS GuardDuty and Security Hub for detection and centralizes alerts with automated response workflows via Lambda.

Goals
Capture attacker activity using honeypots on AWS

Integrate and automate ingestion of external threat intelligence

Use GuardDuty and Security Hub to analyze events

Automate incident response and alerting with Lambda and SNS

Architecture
(Insert architecture diagram here: shows EC2 honeypots, threat intel ingestion pipeline, GuardDuty/Security Hub, Lambda automation)

Components
EC2 Honeypots: Lightweight honeypot deployments (Cowrie or custom honeytokens)

Threat Intel: Scheduled Lambda functions pulling external feeds (OTX, AbuseIPDB)

Detection: GuardDuty findings and Security Hub aggregation

Automation: Lambda functions triggered on findings for alert enrichment, isolation, or remediation

Notifications: SNS alerts on suspicious activity

Prerequisites
AWS Free Tier account with permissions for EC2, Lambda, GuardDuty, Security Hub, SNS, EventBridge, IAM, VPC

Terraform installed (optional but recommended)

AWS CLI configured locally

Basic Linux and Python knowledge

Setup Instructions
Clone the repo

Deploy infrastructure with Terraform (terraform init && terraform apply)

Launch honeypots using provided scripts (scripts/setup_honeypot.sh)

Configure threat intel sources (config/threat_intel_sources.json)

Deploy Lambda functions (lambda/threat_intel_ingest.py, lambda/automate_response.py)

Enable GuardDuty and Security Hub on your AWS account

Configure EventBridge rules to trigger Lambda on GuardDuty findings

Subscribe to SNS alerts for notifications

Usage & Testing
Simulate attacks against honeypots (e.g., SSH brute force, scanning)

Monitor GuardDuty findings and Security Hub dashboard

Confirm Lambda functions trigger and automate response (e.g., block IP, isolate instance)

Review SNS alerts sent to your email or Slack

Future Work
Add more honeypot types (web, database)

Integrate additional threat intel feeds

Add automatic ticket creation via ServiceNow or Jira API

Enhance incident response workflows

References & Resources
AWS GuardDuty: https://docs.aws.amazon.com/guardduty/latest/ug/what-is-guardduty.html

AWS Security Hub: https://aws.amazon.com/security-hub/

Cowrie Honeypot: https://github.com/cowrie/cowrie

AlienVault OTX: https://otx.alienvault.com/

AbuseIPDB API: https://www.abuseipdb.com/api-docs
