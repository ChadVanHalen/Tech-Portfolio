# SIEM Infrastructure & Hardening

## Project Overview
This phase demonstrates the secure deployment and configuration of Splunk Enterprise on Ubuntu Server, following security best practices for SIEM infrastructure. The implementation includes service hardening, user permission management, and secure access controls to establish a foundation for enterprise security monitoring.

## Technical Specifications
- SIEM Platform: Splunk Enterprise
- Operating System: Ubuntu Server 22.04 LTS
- Key Components: Splunk Enterprise, Linux system services, firewall configuration

# Implementation Walkthrough

## 1. Secure Splunk Installation
Downloaded and installed Splunk Enterprise on Ubuntu Server with security-focused configuration:
 ```bash
    wget -O splunk-package.deb "https://download.splunk.com/..."
    sudo dpkg -i splunk-package.deb
```
![](https://i.postimg.cc/Pxvk41HT/1-Ubuntu-VM-Splunk.png)

Implemented secure service configuration:
- Enabled Splunk to start on boot for service continuity
- Configured proper ownership and permissions
- Established secure default settings

![](https://i.postimg.cc/yxqCrW69/2-Splunk-boot-on-start.png)

### Compliance Alignment
- NIST 800-53 CM-6 (Configuration Settings)
- CIS Controls 4 (Controlled Access Based on Need to Know)
- GDPR Article 32 (Security of Processing)
