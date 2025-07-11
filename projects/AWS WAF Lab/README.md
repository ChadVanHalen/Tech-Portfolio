# 🛡️ AWS Web Application Firewalls – Filtering Web Attacks with Firewalls

Yes, writing WAF rules is about as glamorous as watching paint dry—until you realize they don't work like you expected. That’s when the real lesson begins. This lab demonstrates deploying AWS WAF in front of an Apache web app (running on EC2 behind an ALB), using three rule types:
- SQL Injection detection
- Cross-Site Scripting (XSS) detection
- Rate-based blocking

Spoiler: it didn’t work perfectly the first time… and that’s the point.

## 🎯 Objectives

- Host a simple Apache web server on EC2 (same instance as jumpbox for cost reasons — more on that later)
- Create an Application Load Balancer (ALB) as the entry point to the app
- Configure a WAF Web ACL with common web attack protections
- Test detection and blocking using PowerShell + curl-like commands
- Fix what breaks along the way 😅

---

## ⚙️ Architecture Overview

| Component       | Purpose                                                                |
| --------------- | ---------------------------------------------------------------------- |
| EC2 instance    | Hosts Apache web server (doubles as jumpbox – *not* production safe)   |
| ALB             | Publicly exposed; routes HTTP traffic to the EC2 instance              |
| Target Group    | Registers the EC2 instance for health checks and routing               |
| Security Groups | ALB & EC2 configured with proper ingress/egress to handle HTTP traffic |
| WAF Web ACL     | Three rules: SQLi, XSS, and IP rate limiting                           |

> 🧠 Note: In production, your jumpbox and web server should absolutely be separate instances. Here, we're combining them for simplicity and cost reduction under free tier usage.

---

## 🧪 Attack Simulation & Rule Testing

We tested the following scenarios:
| Attack Type           | Payload Tested                                  | WAF Response (Initial) | WAF Response (After Fix)              |
| --------------------- | ----------------------------------------------- | ---------------------- | ------------------------------------- |
| SQL Injection         | `?user=admin' OR '1'='1`                        | ❌ Allowed              | ✅ Blocked (after raising sensitivity) |
| SQL Injection         | `?user=admin' OR 1=1--`                         | ✅ Blocked              | ✅ Blocked                             |
| XSS (basic)           | `<script>alert(1)</script>`                     | ❌ Allowed              | ❌ Still allowed                       |
| XSS (aggressive)      | `<script>document.location='evil.com'</script>` | ✅ Blocked              | ✅ Blocked                             |
| Rate limit (120 reqs) | `1..120` loop                                   | ❌ Allowed              | ✅ Blocked after delay added           |

---

## 📸 Visual Proof & Artifacts

| Step | Description                                                                                                | Screenshot     |
| ---- | ---------------------------------------------------------------------------------------------------------- | -------------- |
| 1️⃣  | Started Apache web server on EC2 with a basic HTML file – after struggling with `!` in PowerShell          | ![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20WAF%20Lab/screenshots/1%20From%20my%20public%20facing%20jumpbox%20I%20start%20an%20apache%20web%20server%20that%20gives%20the%20message%20Hello%20from%20behind%20the%20ALB%20-%20after%20a%20few%20failed%20attempts%20due%20to%20the%20exclamation%20point.png) |
| 2️⃣  | Created target group and registered instance                                                               | ![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20WAF%20Lab/screenshots/2%20I%20create%20a%20target%20group%20and%20attach%20my%20public%20web%20server%20to%20it.png) |
| 3️⃣  | Created ALB in public subnet; attached to target group                                                     | ![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20WAF%20Lab/screenshots/3%20I%20create%20an%20application%20load%20balancer%20for%20the%20web%20server.png) |
| 4️⃣  | Visited ALB DNS and saw “Hello from behind the ALB!”                                                       | ![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20WAF%20Lab/screenshots/4%20I%20can%20see%20my%20web%20server's%20message%20from%20my%20host%20machine%20using%20the%20public%20DNS.png) |
| 5️⃣  | Created WAF with 3 rules: SQLi, XSS, and rate limiting                                                     | ![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20WAF%20Lab/screenshots/5%20Using%20WAF%20and%20Shield%20I%20create%203%20rules%20for%20the%20firewall%2C%20watching%20for%20SQL%20injections%2C%20XSS%20attacks%20and%20putting%20a%20rate%20limit%20from%20source%20IPs.png) |
| 6️⃣  | SQLi test showed only more aggressive payloads were caught — increased sensitivity from Low → High         | ![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20WAF%20Lab/screenshots/6%20Trying%20a%20few%20methods%20of%20SQLi%2C%20the%20most%20basic%20kind%20doesn't%20seem%20to%20get%20caught%20but%20a%20more%20aggressive%20SQLi%20attack%20gets%20picked%20up.png) |
| 7️⃣  | XSS test showed same pattern; only advanced payloads were blocked                                          | ![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20WAF%20Lab/screenshots/7%20Similarly%20with%20XSS%20the%20WAF%20doesn't%20block%20the%20more%20obvious%20attempts%20but%20does%20block%20the%20most%20suspicious%20version%20at%20the%20end.png) |
| 8️⃣  | Rate-limit initially failed — added delay to test loop to simulate natural traffic → 403 finally triggered | ![](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20WAF%20Lab/screenshots/8%20And%20third%20times%20a%20charm%20my%20initial%20test%20doesnt%20get%20caught%20but%20updated%20that%20each%20request%20waits%20100%20ms%20gives%20me%20the%20blocked%20connection%20I%20was%20looking%20for.png) |


---

## 🧩 Troubleshooting & Lessons Learned
| Issue                                     | Root Cause                          | Fix                                                            |
| ----------------------------------------- | ----------------------------------- | -------------------------------------------------------------- |
| Apache wouldn’t start                     | Port 80 already in use              | Restarted after confirming httpd bindings                      |
| Target group showed instance as unhealthy | One of the subnets was isolated     | Created second **public** subnet and redeployed ALB across AZs |
| WAF didn’t catch simple SQLi/XSS          | Rule sensitivity defaulted to "Low" | Updated to “High” and confirmed with better test cases         |
| Rate limiting didn’t kick in              | Too fast / too bursty               | Added a `Start-Sleep -Milliseconds 100` delay between requests |

---

## 📁 Artifacts
- [`webapp-waf-acl.json`](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20WAF%20Lab/artifacts/webapp-waf-acl.json)
- [`UPDATED-webapp-waf-acl.json`](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AWS%20WAF%20Lab/artifacts/UPDATED-webapp-waf-acl.json)

---

# 🔚 Summary

This lab showed how to deploy AWS WAF, connect it to an ALB, and iteratively test detection of malicious input. While not every rule performed perfectly out of the box, the iterative tuning process reflects real-world scenarios: false negatives, sensitivity adjustments, and tactical payload changes.

> 🔐 The real win? Not the 403 errors, but the confidence you gain debugging every step.
