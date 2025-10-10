# SIEM Deployment & Detection Engineering Lab

## 🔍 Project Overview
This hands-on project demonstrates end-to-end deployment and configuration of a Security Information and Event Management (SIEM) system using Splunk Enterprise. The lab covers infrastructure setup, log ingestion, detection rule creation, and dashboard development to monitor for security threats like brute-force attacks.

---

## 🎯 Key Capabilities Demonstrated
- SIEM Infrastructure Deployment – Installation and hardening of Splunk Enterprise on Linux
- Log Collection & Normalization – Configuration of Universal Forwarders for centralized log management
- Threat Detection Engineering – Creation of custom detection rules for SSH brute-force attacks
- Security Monitoring – Dashboard creation for real-time security visibility
- System Hardening – Security-focused configuration following principle of least privilege

---

## 📁 Implementation Phases
| Phase | Title | Description |
|------|-------|-------------|
| [▶ Phase 1](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/SIEM%20Setup%20Lab/phases/1%20SIEM%20Infrastructure/README.md) | **SIEM Infrastructure & Hardening** | Secure installation of Splunk Enterprise on Ubuntu Server with proper user permissions and service configuration |
| [▶ Phase 2](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/SIEM%20Setup%20Lab/phases/2%20Log%20Collection%20Architecture/README.md) | **Log Collection Architecture** | Deployment of Universal Forwarder with input/output configuration for auth.log monitoring |
| [▶ Phase 3](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/SIEM%20Setup%20Lab/phases/3%20Detection%20Engineering/README.md) | **Detection Engineering** | Development and refinement of SSH brute-force detection rules and alerting |
| [▶ Phase 4](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/SIEM%20Setup%20Lab/phases/4%20Security%20Operations/README.md) | **Security Operation** | Creation of operational dashboards and visualization of attack patterns |

---

## 🛡️ Security Controls & Compliance Alignment
| Framework | Control Family | Implementation in Lab |
|------|-------|-------------|
| **NIST 800-53** | **AU-3: Content of Audit Records** | Centralized collection of SSH authentication logs with timestamps, source IPs, and success/failure status |
| **NIST 800-53** | **AU-6: Audit Review, Analysis, and Reporting** | Custom dashboards and alerts for failed SSH attempts with visualization of attack patterns over time |
| **NIST 800-53** | **AU-12: Audit Generation** | Configuration of Universal Forwarders to ensure complete audit record collection |
| **CIS Controls** | **CIS 6: Audit Log Management** | Centralized log management with proper retention and monitoring capabilities |
| **CIS Controls** | **CIS 8: Audit Log Management** | Monitoring and analysis of audit events for malicious activity detection |
| **Operational Security** | **Least Privilege** | Splunk service configured to run under dedicated non-root user account |
| **Operational Security** | **Network Security** | Firewall configuration limiting Splunk ports (8000, 8089, 9997) to authorized systems only |

---

## 🔧 Technical Architecture
### Components Deployed
- Splunk Enterprise (Indexer & Search Head)
- Splunk Universal Forwarder (Log collection agent)
- Ubuntu Server 22.04 LTS (Security-focused configuration)
- SSH Service (Attack simulation target)

### Security Hardening Implemented
- Service account isolation (non-root Splunk user)
- Restricted network access via firewall rules
- Secure inter-component communication
- Log integrity preservation

### Detection Capabilities
- SSH Brute-force Detection: Real-time alerting on failed authentication attempts
- Attack Pattern Analysis: Visualization of attack sources and frequency
- Operational Dashboards: Security team visibility into authentication events

---

## 📈 Outcomes & Validation
### Detection Effectiveness
- Successfully detected and visualized SSH brute-force attacks
- Reduced false positives through iterative detection rule refinement
- Achieved real-time alerting capability for security incidents

### Operational Readiness
- Documented deployment procedures for enterprise environments
- Established monitoring and maintenance procedures
- Created reusable detection rules and dashboard templates

### Skills Demonstrated
- SIEM Engineering: End-to-end deployment and configuration
- Detection Engineering: Custom rule development and optimization
- Security Operations: Dashboard creation and threat visualization
- Linux Administration: Service configuration and security hardening

---

## 📌 Professional Notes
- Enterprise-Ready: Architecture follows security best practices for production environments
- Documented Process: Each phase includes detailed implementation steps and screenshots
- Real-World Validation: Detection rules tested against simulated attack patterns
- Scalable Design: Configuration can be extended to additional data sources and use cases
