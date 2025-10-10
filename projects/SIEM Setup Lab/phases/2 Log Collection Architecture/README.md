# Log Collection Architecture

## Project Overview
This phase demonstrates the deployment and configuration of Splunk Universal Forwarders for centralized log collection. The implementation establishes secure log ingestion from remote systems, creating a foundation for enterprise-scale security monitoring and threat detection.

## Technical Specifications
- Forwarder Platform: Splunk Universal Forwarder
- Source Systems: Ubuntu Server 22.04 LTS
- Key Components: Universal Forwarder, inputs/outputs configuration, firewall rules

# Implementation Walkthrough

## 1. Universal Forwarder Deployment
Installed and configured Splunk Universal Forwarder on secondary Linux system:
```bash
wget -O splunkforwarder-package.deb "https://download.splunk.com/..."
sudo dpkg -i splunkforwarder-package.deb
```

![](https://i.postimg.cc/4yGF9cN8/10-Installing-Universal-Forwarder-on-2nd-Linux-VM.png)

### Compliance Alignment:
- NIST 800-53 AU-12 (Audit Generation)
- CIS Controls 6.1 (Audit Log Management)

## 2. Forwarder Configuration Architecture
Created configuration files to define log collection and forwarding behavior:
```bash
sudo touch /opt/splunkforwarder/etc/system/local/inputs.conf
sudo touch /opt/splunkforwarder/etc/system/local/outputs.conf
```
![](https://i.postimg.cc/dVQPfbFW/11-Creating-conf-file-in-CLI.png)

Configured input monitoring for authentication logs:
```bash
# inputs.conf
[monitor:///var/log/auth.log]
sourcetype = linux_secure
index = test
```

![](https://i.postimg.cc/2yNg7JT7/12-Editing-conf-file-within-nano.png)

### Compliance Alignment:
- NIST 800-53 AU-3 (Content of Audit Records)
- GDPR Article 30 (Records of Processing Activities)

## 3. Centralized Index Configuration
Created dedicated test index in Splunk Enterprise for log ingestion:
- Index Name: test
- Data Retention: Appropriate for testing phase
- Access Controls: Restricted to security team

![](https://i.postimg.cc/522Tg85T/13-Creating-test-index-in-Splunk.png)

### Compliance Alignment:
- NIST 800-53 AU-9 (Protection of Audit Information)
- GDPR Article 5(1)(f) (Integrity and Confidentiality)

## 4. Log Source Analysis and Validation
Verified log source integrity and content structure:
```bash
sudo cat /var/log/auth.log
# Verified log format contains: timestamps, source IPs, usernames, success/failure status
```

![](https://i.postimg.cc/9fvkcK3H/14-Focusing-on-forwarder-VM-auth-log-using-cat-to-read-logpng.png)

### Compliance Alignment:
- NIST 800-53 AU-3 (Content of Audit Records)
- CIS Controls 6.2 (Audit Log Reliability)

## 5. Network Security Configuration
Implemented firewall rules to secure Splunk communication:
```bash
sudo ufw allow 8000/tcp    # Splunk Web Interface
sudo ufw allow 8089/tcp    # Splunk Management
sudo ufw allow 9997/tcp    # Splunk Forwarding
sudo ufw allow ssh         # Administrative Access
sudo ufw enable
```

![](https://i.postimg.cc/rFQYDK6J/18-Starting-firewall-setting-ACL-allowing-Splunk-ports-and-SSH-ports.png)

### Compliance Alignment:
- NIST 800-53 SC-7 (Boundary Protection)
- CIS Controls 9 (Network Ports and Services Management)

## 6. Output Configuration for Centralized Forwarding
Configured secure communication to Splunk indexer:
```bash
# outputs.conf
[tcpout]
defaultGroup = primary_indexers
[tcpout:primary_indexers]
server = splunkmachine:9997
```

![](https://i.postimg.cc/Wp0B1NbW/17-Nano-outputs-conf.png)

### Compliance Alignment:
- NIST 800-53 SC-8 (Transmission Confidentiality)
- GDPR Article 32 (Security of Processing)

## 7. Data Ingestion Validation
Verified successful log collection and indexing:
- Confirmed real-time data flow from forwarder to indexer
- Validated log parsing and field extraction
- Tested search capabilities across ingested data

![](https://i.postimg.cc/cCckMJvd/19-Searching-index-on-Splunk-before-full-data-population.png)

### Compliance Alignment:
- NIST 800-53 AU-6 (Audit Review, Analysis, and Reporting)
- CIS Controls 6.3 (Audit Log Monitoring)

# Key Takeaways
- Successfully established secure log collection pipeline from multiple systems
- Implemented proper network segmentation and access controls for log forwarding
- Validated end-to-end log ingestion with proper parsing and indexing
- Demonstrated scalable architecture for enterprise security monitoring

---

▶️ Continue to [Phase 3 – Detection Engineering](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/SIEM%20Setup%20Lab/phases/3%20Detection%20Engineering/README.md) to develop custom security detection rules and alerting.

