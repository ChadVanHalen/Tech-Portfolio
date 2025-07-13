# 🐝 Automated Honeypot Detection Pipeline
*Automating honeypot log parsing, event detection, and alert notifications for early threat awareness.*
This project demonstrates how to set up a simple yet effective pipeline to capture and process honeypot SSH logs using Cowrie, automate log uploads to S3, parse those logs with Lambda, and trigger SNS notifications for suspicious login attempts.

Was it smooth? Nope. But every bug and missed trigger led to a clearer understanding of how these services stitch together.

---

## 🎯 What This Project Demonstrates
- ✅ Deployed Cowrie SSH honeypot in Docker on EC2 with decoy + real SSH ports
- ✅ Captured and reviewed attacker login attempts via Cowrie logs
- ✅ Automated log uploads from EC2 → S3 every 5 minutes
- ✅ Parsed logs using Lambda and detected suspicious login events
- ✅ Triggered SNS alerts for high-interest activity (e.g., successful login)
- ✅ Overcame IAM and trigger issues using CloudWatch for debugging

---

## ⚙️ Architecture Overview
| Component       | Purpose                                                       |
| --------------- | ------------------------------------------------------------- |
| EC2 Honeypot    | Hosts Cowrie in Docker, simulating an SSH login surface       |
| S3 Bucket       | Stores uploaded Cowrie logs and parsed output                 |
| Lambda Function | Parses Cowrie logs and sends alerts on suspicious events      |
| SNS Topic       | Sends email notifications when attackers trigger the honeypot |
| Crontab Script  | Uploads logs from EC2 to S3 every 5 minutes                   |
| IAM Roles       | Grant least-privilege permissions to EC2 and Lambda           |

---

## 🛠️ Step-by-Step Setup

1. Launch EC2 Instance with Ubuntu
- Configure security groups:
    - Port 22 open for fake SSH (honeypot)
    - Port 2222 open for real SSH (admin access)

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20Honeypot/screenshots/1%20I%20create%20an%20instance%20running%20Ubuntu%20for%20my%20honeypot%2C%20important%20to%20note%20the%20security%20group%20settings%2022%20for%20the%20fake%20SSH%20and%202222%20for%20the%20actual%20SSH.png)

2. Install Docker and Deploy Cowrie Honeypot Container
- Pull and run Cowrie in Docker on the instance.
- Connect to the honeypot via SSH on port 22.

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20Honeypot/screenshots/2%20Install%20Docker%20and%20tehn%20Docker%20Cowrie%20within%20the%20Ubuntu%20server.png)

3. Confirm Cowrie Logs Incoming
- Access Cowrie log files inside the container.
- Copy logs to the EC2 host to verify visibility.

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20Honeypot/screenshots/3%20Make%20an%20SSH%20connection%20to%20the%20Cowrie%20honeypot.png)

4. Automate Log Copying with YAML & Bash Script
- Create a [YAML file](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20Honeypot/scripts/docker-compose.yaml) for automating log copy actions.
- Develop a bash script to upload logs from EC2 to S3 bucket.

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20Honeypot/screenshots/4%20Confirm%20I%20see%20the%20logs%20within%20Cowrie%20of%20the%20connection%20attempt.png)

5. Create S3 Bucket and IAM Role
- S3 bucket to receive Cowrie logs.
- IAM role attached to EC2 with S3 PutObject permission.

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20Honeypot/screenshots/5%20Find%20the%20logs%20from%20Cowrie%20and%20copy%20them%20over%20to%20my%20host%20and%20confirm%20I%20can%20see%20them.png)

6. Schedule Cron Job on EC2
- Configure cron to run the log upload script every 5 minutes.
- Confirm logs regularly appear in the S3 bucket.

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20Honeypot/screenshots/9%20Create%20a%20bash%20script%20to%20upload%20the%20logs%20from%20the%20instance%20to%20the%20bucket.png)

7. Develop Lambda Function to Parse Logs
- Parse raw Cowrie JSON logs into more readable JSON format.
- Test Lambda manually for correct parsing output.

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20Honeypot/screenshots/13%20Confirmed%20the%20automation%20is%20working%20where%20logs%20appear%20at%205%20minute%20intervals.png)

8. Configure S3 PUT Event Trigger for Lambda
- Add S3 bucket PUT event trigger to invoke Lambda automatically.
- Troubleshoot permissions and event configurations.

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20Honeypot/screenshots/14%20Create%20a%20lambda%20function%20that%20will%20parse%20the%20raw%20json%20log%20data%20into%20more%20human%20readable%20text.png)

9. Add SNS Notifications in Lambda
- Detect successful or failed SSH login attempts.
- Send SNS email alerts based on parsed log events.

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20Honeypot/screenshots/17%20The%20issue%20was%20there%20was%20no%20trigger%2C%20I%20added%20PUT%20in%20the%20S3%20bucket%20as%20the%20trigger%20which%20should%20now%20let%20the%20function%20work%20properly.png)

10. Test and Confirm End-to-End Flow
- Trigger login attempts on Cowrie honeypot.
- Verify log uploads, parsing, and SNS alerts received.

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20Honeypot/screenshots/21%20And%20using%20that%20parsed%20info%2C%20I%20will%20get%20an%20SNS%20notifaction%20sent%20to%20my%20email%20for%20any%20successful%20or%20failed%20SSH%20attempts%20into%20the%20honeypot.png)


---

## ⚠️ Troubleshooting Highlights
| Issue                              | Root Cause                       | Fix                                                             |
| ---------------------------------- | -------------------------------- | --------------------------------------------------------------- |
| Lambda not triggered automatically | Missing S3 PUT event trigger     | Added S3 event notification configuration                       |
| Permission errors in Lambda logs   | Insufficient IAM permissions     | Updated Lambda execution role with S3 and SNS permissions       |
| Logs not uploading as expected     | Script or cron misconfiguration  | Verified script execution manually and fixed cron syntax errors |
| No SNS notifications received      | SNS topic policy or subscription | Verified SNS subscription confirmation and topic permissions    |

---

## 📁 Key Artifacts

| File                             | Purpose                                                |
| -------------------------------- | ------------------------------------------------------ |
| [`upload_cowrie_logs.sh`](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20Honeypot/scripts/upload_cowrie_logs.sh)          | Bash script to copy honeypot logs to S3                |
| [`docker-compose.yaml`](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20Honeypot/scripts/docker-compose.yaml)            | Cowrie honeypot container setup                        |
| [`ParseHoneypotLog (basic).json`](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20Honeypot/lambda/ParseHoneypotLog%20(basic).json)  | Initial Lambda version to parse and store logs         |
| [`ParseHoneypotLog (v2).json`](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20Honeypot/lambda/ParseHoneypotLog%20(v2).json)     | Enhanced version filtering suspicious event types      |
| [`ParseHoneypotLog (v3 with SNS)`](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20Honeypot/lambda/ParseHoneypotLog%20(v3%20with%20SNS).json) | Final Lambda with event detection and SNS notification |

---

# 🔗 Related Projects
- [🛡️ VPC Hardening with GuardDuty Detection Response](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/steps/6%20Simulated%20Detection%20Response/README.md)
- [🔐 IAM Policy Alerting via EventBridge](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/IAM%20Privilege%20Escalation/README.md)

---

# 🔚 Summary
This project showcases how automation and parsing of honeypot logs can enhance early threat detection capabilities. By combining Cowrie honeypot data collection, automated log shipping, Lambda-driven parsing, and SNS alerting, it builds a practical detection pipeline ready for further threat intelligence enrichment.
> 🚀 The real value? A repeatable automated pipeline that turns raw honeypot data into actionable security alerts.

