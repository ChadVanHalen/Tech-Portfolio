# Threat Detection & Continuous Monitoring

## Project Overview
Implementation of continuous monitoring and incident detection capabilities following NIST 800-53 and CIS Benchmark guidelines, validating both detection and response workflows in a cost-optimized sandbox environment.

## Technical Specifications
- Cloud Platform: AWS
- Services Used:
  - Core: GuardDuty, VPC Flow Logs
  - Supporting: AWS Config, CloudTrail
- Key Components:
  - Multi-layer threat detection (API, network, malware)
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
- **Unauthorized API Calls**
  - Command:
    ```bash
    aws iam list-users --region us-east-2
    ```
  - Expected detection: `UnauthorizedAccess:IAMUser/InstanceCredentialExfiltration`

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%203/7%20From%20my%20app%20server%20I%20run%20a%20few%20API%20calls%20that%20should%20trigger%20findings%20in%20GuardDuty.png)

- **Internal Port Scanning**
  - Command:
    ```bash
    for port in {22,80,443}; do timeout 1 bash -c "echo >/dev/tcp/10.0.1.15/$port"; done
    ```
  - Expected detection: `Recon:EC2/Portscan`

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%203/8%20From%20my%20jumpbox%20to%20my%20private%20server%20I%20run%20some%20ncat%20port%20scans.png)

- **Malware Detection Test**
  - Command:
    ```bash
    echo 'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-TEST-FILE!$H+H*' > /tmp/eicar.txt
    ```
  - Expected detection: `Backdoor:EC2/FileHash.B*`

#### Sandbox Limitations
Due to free-tier limitations, certain findings were not triggered or delayed. For demonstration, AWS sample findings were used:
```bash
aws guardduty create-sample-findings --finding-types "UnauthorizedAccess:IAMUser/InstanceCredentialExfiltration.OutsideAWS"
```

## Key Takeaways
- Even in limited environments, GuardDuty provides deep detection
- Sample findings are a viable tool for validation

---

### ▶️ Further Reading: Automated Response Demonstration

For a detailed walk-through of a simulated GuardDuty finding and automated EC2 quarantine, see [Step 6 – Incident Response Automation & Simulation](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/steps/6%20Simulated%20Detection%20Response/README.md).
