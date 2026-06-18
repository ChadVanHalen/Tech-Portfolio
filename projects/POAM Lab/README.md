# Vulnerability Management Lab – Nessus Scanning & POA&M Tracking

This lab demonstrates the full vulnerability management lifecycle: scanning a vulnerable target (Metasploitable 2) with Nessus, documenting findings in a POA&M spreadsheet, and tracking remediation efforts. The real value is not just running a scan but understanding how to operationalize the results.

## Objectives

- Configure Nessus Essentials to scan a deliberately vulnerable target (Metasploitable 2)
- Scan an EC2 instance, Proxmox host, and other lab assets
- Identify critical and high-severity vulnerabilities
- Create a POA&M spreadsheet to document findings
- Attempt remediation and track status through closure or risk acceptance

## Architecture Overview

| Component | Purpose |
| --------- | ------- |
| Proxmox VE | Hosts Metasploitable 2 VM and other lab containers |
| Metasploitable 2 | Deliberately vulnerable Ubuntu 8.04 VM used as scan target |
| AWS EC2 Instance | Cloud-based target to demonstrate scanning in AWS |
| Nessus Essentials | Vulnerability scanner (free version, limited to 5 IPs) |
| POA&M Spreadsheet | Tracks vulnerabilities, status, target dates, and ticket numbers |

## Scan Results Summary

| Host | Critical | High | Medium | Low | Total |
| ---- | -------- | ---- | ------ | --- | ----- |
| Metasploitable 2 | 13 | 11 | 41 | 13 | 78 |
| AWS EC2 (Ubuntu) | 0 | 0 | 0 | 0 | 0 |
| Proxmox Host | 0 | 1 | 1 | 0 | 2 |
| Proxmox Container 101 | 0 | 0 | 0 | 1 | 1 |
| Proxmox Container 103 | 0 | 0 | 0 | 1 | 1 |

### Selected Vulnerabilities for POA&M Tracking

| # | Vulnerability | CVSS | Host | Status |
| - | ------------- | ---- | ---- | ------ |
| 1 | Canonical Ubuntu Linux SEoL 8.04 | 10.0 | Metasploitable | In Progress |
| 2 | VNC Server Password "password" | 10.0 | Metasploitable | In Progress |
| 3 | Apache Tomcat SEoL <=5.5 | 10.0 | Metasploitable | New |

## Remediation Attempts

### Canonical Ubuntu Linux SEoL 8.04

- **Attempted Fix**: `sudo apt-get update && sudo apt-get upgrade -y`
- **Result**: Failed. Repositories for Ubuntu 8.04 are no longer available.
- **Outcome**: Documented as Risk Accepted. System is a non-production lab environment and will be decommissioned.

### VNC Server Password "password"

- **Fix**: Not technically feasible without replacing the VNC server.
- **Outcome**: Documented as Risk Accepted. Lab environment isolated from production.

## Visual Proof & Artifacts

| Step | Description | Screenshot |
| ---- | ----------- | ---------- |
| 1 | Configuring scan targets (Metasploitable IP, EC2 IP, Proxmox host) | [screenshot](https://github.com/ChadVanHalen/Tech-Portfolio/blob/95777e4c85cd882ad942188dc2189a1753a4bb8b/projects/POAM%20Lab/artifacts/Network%20Scan%20config.png) |
| 2 | Scan results showing critical findings on Metasploitable | [screenshot](https://github.com/ChadVanHalen/Tech-Portfolio/blob/95777e4c85cd882ad942188dc2189a1753a4bb8b/projects/POAM%20Lab/artifacts/Nessus%20Results.png) |
| 3 | POA&M spreadsheet with tracked findings | [screenshot](https://github.com/ChadVanHalen/Tech-Portfolio/blob/95777e4c85cd882ad942188dc2189a1753a4bb8b/projects/POAM%20Lab/artifacts/Network%20Scans%202026.06.16.png) |

## Troubleshooting & Lessons Learned

| Issue | Root Cause | Fix |
| ----- | ---------- | --- |
| VM would not boot with SCSI error | Metasploitable kernel too old for VirtIO | Changed SCSI controller to "Default (LSI 53C895A)" |
| No IPv4 address on VM | Network interface not activated at boot | Ran `sudo ifconfig eth0 up && sudo dhclient eth0` |
| Unable to generate CSV report in Nessus | Free version limitation | Documented findings manually in POA&M spreadsheet |
| apt-get update failed on Ubuntu 8.04 | Repositories no longer available | Documented as Risk Accepted |
| Docker permission denied on EC2 | User not in docker group | Added ec2-user to docker group |

## Artifacts

- [`Networks Scans 2026.06.16.xlsx`](https://github.com/ChadVanHalen/Tech-Portfolio/blob/95777e4c85cd882ad942188dc2189a1753a4bb8b/projects/POAM%20Lab/artifacts/Network%20Scans%202026.06.16.xlsx)

## Summary

This lab demonstrated the full vulnerability management lifecycle: scanning a target, identifying critical findings, documenting them in a POA&M tracker, attempting remediation, and tracking status through closure or risk acceptance. The process is not about running a scan and moving on but about turning findings into actionable remediation plans and tracking them to completion.

The real win is not the scan results but the ability to take a raw Nessus output and turn it into a structured, trackable program that can be presented to stakeholders and auditors.
