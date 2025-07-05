# AWS VPC Data Protection & Encryption Implementation

## Project Overview
Implementation of encryption controls for data at rest and in transit, aligned with NIST 800-171 (Protecting CUI) and CIS AWS Foundations Benchmark. Validated through hands-on testing with AWS-native services and open-source tools.

## Technical Specifications
- Cloud Platform: AWS
- Services Used:
  - Core: EBS Default Encryption, S3 Bucket Encryption, Let's Encrypt (self-sign fallback)
  - Supporting: AWS KMS, nginx
- Key Components:
  - Automated EBS volume encryption
  - S3 server-side encryption enfrocement
  - TLS 1.2+ termination on EC2 instances

# Implementation Walkthrough
## 1. EBS Default Encryption Enforcement
Enabled encryption-by-default for all new EBS volumes using AWS KMS

### Process
1. Verified default state: Confirmed EBS encryption was disabled

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%204/1%20Showing%20by%20default%20EBS%20encryption%20is%20off.png)

2. Enabled default encryption

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%204/2%20EBS%20on%20by%20default.png)

3. Validation

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%204/3%20Confirmed%20that%20creating%20a%20new%20instance%20shows%20volume%20has%20encryption%20by%20default.png)

### Compliance Alignment:
- NIST 800-171 3.13.16: Encryption at rest
- CIS AWS 2.2.1: EBS default encryption

## S3 Bucket Encryption Enforcement
Configured server-side encryption (SSE-KMS) for all objects in a demo S3 bucket

### Process
1. Created bucket with default encryption

2. Tested enforcement by uploading test.txt to bucket and verifying encryption status in object's properties

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%204/4IUPLO~1.PNG)

### Compliance Alignment
- NIST 800-53 SC-28: Protection of information at rest
- CIS AWS 2.1.1: S3 bucket encryption

## TLS Implementation on EC2 (HTTPS)
Attempted Let's Encrypt certificate employment, with self-signed fallback for demonstration

### Process
1. Let's Encrypt attempt:
   - Installed Certbot on nginx and attempted to install cert on public AWS DNS name
   - Result: Expected failure due to Let's Encrypt's policy against AWS public DNS names

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%204/6%20I%20install%20certbot.png)
![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%204/7IRUNT~1.PNG)

2. Self-Signed Certificate Fallback
   - Generated a self-signed cert
   - Configured nginx to use this cert
   - Verified HTTPS access (with expected browser warning due to the self signed certificate use)

![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%204/8DESPI~1.PNG)
![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20VPC%20Hardening%20NIST%20CIS%20Compliance/images/Step%204/9%20Confirm%20HTTPS%20is%20enabled%20on%20the%20public%20server.png)

### Compliance Alignment
- NIST 800-53 SC-8: Transmission confidentiality
- CIS AWS 2.3: TLS-enabled connections

## Validation and Lessons Learned
### Working Components
- EBS Encryption: Confirmed new volumes encrypt automatically
- S3 Encryption: Verified object-level encryption enforcement for data-at-rest
- TLS Termination: Self-signed certs provided funcitonal HTTPS for data-in-transit

### Sandbox Limitations
- Let's Encrypt restricitons
  - Cannot issue certs for AWS public DNS names
  - In production this would be mitigated through a custom domain
- Self Signed Certs
  - Browser warnings acceptable for lab demonstration, but production would require a trusted CA
