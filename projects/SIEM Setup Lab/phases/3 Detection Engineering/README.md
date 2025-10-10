# Detection Engineering

## Project Overview
This phase focuses on developing and refining security detection rules for identifying malicious activity, specifically SSH brute-force attacks. The implementation includes creating custom search queries, testing detection effectiveness, and optimizing alerts to reduce false positives while maintaining high detection fidelity.

## Technical Specifications
- Detection Platform: Splunk Enterprise
- Data Source: Linux auth.log via Universal Forwarder
- Key Components: SPL queries, alerts, dashboards, correlation rules

# Implementation Walkthrough

## 1. Attack Simulation and Baseline Data Collection
Generated realistic attack patterns for detection development:
```bash
# Simulated failed SSH attempts from multiple sources
ssh user@forwarder # with incorrect credentials
ssh admin@forwarder # with incorrect credentials
```

![](https://i.postimg.cc/dtBgG5CG/20-Incorrect-login-on-Linux.png)
![](https://i.postimg.cc/c4ZVKpvs/21-Fake-SSH-attempt.png)

### Compliance Alignment:
- NIST 800-53 RA-5 (Vulnerability Monitoring)
- CIS Controls 7 (Continuous Vulnerability Management)

## 2. Initial Detection Rule Development
Created first-generation detection rules using SPL (Search Processing Language):
```bash
# Initial attempt using event codes
index=test EventCode=4106
```

Discovered limitations with event-code based approach:
- Event codes proved to be sequential rather than categorical
- Failed to capture all SSH failure variations
- Limited scalability for new attack patterns

![](https://i.postimg.cc/N0yVqYzx/22-Built-failed-SSH-attempt-as-dashboard-incorrectly.png)

### Compliance Alignment:
- NIST 800-53 SI-4 (System Monitoring)
- GDPR Article 33 (Notification of Personal Data Breach)

## 3. Advanced Detection Rule Refinement
Iterated and improved detection logic based on initial testing:
```bash
# Refined detection using process and failure analysis
index=test sourcetype=linux_secure "sshd" "failed"
| stats count by src_ip, user
| where count > 5
```

Key improvements implemented:
- Process-based filtering ("sshd")
- Failure pattern matching ("failed")
- Threshold-based alerting (>5 attempts)
- Source IP and user correlation

![](https://i.postimg.cc/137Tj4Jt/24-SSH-attempts-after-alerts-and-reports.png)

### Compliance Alignment:
- NIST 800-53 AU-6 (Audit Review, Analysis, and Reporting)
- CIS Controls 6.6 (Audit Log Monitoring and Analysis)

## 4. Alert Configuration and Notification Setup
Configured operational alerts for security team notification:
- Alert Threshold: 5+ failed SSH attempts from single source
- Trigger Condition: Real-time detection
- Notification Method: Splunk alert actions
- Response Workflow: Integrated with incident response procedures

![](https://i.postimg.cc/4dVSyPZ7/23-Bad-SSH-alert-incorrectly.png)

### Compliance Alignment:
- NIST 800-53 IR-4 (Incident Handling)
- CIS Controls 19 (Incident Response Management)

## 5. Detection Validation and Testing
Performed comprehensive testing of detection rules:
- True Positive Validation: Confirmed detection of simulated attacks
- False Positive Analysis: Monitored for legitimate activity triggering alerts
- Performance Impact: Assessed search and indexing load
- Coverage Assessment: Verified detection of varied attack patterns

### Compliance Alignment:
- NIST 800-53 SI-6 (Security Function Verification)
- GDPR Article 32 (Security of Processing)

## 6. Detection Rule Optimization
Fine-tuned detection parameters based on testing results:
- Adjusted threshold levels to balance sensitivity and specificity
- Added time-window constraints to reduce noise
- Implemented source IP reputation considerations
- Added user account risk scoring

### Compliance Alignment:
- NIST 800-53 SI-4 (System Monitoring)
- CIS Controls 8 (Malware Defenses)

## 7. Operational Integration
Established procedures for security team utilization:
- Documented detection logic and tuning parameters
- Created escalation procedures for confirmed incidents
- Established maintenance schedule for rule updates
- Integrated with overall security monitoring framework

### Compliance Alignment:
- NIST 800-53 IR-4 (Incident Handling)
- GDPR Article 33 (Notification of Personal Data Breach)

# Key Takeaways
- Successfully developed and refined SSH brute-force detection rules through iterative testing
- Transitioned from basic event-code matching to sophisticated process and pattern analysis
- Implemented threshold-based alerting to reduce false positives while maintaining detection efficacy
- Established foundation for scalable detection engineering practices
- Demonstrated practical application of NIST and CIS monitoring controls

---

▶️ Security operations and visualization are documented in [Phase 4 – Security Operations](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/SIEM%20Setup%20Lab/phases/4%20Security%20Operations/README.md) 
