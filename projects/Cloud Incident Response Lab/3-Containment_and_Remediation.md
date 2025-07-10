# 🔐 Chapter 3: Containment and Remediation

## 🎯 Objective
Simulate containment of an active cloud breach and implement remediation actions to restore security posture. This step represents a real-world response to compromised credentials and unauthorized resource usage.

---

## 🚨 Containment Actions

### ✅ 1. Terminate Malicious EC2 Instance
The EC2 instance launched by the compromised IAM user (`crypto-actor`) was terminated using its instance ID as identified from GuardDuty.
- This confirms that the crypto-mining workload was stopped immediately

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Cloud%20Incident%20Response%20Lab/artifacts/3%201%20Stopped%20the%20offending%20instance%20based%20on%20the%20ID%20from%20GuardDuty.png)

### ✅ 2. Disable Compromised Access Key
To prevent continued unauthorized access, the access key associated with crypto-actor was disabled.
- This ensures the attacker no longer has programmatic access

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Cloud%20Incident%20Response%20Lab/artifacts/3%202%20Disable%20crypto-actor%20Access%20Key%20to%20block%20further%20use%20of%20compromised%20credentials.png)

### ✅ 3. Remove Administrator Permissions
The AdministratorAccess policy was detached from crypto-actor, enforcing least-privilege standards.
- This reflects a security posture reset to avoid attack reoccurence

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Cloud%20Incident%20Response%20Lab/artifacts/3%203%20Remove%20the%20unnecessary%20admin%20permissions%20from%20the%20user.png)

### 🧼 Local Cleanup
I cleared the locally stored credentials on my machine to avoid any unintended use

```bash
rm ~/.aws/credentials
```

## Remediation Recommendations

### 🔐 Enable MFA on All IAM Users
Enforcing multi-factor authentication (MFA) significantly reduces risk of credential compromise.

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Cloud%20Incident%20Response%20Lab/artifacts/3%204%20Showing%20a%20few%20avenues%20for%20remediation%20including%20MFA%20and%20the%20use%20of%20groups%20within%20AWS.png)

### 🧾 Apply Least Privilege with IAM Groups
Use IAM groups with scoped policies instead of individual users with elevated access.

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/Cloud%20Incident%20Response%20Lab/artifacts/3%205%20Created%20a%20least%20privilge%20user%20group.png)

### 🔄 Rotate Access Keys Regularly
- Enforce key rotation schedules
- Consider moving toward role-based temporary credentials with STS

### 🛡️ Harden Detection and Monitoring
- GuardDuty should be enabled in all active regions
- Enable CloudTrail and VPC Flow Logs continuously
- Integrate with EventBridge + SNS or Slack for real-time alerts

## ✅ Summary
The unauthorized activity was successfully:

- Contained by disabling the compromised IAM user's access and terminating the malicious instance
- Remediated by enforcing IAM hardening practices and improving detection posture

These steps reflect standard incident response practices in a cloud environment and build a foundation for automated response in future improvements.

---

⬅️ [Back to Chapter 2: Investigation](./2-Investigation.md)
➡️ [Continue to Chapter 4: Lessons Learned »](./4-Lessons_Learned.md)
