# 🧠 AWS Detection Engineering Lab: GuardDuty + EventBridge

Build and test a custom cloud detection use case by correlating CloudTrail events and triggering alerts with EventBridge.

## 🧠 Objective

- Create a custom detection for unusual behavior (e.g., EC2 launch from untrusted IP)
- Ingest events from CloudTrail or GuardDuty
- Use EventBridge to trigger an alert (SNS, Lambda, etc.)

---

## 🛠️ Lab Steps

1. Enable CloudTrail and GuardDuty
2. Simulate suspicious behavior (e.g., IAM policy change, brute-force login)
3. Create EventBridge rule to detect and respond
4. Log or notify via SNS / Lambda / Email

---

## 🔍 Detection Use Case Example

| Signal | Trigger | Response |
|--------|---------|----------|
| EC2 from suspicious IP | EventBridge rule | Send SNS alert |
| IAM policy change | CloudTrail event | Log to S3 or trigger Lambda |

---

## 📁 Artifacts

- `eventbridge-rule.json` – Custom rule logic
- Sample suspicious event (JSON)
- Screenshot of alert being triggered
- CloudWatch Insights query (if used)

---

## 🎯 Skills Demonstrated

- AWS detection engineering
- Event-driven automation
- CloudTrail and GuardDuty correlation

