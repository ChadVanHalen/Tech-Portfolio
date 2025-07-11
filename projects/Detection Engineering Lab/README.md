# 🛡️ Detection Engineering Lab: IAM Policy Alerting via EventBridge
This lab demonstrates how to engineer a simple yet effective detection pipeline: CloudTrail → EventBridge → SNS — alerting when an IAM user gets AdministratorAccess.

> While this project focused on CloudTrail-based detection, related GuardDuty efforts were explored in other projects [(linked here)](https://github.com/ChadVanHalen/Tech-Portfolio/tree/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/steps/6%20Simulated%20Detection%20Response).

---

## 🎯 Goals
- ✅ Enable multi-region CloudTrail logging for management events.
- ✅ Create a detection rule using EventBridge to match AttachUserPolicy with AdministratorAccess.
- ✅ Deliver email alerts via SNS when detection is triggered.
- ✅ Captured step-by-step screenshots and policy artifacts.

---

## 🧠 Detection Use Case
| Signal                       | Trigger Source   | Action          |
| ---------------------------- | ---------------- | --------------- |
| IAM user granted AdminAccess | CloudTrail Event | SNS Email Alert |

---

## 🧰 Tools Used
- AWS CloudTrail
- EventBridge
- SNS
- IAM

---

## 🛠️ Step-by-Step Setup
### 1 Create CloudTrail (MultiRegion)
- Management events (Read & Write) enabled
- Log storage to S3 bucket: `cloudtrail-logs-demo-chad`
- Region `us-east-1` (required for IMA/global service detection)

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Detection%20Engineering%20Lab/screenshots/1%20Set%20up%20new%20CloudTrail%20and%20S3%20bucket.png)

### 2 Create SNS Topic + Subscription
- Topic: `security-alerts-topic`
- Verified email subscription manually (to avoid prefetch unsubs)

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Detection%20Engineering%20Lab/screenshots/2%20Set%20up%20SNS%20Topic%20that%20will%20send%20to%20my%20email%20address.png)

### 3 Simulate Suspicious Behavior
Attached AdministratorAccess policy to an IAM user named `MaliciousUser`:
```bash
aws iam attach-user-policy \
  --user-name MaliciousUser \
  --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
```

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Detection%20Engineering%20Lab/screenshots/3%20I%20attach%20an%20Admin%20policy%20to%20a%20user%2C%20which%20will%20be%20logged%20by%20CloudTrail%2C%20we'll%20use%20that%20log%20to%20be%20picked%20up%20by%20EventBridge.png)

### 4 Create EventBridge Rule
Pattern used:
```json
{
  "source": ["aws.iam"],
  "detail-type": ["AWS API Call via CloudTrail"],
  "detail": {
    "eventName": ["AttachUserPolicy"],
    "requestParameters": {
      "policyArn": ["arn:aws:iam::aws:policy/AdministratorAccess"]
    }
  }
}
```

- Articfact: [`EventBridge-policy.json`](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Detection%20Engineering%20Lab/artifacts/EventBridge%20iam-policy-change-alert.json)

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Detection%20Engineering%20Lab/screenshots/4%20In%20EventBridge%20I%20create%20an%20event%20rule%20looking%20for%20IAM%20operations%20where%20AdminAccess%20is%20applied%20within%20CloudTrail.png)

### 5 Connect SNS to EventBridge
- Set SNS topic as EventBridge rule's target
- Ensured topic policy allows `events.amazonaws.com` to publish

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Detection%20Engineering%20Lab/screenshots/5%20And%20then%20I%20point%20the%20event%20to%20trigger%20the%20SNS%20notification%20I%20set%20up%20that%20will%20go%20to%20my%20email.png)

### 6 Confirm Email Alert Works
Detached/re-attached the Admin policy again and confirmed:
- Event showed up in CloudTrail (`us-east-1`)
- EventBridge rule matched
- SNS triggered
- Email received successfully

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Detection%20Engineering%20Lab/screenshots/6%20Confirming%20I%20got%20the%20SNS%20email.png)

---

## ⚠️ Real-World Troubleshooting Highlights
| Obstacle                                           | Solution                                                                |
| -------------------------------------------------- | ----------------------------------------------------------------------- |
| ❌ IAM events not detected                          | IAM is a **global service**; logs only appear in `us-east-1`            |
| ❌ SNS instantly unsubscribed                       | Verified email manually via CLI and used a clean SNS topic              |
| ❌ Events not triggering                            | Tested with `put-events` CLI, confirmed rule logic and region placement |
| ❌ CloudTrail events not showing in `Event History` | Ensured `Write` + `Management` events were enabled                      |

---

## 💡 Lessons Learned
- Region context matters deeply in AWS detections — especially with global services like IAM.
- Testing EventBridge manually via `put-events` is a powerful debugging tool.
- End-to-end validation is critical, especially with chained services (CloudTrail → EventBridge → SNS).

---

# 🔗 Related Projects
- 🔐 VPC Hardening w/ GuardDuty Detection Response
