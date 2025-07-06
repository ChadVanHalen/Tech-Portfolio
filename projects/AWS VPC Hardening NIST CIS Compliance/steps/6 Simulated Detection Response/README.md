# AWS GuardDuty SSH Brute Force Simulation & Automated Quarantine
This section demonstrates a simulated intrusion (SSH brute force) and automated remediation using GuardDuty, EventBridge, and Lambda. Although AWS sandbox environments do not allow real EC2 association with sample findings, a realistic workflow was constructed to show production-ready automation in action.

## Technical Specifications
- Cloud Platform: AWS
- Services Used:
  - Core: GuardDuty, EventBridge, Lambda
  - Supporting: EC2, Security Groups
- Key Components:
  - Simulated GuardDuty Finding (SSH Brute Force)
  - Lambda-driven EC2 Quarantine Mechanism
  - Manual payload simulation to validate automation flow

# Implementation Walkthrough
## 1. Architecture Overview
- GuardDuty: Monitors for brute force SSH attempts
- EventBridge: Captures matching GuardDuty findings, then triggers an action
- Lambda: Quarantines EC2 instance and tags it as compromised

## 2. GuardDuty & EventBridge Configuration
### GuardDuty Status 
- Verified GuardDuty is enabled
- Runtime protections active (S3, EC2, etc)

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%205/5%20GuardDuty%20on%20and%20active.png)

### EventBridge Rule Setup
Created a rule matching SSH brute force findings:
```json
{
  "source": ["aws.guardduty"],
  "detail-type": ["GuardDuty Finding"],
  "detail": {
    "type": ["UnauthorizedAccess:EC2/SSHBruteForce"]
  }
}
```

## 3. Lambda Function: Quarantine Logic
Lambda configured to:
- Swap instance's security group to "guardduty-quarantine-sg
- Tag the instance with the finding type
```python
import boto3

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    instance_id = event['detail']['resource']['instanceDetails']['instanceId']

    ec2.modify_instance_attribute(
        InstanceId=instance_id,
        Groups=['sg-04859a1bc6f433a05']  # Quarantine SG
    )
    ec2.create_tags(
        Resources=[instance_id],
        Tags=[{'Key': 'Compromised', 'Value': event['detail']['type']}]
    )

    return {"status": "Success"}
```

## 4. Simulating the Findings & Triggering Quarantine
Since actual brute force attempts failed to trigger GuardDuty in sandbox, the following simulatino was performed:

1. Create Sample Findings (CLI):
```bash
aws guardduty create-sample-findings \
  --detector-id <your-detector-id> \
  --finding-types "UnauthorizedAccess:EC2/SSHBruteForce"
```
*GuardDuty sample findings cannot be tied to a specific EC2 instance*

2. Manual Trigger of Lambda
To simulate full end-to-end functionality, a test event payload was manually injected with a real EC2 instance ID

```json
{
  "detail": {
    "type": "UnauthorizedAccess:EC2/SSHBruteForce",
    "resource": {
      "resourceType": "Instance",
      "instanceDetails": {
        "instanceId": "i-0abc1234def5678gh"
      }
    }
  }
}
```
## 5. Result: EC2 Quarantine Verified
- EC2 instance's security group was immediately replaced with quarantine group
- Tag "Compromised: UnauthorizedAccess:EC2/SSHBruteForce" successfully added
- Instance effectively isolated from all network access

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%205/9%20Instance%20settings%20pre%20quarantine.png)
![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%205/13%20As%20we%20can%20see%2C%20the%20instance%20has%20been%20quarantined.png)
![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%205/14%20EC2%20compromised%20tag.png)

## Validation & Lessons Learned
### Automation Success
- Lambda function logic was fully functional
- GuardDuty integration with EventBridge confirmed with TestEvents

### Sandbox Limitations
- GuardDuty findings could not be tied to real EC2 resources
- EventBridge did not auto-trigger on sample findings

### Production Recommendations
- Implement fallback: CloudWatch alarm on failed EventBridge deliveries
- Consider backup workflow using AWS Config or CloudTrail findings for assurance
