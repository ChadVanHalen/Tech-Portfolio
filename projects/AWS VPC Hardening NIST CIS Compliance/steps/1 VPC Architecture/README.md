# AWS - Multisegmented VPC Creation and Hardening

## Project Overview
This project demonstrates the creation of a secure, multi-tier VPC architecture in AWS following NIST 800-53 and CIS Benchmark guidelines. The implementation includes network segmentation, access controls, and monitoring to meet enterprise security standards.

## Technical Specifications
- Cloud Platform: AWS
- Operating System: Amazon Linux 2023
- Key Components: VPC, EC2, S3, FlowLogs

# Implementation Walkthrough

## 1. VPC Architecture Design
Created a VPC with three distinct subnets:
- Public Subnet: For bastion/jumpbox access
- Private Subnet: For internal application servers
- Isolated Subnet: For highly restricted resources

![](https://i.postimg.cc/jSkrmj39/01-Create-VPC-within-AWS-with-a-single-public-subnet-and-2-private-subnets.png)

### Compliance Alignment:
- NIST 800-53 AC-4 (Information Flow Enforcement)
- CIS AWS Benchmark 4.1-4.3 (Network ACLs)

## 2. Secure Jumpbox Configuration
Deployed a bastion host in the public subnet with:
- Restricted SSH access (single IP whitelist)
- Key-based authentication
- Implicit deny-all NACL policy

![](https://i.postimg.cc/L5RdLghq/03-Creating-a-jumpbox-server-using-security-controls-to-only-allow-SSH-via-my-IP.png)

### Compliance Alignment:
- NIST 800-53 IA-2 (Identification and Authentication)
- CIS AWS Benchmark 1.1-1.5 (IAM Controls)

## 3. Private Server Deployment
Configured an application server in the private subnet with:
- NACL rules restricting access to jumpbox only
- No public IP assignment
- Verification of network isolation

![](https://i.postimg.cc/1tDh8rRh/05-Creating-the-app-server-that-will-sit-in-the-private-subnet-only-accessible-by-the-jumpbox.png)

### Compliance Alignment:
- NIST 800-53 SC-7 (Boundary Protection)

## 4. Security Validation
Performed comprehensive testing including:
- SSH access verification (approved and blocked attempts)
- HTTP/S service blocking (temporary measure)
- Cross-subnet access validation

![](https://i.postimg.cc/25c2FcJJ/09-Checking-my-security-group-rule-by-using-a-VPN-to-change-my-public-IP.png)

## 5. Monitoring Implementation
Configured VPC Flow Logs with:
- Secure S3 bucket storage (SSE-S3 encryption)
- Restricted IAM permissions (least privilege)
- 7-day lifecycle policy (for cost optimization)

![](https://i.postimg.cc/261THdN5/12-Creating-an-S3-bucket-to-store-flow-logs-on-the-VPC.png)

### Compliance Alignment:
- NIST 800-53 AU-9 (Audit Logging)
- NIST 800-53 SC-28 (Data-at-Rest Protection)
- CIS AWS Benchmark 3.1-3.14 (Monitoring)

# Key Takeaways
- Successfully implemented enterprise-grade network segmentation
- Demonstrated practical application of NIST/CIS controls
- Established foundation for subsequent security hardening phases
