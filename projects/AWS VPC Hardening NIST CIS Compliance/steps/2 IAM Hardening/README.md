# AWS - IAM Hardening with NIST & CIS Compliance

## Project Overview
Implementation of identity and access management controls following NIST 800-53 and CIS Benchmark guidelines. The hardening process includes break-glass admin creation, least-privilege roles, and audit logging to meet enterprise security standards.

## Technical Specifications
- Cloud Platform: AWS
- Services Used: IAM, AWS Config, CloudTrail, EventBridge, SNS
- Key Components:
  - Break-glass admin account
  - EC2 read-only roles
  - Password policy enforcement
  - Real-time security alerts

# Implementation Walkthrough
## 1. Break-Glass Admin Configuration
Created emergency access account with:
- Dedicated IAM user with AdministratorAccess policy
- Virtual MFA device enforcement
- Verified console access restrictions

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%202/1%20-%20Create%20a%20breakglass%20user%2C%20assign%20built%20in%20admin%20access.png)
![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%202/3%20I%20set%20up%20a%20passkey%20through%20my%20host%20computer's%20sign%20in%20as%20the%20MFA%20for%20this%20admin%20account.png)

### Compliance Alignment:
- NIST 800-53 IA-2(1): Multifactor authentication for privileged accounts
- CIS 1.1-1.2: Restrict root account use and enforce MFA

## 2. Password Enforcement Policy
Configured IAMs role for compliance with NIST & CIS password complexity requirements:
- Minimum password length - 14
- Required symbols, numbers, uppercase, and lowercase characters
- Max password age - 90 days

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%202/12IEST~1.PNG)

### Compliance Alignment:
- NIST 800-63B: Password complexity requirements
- CIS 1.5: Credential rotation every 90 days

## 3. EC2 Read-Only Role Implementation
- Created "EC2ReadOnly" role with the "AmazonS3ReadOnlyAccess" policy
- Attached to current test instances
- Verified permission boundaries

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%202/5%20AWS%20EC2%20Read%20Only%20Account%20Created.png)
![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%202/6%20Attaching%20the%20preconfigured%20AWSS3ReadOnlyAccess%20permissions%20to%20it.png)

### Compliance Alignment:
- NIST AC-6: Least privilege principle
- CIS 1.16: Use IAMs roles instead of access keys

## 4. Continuous Monitoring with AWS Config
Enabled three critical rules:
- iam-password-policy
- iam-user-mfa-enabled
- iam-no-inline-policy
Note: Root account falsely flagged as non-compliant (Knwon AWS behavior)

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%202/13%203%20IAMs%20compliance%20rules%20established%20within%20AWS%20Config.png)

### Compliance Alignment:
- NIST AU-6: Audit logging
- CIS 3.1-3.3: Continuous Monitoring

## 5. CloudTrail + EventBridge Alerting
- Created multi-region CloudTrail to S3
- Configured KMS encryption for logs
- Set up EventBridge rule to trigger SNS alerts

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%202/14%20Created%20a%20CloudTrail%20monitor%20for%20changes%20within%20IAMs%2C%20being%20sent%20to%20my%20previously%20created%20S3%20bucket.png)
![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%202/16%20Create%20role%20within%20EventBridge%20to%20trigger%20the%20SNS%20email%20notification%20for%20IAMs%20changes.png)

### Compliance
- NIST SI-4: Real-time monitoring
- CIS 3.6-3.7: Log integrity

## 6. End-to-End Validation
- Created test user via CLI
- Verified:
  - CloudTrail log captured in S3
  - Email alert received via SNS
  - Event details visible in AWS Console

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%202/17AFTE~1.PNG)
![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%202/18%20Email%20notification%20of%20log%20events.png)
![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%202/20%20Parsing%20the%20log%20I%20can%20see%20the%20CreateUser%20event%20was%20captured%20successfully.png)

# Key Takeaways
- Established secure break-glass access procedures with MFA enforcement
- Implemented zero-standing-privilege model for EC2/S3 access
- Automated compliance through AWS Config + CloudTrail + EventBridge
- Real world validation of alerting pipeline
