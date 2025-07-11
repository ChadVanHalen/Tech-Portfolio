# 🔐 IAM Privilege Escalation Lab - The "Oops, I Can Do More Than I probably Should" Story

Welcome to the world of IAM misconfigurations, where one little permission slip can snowball into a full admin takeover. In this lab, we’ll explore how a seemingly innocent `iam:PassRole` privilege can let a lowly user escalate themselves to admin powers faster than you can say “least privilege.”

Spoiler alert: it doesn’t always end well for your cloud security posture.

## 🧠 Objective

- Create a misconfigured IAM policy that allows passing a highly privileged role
- Use that policy to escalate permissions and create a Lambda function as the “bad actor”
- Attempt to invoke the Lambda function to test further escalation
- Observe where missing permissions stop the attacker (thanks, defense in depth!)
- Fix the policy and explain the importance of least privilege principles

---

## 🛠️ Lab Steps

| Step | What’s Happening                                                                              |
| ---- | --------------------------------------------------------------------------------------------- |
| 1    | Create an Admin Role trusted by EC2 with AdministratorAccess                                  |
| 2    | Create a malicious IAM policy (`policy-bad.json`) allowing `iam:PassRole` and Lambda creation |
| 3    | Create a user with this over-permissioned policy and CLI access                               |
| 4    | Upload a dummy Lambda function (`lambda_function.py`) as this user                            |
| 5    | Try invoking the Lambda function to see if you can run code                                   |
| 6    | Hit an `AccessDenied` error — privilege escalation is incomplete                              |
| 7    | Learn why layered controls save you, and fix the policy to least privilege                    |

---

## 📸 Visual Proof & Artifacts

| Step | Description                                                                | Screenshot / Artifact                                  |
| ---- | -------------------------------------------------------------------------- | ------------------------------------------------------ |
| 1    | Admin Role creation with `AdministratorAccess` trust policy                | ![AdminRole](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/IAM%20Privilege%20Escalation/screenshots/1%20Create%20Admin%20Role%20for%20EC2%20with%20AdminAccess%20permissions.png)            |
| 2    | The over-permissive `policy-bad.json` granting `iam:PassRole` on AdminRole | ![Bad Policy](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/IAM%20Privilege%20Escalation/screenshots/2%20Create%20policy-bad%20which%20gives%20pass%20role%20privileges%20in%20IAM%20and%20lambda%20creation.png)           |
| 3    | IAM user created with the bad policy and CLI access                        | ![MaliciousUser](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/IAM%20Privilege%20Escalation/screenshots/3%20Create%20user%20giving%20them%20the%20over%20provisioned%20credentials%20and%20CLI%20access.png)       |
| 4    | Dummy Lambda zipped and ready to deploy                                    | ![LambdaZip](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/IAM%20Privilege%20Escalation/screenshots/4%20Create%20a%20basic%20lambda%20function%20and%20zip%20it%20so%20I%20can%20attach%20it%20through%20the%20CLI%20as%20my%20MaliciousUser.png)            |
| 5    | Lambda function creation via CLI as MaliciousUser                          | ![CreateLambda](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/IAM%20Privilege%20Escalation/screenshots/5%20From%20my%20host%20machine%20I%20connect%20to%20the%20CLI%2C%20and%20upload%20my%20function%20as%20a%20lambda%20function.png)      |
| 6    | Lambda invoke failure due to missing `lambda:InvokeFunction` permission    | ![InvokeFail](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/IAM%20Privilege%20Escalation/screenshots/6WHENI~1.PNG)  |
| 7    | Defense in depth saves the day — least privilege in action                 | ![DefenseInDepth](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/IAM%20Privilege%20Escalation/screenshots/7BUTIW~1.PNG) |


---

## 📁 Artifacts

Artifacts in this repo:

- [`policy-bad.json`](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/IAM%20Privilege%20Escalation/artifacts/policy-bad.json) — The risky IAM policy with PassRole abuse
- [`invoke-policy.json`](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/IAM%20Privilege%20Escalation/artifacts/invoke-policy.json) — The minimal inline policy we tried to attach but didn’t have permissions for
- [`lambda_function.py`](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/IAM%20Privilege%20Escalation/artifacts/lambda_function.py) — The dummy Lambda function code used in the lab

---

## 💡 Lessons Learned
- `iam:PassRole` is dangerous when combined with overly permissive role targets — attackers can escalate privileges easily
- Creating resources is not the same as executing them: Even with `lambda:CreateFunction`, invocation requires additional permissions
- Defense in depth matters: Missing permissions elsewhere prevented full compromise, illustrating layered security controls
- Least privilege is your friend: Always restrict `PassRole` resources and add conditions to limit which roles can be passed
- Detection & remediation: Use IAM Access Analyzer and CloudTrail to find and fix overly broad policies

---

# 🔚 Summary
In this lab, we saw how one seemingly small misconfiguration — granting iam:PassRole too broadly — can open a door to privilege escalation, allowing a user to create privileged resources like Lambda functions. But, thanks to layered IAM policies and least privilege, the attacker couldn’t fully exploit this to invoke the function and run arbitrary code.

It’s a great reminder that no single control is perfect, but defense in depth and careful permission scoping are your best friends when it comes to cloud security.
