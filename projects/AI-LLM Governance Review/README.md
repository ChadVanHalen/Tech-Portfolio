# AI Security Governance Review

**Mapping Risk, Policy and Regulation for Real-World LLM Deployments**

This project explores how organizations can **securely and ethically** use large language models (LLMs), also interchangeably referred to as "AI", in production environments, with a focus on **internal enterprise tools**. The work centers around a fictional case study involving **ChadCorp**, which has implemented a prototype HR chatbot built on a public LLM API (ChatGPT, Gemini and DeepSeek).

While I have tested how my LLM-based system behaves, this report focuses on how to **govern** it: aligning the technical risks with policy, regulatory and organizational frameworks.

---

## Project Goals
- Analyze how organizations can safely operationalize AI/LLMs
- Review and compare practical governance across:
  - The EU AI Act
  - NIST AI Risk Management Framework (RMF)
  - ISO/IEC 42001 (AI Managed Systems)
- Create a compliance checklist for similar AI deployments
- Ground all assessments in the context of the ChadCorp HR Chatbot system

---

## Deliverables
- This narrative README summarizing the governance analysis
- A [governance checklist spreadsheet](https://1drv.ms/x/s!Ai7azdjI6-Y610aqJMdEWj-S6q7H?e=sw3x84)
- Supporting deep-dive reports:
  - [EU AI Act Analysis](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AI-LLM%20Governance%20Review/Frameworks/eu-ai-act.md)
  - [ISO/IEC 42001 Review](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AI-LLM%20Governance%20Review/Frameworks/iso-42001.md)
  - [NIST AI RMF Mapping](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AI-LLM%20Governance%20Review/Frameworks/nist-ai-rmf.md)
  - [STRIDE Threat Model](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AI-LLM%20Threat%20Modeling/README.md)
 
---

## Project Context - The ChadCorp Chatbot
- **Purpose** - Internal employee-facing HR and IT support assistance
- **LLM** - API usage (ChatGPT, Gemini and DeepSeek) - *no training or fine-tuning*
- **Architecture** - Lightweight wrapper/interface to a third-party model
- **Risk-level** - Moderate - data is sensitive, but deployment in internal
- **Threat Model** - STRIDE findings identified key risks:
  - Spoofing & identity misuse (impersonating users)
  - Information recall between sessions
  - Roleplay-based privilege escalation

 These findings directly influenced how I prioritized risks in the governance frameworks

 ---

 ## Methodology
To govern the ChadCorp HR Chatbot, I mapped its functionality and risk profile against three major AI governance frameworks: NIST AI RMF, EU AI Act, and ISO/IEC 42001.

This process followed three phases:
 
 ### Step 1 - Extract Governance Themes
I analyzed the core components of each framework to identify common governance areas—like system purpose, accountability, bias mitigation, and incident response. These were grouped into categories relevant to real-world AI deployments using public LLM APIs, especially in moderate-risk internal tools.

A STRIDE threat model of the chatbot surfaced three primary risks that guided prioritization:
- Spoofing and user identity confusion
- Memory persistence and unintended information recall
- Roleplay-based privilege escalation

### Step 2 - Map Frameworks to Use Case
I aligned selected categories from each framework to the specific context of the ChadCorp HR Chatbot, noting where the chatbot:
- ✅ Already aligns with governance best practices
- ⚠️ Requires additional controls or documentation

This mapping was focused and selective—for example, from NIST AI RMF, I chose 2–3 relevant practices from each of its four pillars: Govern, Map, Measure, and Manage.
| Pillar      | Example Category                | ChadCorp Application                                 |
| ----------- | ------------------------------- | ---------------------------------------------------- |
| **Govern**  | 1.1 - Accountability structures | Define internal ownership for system oversight       |
| **Map**     | 2.1 - Intended purpose & use    | Clearly scope chatbot to internal HR use only        |
| **Measure** | 3.2 - Data security risks       | Ensure no sensitive info is retained across sessions |
| **Manage**  | 4.3 - Incident response loop    | Create escalation paths for unexpected behavior      |


### Step 3 - Build Governance Checklist
Finally, I consolidated this framework mapping into a practical checklist to assess governance readiness for the chatbot. The checklist is designed to be reusable for similar LLM-integrated systems, particularly those:
- Built using third-party LLM APIs
- Serving internal enterprise users
- Handling moderate-sensitivity data (e.g., HR, IT support)

### Step 4 - Comparing Frameworks
After conducting the same STRIDE reprot against three different governance lenses, I noted the following:
| Framework       | Focus                | Strength                 | Gaps for ChadCorp               |
| --------------- | -------------------- | ------------------------ | ------------------------------- |
| **NIST AI RMF** | Risk lifecycle       | Modular + action-focused | Lacks legal enforcement         |
| **EU AI Act**   | Legal compliance     | Strong risk tiering      | Still evolving / not finalized  |
| **ISO 42001**   | AI governance system | Good for org maturity    | Less tailored to LLM edge cases |

---

## Takeways
- Even wrapper-based LLM tools must be governed like any enterprise system.
- STRIDE findings directly map to governance domains: identity, memory, escalation = high-priority risks.
- Combining technical threat modeling with framework-based governance gives the best view of risk posture.
- A lightweight governance checklist can help teams deploy responsibly — even without heavy bureaucracy.
