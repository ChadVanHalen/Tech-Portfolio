# AWS VPC Monitoring with GuardDuty & Attack Simulation

## Project Overview
Implementation of continuous monitoring and incident detection capabilities following NIST 800-53 and CIS Benchmark guidelines, validating both detection and response workflows in a cost-optimized sandbox environment.
## Technical Specifications
- Cloud Platform: AWS
- Services Used:
  - Core: GuardDuty, VPC Flow Logs
  - Supporting: AWS Config, CloudTrail
- Key Components:
  - Multi-layer threat detection (API, network, malware)
  - Automated instance quarantine system
  - Compliance monitor framework

# Implementation Walkthrough
## 1. GuardDuty Baseline Configuration
Enabled enterprise-grade threat detection with:
- EC2 Runtime Monitoring: Malware scanning and behavioral analysis
- S3 Protection: Data event logging for sensitive buckets
- CloudTrail integration: Multi-region API monitoring

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%203/2%20Enable%20EC2%20Malware%20Scans%20in%20GuardDuty.png)

### Compliance Alignment:
- NIST SI-4: System monitoring
- CIS 4.1: GuardDuty enablement

## 2. Attack Simulation Methodology
### Real Attack Attempts
Conducted three attack scenarios:
- Unauthorized API Calls
  - aws iam list-users --region us-east-2
    - Expected detection: UnauthorizedAccess:IAMUser/InstanceCredentialExfiltration

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%203/7%20From%20my%20app%20server%20I%20run%20a%20few%20API%20calls%20that%20should%20trigger%20findings%20in%20GuardDuty.png)

- Internal Port Scanning
  - for port in {22,80,443}; do timeout 1 bash -c "echo >/dev/tcp/10.0.1.15/$port"; done
    - Expected detection: Recon:EC2/Portscan

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%203/8%20From%20my%20jumpbox%20to%20my%20private%20server%20I%20run%20some%20ncat%20port%20scans.png)

- Malware Detection Test
  - echo 'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-TEST-FILE!$H+H*' > /tmp/eicar.txt
    - Expected detection: Backdoor:EC2/FileHash.B*

#### Sandbox Limitations:
Due to my free tier of AWS attack findings were either not being properly discovered or the detection was delayed 6+ hours.
For the purposes of the project I opted to use AWS's own sample findings for more reliable and quick findings
- aws guardduty create-sample-findings --finding-types "UnauthorizedAccess:IAMUser/InstanceCredentialExfiltration.OutsideAWS"

## Automated Remediation Framework
Configured EventBridge rules to trigger on GuardDuty findings:
- Low Severity: SNS alert to security team
  - This was implemented back in [Step 2](https://github.com/ChadVanHalen/Tech-Portfolio/tree/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/steps/2%20IAM%20Hardening#4-continuous-monitoring-with-aws-config)
- High Severity:
  - Isolate EC2 instance via Lambda
  - Quarantine S3 buckets

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%203/9%20Create%20quarantine%20security%20group%20-%20no%20inbound%20outbound%20rules%20for%20isolation.png)

### Validated Working Components
Lambda Quarantine Function:
- Successfully isolates instances when manually triggered
- Implements security group modification and forensic tagging

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%203/10%20Lambda%20function%20that%20will%20change%20the%20instance%20security%20group%20to%20the%20quarantined%20one%20when%20triggered.png)

### Sandbox Limitations
EventBridge Triggering Issues:
- Sample GuardDuty findings not consistently delviered to Lambda
- Verified the architecture works with:
  - Manual Lambda invocation (immediate response)
  - Direct API calls to EC2

Production Considerations:
If these issues were found in production these would be the steps I would take as mitigations until the problem is corrected
- SNS notifications for missed findings, allowing for manual remediation
- CloudWatch alarms for EventBridge delivery metrics, allowing for manual remediation

### Compliance Alignment
- NIST IR-4: Incident handling
- CIS 4.5: Automated response

## Validation & Lessons Learned
### Implementation Notes:
While AWS sandbox environments showed limitation with sample finging delivery:
- All components work when properly triggered
- Documented fallback mechanisms ensure reliability

### Lessons Learned
- Always validate automation through manual triggers first
- AWS sandboxes/free tiers may not replicate all production behaviors
