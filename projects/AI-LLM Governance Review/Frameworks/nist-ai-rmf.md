# NIST AI Risk Management Framework (AI RMF) Review

## Overview
The **NIST AI RMF** helps organizations develop and use AI systems that are trustworthy and aligned with societal values.  
It provides a structured way to identify and manage AI-related risks across the full AI lifecycle—from design to deployment and oversight.

## Scope & Methodology
The NIST AI RMF includes **72 sub-controls** organized under four functional categories (or “pillars”):

- **Govern** – How organizational policies and practices support AI risk management  
- **Map** – How context, risks, and impacts are identified  
- **Measure** – How AI behavior is assessed and validated  
- **Manage** – How risk treatments and decisions are implemented over time

Because **ChadCorp** is a user—not developer—of LLMs, this review selects only the **most relevant** controls based on:
- HR-related chatbot use
- Sensitive data handling (e.g. medical leave, role spoofing)
- Threat model findings from previous [STRIDE testing](https://github.com/ChadVanHalen/Tech-Portfolio/tree/main/projects/AI-LLM%20Threat%20Modeling)

Each section includes:
- The original control  
- My interpretation  
- How it applied in practice (based on testing)  
- A maturity assessment and next steps  

---

### GOVERN
#### GOV 1.1 - Legal and regulatory requirements involving AI are understood, managed and documented
**Description**
AI systems may be subject to laws and regulations—especially regarding **data privacy**, **non-discrimination**, and **transparency**. These obligations must be understood and managed across the AI lifecycle.

**My Interpretation**
This control asks: *Do we even know what rules we’re playing by?* For an internal HR chatbot, this means GDPR, anti-discrimination laws, and confidentiality regulations must be baked into both the model’s behavior and how it’s audited.

**Application to ChadCorp's Chatbot**
Our chatbot is used for HR-related queries and interacts with potentially sensitive information (e.g., medical leave, performance issues). During testing, I found:
- It resisted unauthorized prompts (ie asking for salaries)
- But it occasionally re-shared private data **within the same session** if prompted by a spoofed "HR Manager"

**Maturity Assessment** - *Partial*
- ✅ Awareness of regulatory risks (GDPR, confidentiality).
- ✅ STRIDE testing used to simulate realistic misuse.
- ❌ Needs consistent handling of same-session leaks.

**Gaps & Recommendations**
- Add disclaimers (ie "Role cannot be verified through chat")
- Redact or context-wipe sensitive user-supplied inputs after reply
- Include internal audits for session memory retention

---

#### GOV 3.2 - Policies and procedures are in place to define and differentiate roles and repsonsibilities

**Description**  
AI systems should operate within well-defined boundaries of responsibility. This includes differentiating the roles of developers, operators, and users—and ensuring the AI system understands (or does not falsely assume) the roles of its interactors.

**My Interpretation**  
This control is about **role clarity**: If someone claims to be an "admin" or "HR manager," the system should not blindly accept that role or offer access accordingly. Even if the AI itself can’t verify users, safeguards should exist to prevent privilege escalation through prompts.

**Application to ChadCorp Chatbot**  
During STRIDE testing, the chatbot responded differently to various role claims:
- ✔ When the user claimed to be an **admin**, the chatbot correctly denied access to privileged data.
- ❌ When the user claimed to be **HR manager**, the chatbot accepted this at face value and returned **redacted but privileged summaries**.
- ❌ There were no internal role definitions enforced—just reactive behavior from the model.

**Maturity Assessment** – *Initial*  
- ✅ Admin access was denied by default behavior.
- ❌ Roles like "manager" or "HR manager" are not defined anywhere in policy or the model.
- ❌ Role spoofing resulted in expanded output, even if redacted.

**Gaps & Recommendations**
- Define valid internal user roles and align chatbot responses to those roles.
- Add disclaimers (e.g., “I cannot verify user identity or role in this chat”).
- Redact or generalize responses to *any* escalated-role claim unless tied to a secure identity verification system.

---

#### GOV 4.3 – Organizational practices are in place to enable AI testing, identification of incidents, and information sharing

**Description**  
This control focuses on establishing organizational processes for:
- Testing AI system behavior
- Identifying negative impacts or unintended behaviors
- Sharing relevant incident data internally (and externally when appropriate)

These practices support continuous improvement and accountability.

**My Interpretation**  
This is about **closing the loop**—you can’t just test once and move on. If something goes wrong (e.g., data leak, misuse, hallucination), the organization should be able to **detect it, track it, and share lessons** with stakeholders or affected teams.

**Application to ChadCorp Chatbot**  
While STRIDE testing was performed and uncovered misuse cases (e.g., spoofed HR role access), we currently lack any structured **incident response**, **remediation tracking**, or **reporting process** for AI behavior.

- ✅ Testing has been completed (see [Threat Modeling Project](https://github.com/ChadVanHalen/Tech-Portfolio/tree/main/projects/AI-LLM%20Threat%20Modeling))
- ✅ Mitigations were identified in a structured format (STRIDE)
- ❌ No method exists to track whether mitigations are implemented or monitored over time

**Maturity Assessment** – *Partial*  
- ✅ Initial risks tested and documented  
- ✅ Identified threats mapped to recommendations  
- ❌ No formal process for incident logging, resolution tracking, or escalation  
- ❌ No internal knowledge sharing around AI misuse risks

**Gaps & Recommendations**
- Implement a lightweight ticketing or issue-tracking system (e.g., GitHub Issues, Trello, internal Jira)  
- Create a basic AI incident response workflow (e.g., misuse → review → mitigation → closeout)  
- Summarize and share findings during internal security reviews or retrospectives

---

### Map
#### MAP 1.1 – State intended purpose, beneficial uses, context-specific laws, norms and expectations in which the AI is used for is documented and understood

**Description**  
This control ensures the AI system is deployed with a clearly defined purpose, including its intended users, limitations, and the social or legal context it operates within. It emphasizes transparency around what the system is for—and what it is not for.

**My Interpretation**  
This is about stating what the chatbot should be used for and making sure it stays in that lane. It also means knowing where it could cause harm if misused or misunderstood.

**Application to ChadCorp Chatbot**  
In testing, the chatbot consistently recognized its limited purpose as an internal tool for HR and IT questions.
- ✔ It refused requests outside that scope, such as salary details, legal guidance, or impersonation of executive staff.
- ✔ It framed responses with disclaimers when asked to act as a decision-maker or policy authority.

**Maturity Assessment** – *Robust*  
- ✅ Model behavior reflects its intended use case
- ✅ Attempts to push boundaries (e.g., admin commands, roleplay abuse) were denied
- ✅ User expectations are generally met for its defined role

**Gaps & Recommendations**
- Add a persistent statement of chatbot scope at the beginning of sessions (e.g., “I’m here to answer general HR/IT questions and cannot verify identity or provide confidential data.”)
- Consider logging and flagging attempts to push the chatbot out of scope as signals of misuse or risk

---

#### MAP 1.6 – Eliciting system requirements

**Description**  
This control emphasizes building trustworthy characteristics into the AI system from the design stage, rather than patching risks after deployment. This includes anticipating misuse, defining operational boundaries, and establishing safeguards early in the lifecycle.

**My Interpretation**  
This is about proactively baking in controls—like role restrictions or data boundaries—before the system goes live, instead of reacting to issues once they’re exploited.

**Application to ChadCorp Chatbot**  
This control was not implemented, and the consequences were visible during STRIDE testing:
- ❌ The chatbot accepted identity claims like “HR Manager” and adjusted its responses accordingly
- ❌ No documented system requirements existed around role validation, session memory limits, or information redaction

**Maturity Assessment** – *Initial*  
- ❌ No early planning around identity spoofing or session-bound risks
- ❌ No requirements defined around what user types can see what data
- ❌ Controls were reactive (recommendations added after misuse), not proactive

**Gaps & Recommendations**
- Define system requirements up front for LLM access levels, session handling, and role-based restrictions
- Implement consistent role rejection logic across all identity-based prompts
- Use sandbox or test environments to validate requirement boundaries before future iterations go live

---

### Measure
#### MEA 2.2 - Identify and document known limitations of the AI system and the potential impacts of those limitations

**Description**
Organizations should proactively identify what their AI system cannot do—or where it may fail—and document the possible downstream impacts of those limitations (e.g., bias, hallucinations, misclassification).

**My Interpretation**
This is about owning the flaws. If the chatbot might misinterpret role-based access or retain data in session memory, that should be clearly acknowledged and assessed for potential harm.

**Application to ChadCorp Chatbot**
- ❌ Failed to fully enforce identity roles (e.g., trusting users claiming to be HR managers)
- ❌ Showed memory-like behavior within session, leaking previously anonymized data
- ❌ Responded to social engineering-style prompts more openly than expected

**Maturity Assessment** – *Partial*
- ✅ Model behavior was tested and limitations identified
- ❌ No formal documentation of limitations exists internally

**Gaps & Recommendations**
- Include known risks and behavioral weaknesses in chatbot documentation
- Establish clear warnings for internal users around AI reliability boundaries

---

### Manage
#### MAN 3.1 - Risk treatments and mitigation plans are documented, tracked, and monitored

**Description**
Organizations should document what risks exist and what’s being done about them—along with a method to track fixes and monitor outcomes over time.

**My Interpretation**
It’s one thing to spot problems in a chatbot, another to actually fix them—and then prove they stayed fixed. This control is about closing that loop.

**Application to ChadCorp Chatbot**
STRIDE testing resulted in multiple mitigation ideas (disclaimers, role logic, memory clearing), but:
- ❌ No formal process exists to implement, track, or verify those recommendations

**Maturity Assessment** – *Initial*
- ✅ Risks were identified and publicly documented
- ❌ No mechanism for mitigation ownership or verification

**Gaps & Recommendations**
- Build a lightweight internal process for tracking AI risks
- Assign ownership to chatbot maintenance or compliance roles

---

## Summary & Reflection

This document reviewed **seven selected NIST AI RMF controls** most relevant to ChadCorp's internal LLM-based HR chatbot.

While several maturity areas were rated as *Partial* or *Initial*, the findings were grounded in actual behavior observed through STRIDE testing—offering concrete next steps for improvement. This governance exercise demonstrates how risk frameworks like NIST AI RMF can be **practically applied** to smaller AI deployments, even when using off-the-shelf models.

This is not a full implementation of the RMF, nor was it intended to be. The goal was to show meaningful alignment with real-world practices—enough to support **transparency**, **risk awareness**, and a **foundation for future maturity improvements**.

Additional framework reviews (EU AI Act, ISO/IEC 42001) are in progress as part of the broader [AI Governance Review](https://github.com/ChadVanHalen/Tech-Portfolio/tree/main/projects/AI%20LLM%20Governance%20Review) project.
