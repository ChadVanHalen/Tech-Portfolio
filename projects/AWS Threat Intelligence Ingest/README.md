# 🛡️ Automated Threat Intelligence Ingestion & Processing on AWS – From Feed to Firewall
This project set out to build a fully automated pipeline to ingest, parse, and store threat intelligence data—specifically malicious IPs and CIDR blocks—from external sources like Spamhaus, using AWS Lambda, DynamoDB, S3, and EventBridge.
While the ultimate goal was to integrate this data with AWS GuardDuty’s Threat Intel Sets, free-tier account restrictions around IAM permissions prevented completing that final integration step. Still, the bulk of the automation pipeline was built, tested, and validated.

## 🎯 Objectives
- Automatically fetch threat feed JSON on a schedule
- Parse unique malicious IP and CIDR ranges, storing them in DynamoDB
- Export the curated threat list to a TXT file in S3
- Prepare the data for easy consumption by security tools like GuardDuty or WAF
- Use EventBridge rules to orchestrate scheduled ingestion and export workflows

## ⚙️ Architecture Overview
| Component       | Purpose                                                               |
| --------------- | --------------------------------------------------------------------- |
| Lambda (Ingest) | Retrieves JSON feeds, parses threat IPs, and stores unique entries    |
| DynamoDB        | Persistent store for parsed malicious IP addresses and metadata       |
| Lambda (Export) | Converts DynamoDB data to TXT format and uploads it to S3             |
| S3 Bucket       | Centralized storage for threat intel files accessible by AWS services |
| EventBridge     | Triggers Lambda functions on a fixed schedule for automation          |

> 🧠 Note: This setup is flexible to feed threat intel into multiple AWS security services—even if GuardDuty integration was blocked by permissions here.

## 🧪 What Worked & What Didn’t
| Outcome                       | Details                                                         | Notes                                              |
| ----------------------------- | --------------------------------------------------------------- | -------------------------------------------------- |
| Automated ingestion pipeline  | Successfully fetched, parsed, and stored IP/CIDRs in DynamoDB   | Lambda functions tested and verified               |
| Scheduled exports to S3       | TXT file with all unique threat IPs generated on schedule       | Export Lambda verified by inspecting S3 contents   |
| GuardDuty Threat Intel update | Failed due to IAM permission restrictions on free-tier accounts | Required `iam:PutRolePolicy` disallowed in sandbox |

## 🧩 Lessons Learned
- IAM permissions can be a bottleneck: GuardDuty API calls require precise and sometimes privileged permissions not available in free or sandbox accounts.
- Automation pipeline is modular: Parsing, storing, and exporting threat intel is fully functional and can be extended to other AWS security services.
- Plan for environment constraints early: Understanding account limits saves time in large automation projects.

## 📁 Artifacts & Proof of Work
| Step | Description                                               | Artifact / Screenshot              |
| ---- | --------------------------------------------------------- | ---------------------------------- |
| 1️⃣  | DynamoDB table created to store IOC data                  | `ThreatIntelIngest-v1.json`   |
| 2️⃣  | EventBridge rule scheduled to run ingestion Lambda hourly | EventBridge rule config screenshot |
| 3️⃣  | Lambda parsing JSON feed and inserting unique IPs         | `ThreatIntelIngest-v2.json`   |
| 4️⃣  | DynamoDB query confirmed correct entries                  | DynamoDB console screenshot        |
| 5️⃣  | Lambda exporting IP list to TXT file in S3                | `DynamoToS3.json`             |
| 6️⃣  | TXT file verified in S3 bucket                            | S3 bucket console screenshot       |
| 7️⃣  | Attempted GuardDuty integration blocked by permissions    | CloudWatch error logs snippet      |

# 🔚 Summary
This project built a robust, automated pipeline to ingest and process threat intelligence data in AWS using serverless components—Lambda, DynamoDB, S3, and EventBridge. While integration with GuardDuty Threat Intel Sets was blocked by account restrictions, the core ingestion and export functionality works well and can be reused or extended.
> 🔐 The takeaway: Building security automation pipelines is rewarding but requires careful attention to service permissions and account capabilities, especially on limited or trial environments.
