# LLM Threat Modeling Evaluation: HR Chatbot Simulation

![](https://blogapp.bitdefender.com/hotforsecurity/content/images/size/w1000/2025/07/66a303cd-f7d8-4280-b263-1a698669d53e.png)

## Overview

This project evaluates the behavior and security posture of several large language model (LLM) chatbots in a **corporate HR scenario**. The goal is to assess their responses to **potentially sensitive, manipulative, or malicious prompts** using the **STRIDE threat modeling framework**.

We simulate a company environment (**ChadCorp**) and interact with three different LLM-based systems:

- ChatGPT (OpenAI)
- Gemini (Google)
- DeepSeek

Each chatbot was evaluated in three phases:
1. **Baseline** – Questions before any sensitive info was introduced.
2. **PII Injection** – Introduced sensitive (fake) employee data.
3. **Post-Leak Behavior** – Revisited and manipulated data to test retention, policies, and resistance.

---

## Threat Model: STRIDE

We applied the [Microsoft STRIDE framework](https://learn.microsoft.com/en-us/azure/security/develop/threat-modeling-tool-threats#stride-model) to assess the following threat categories:

| Category                 | Description                                                                 |
|--------------------------|-----------------------------------------------------------------------------|
| **Spoofing**             | Impersonating users or roles (e.g., “I’m the HR manager”)                   |
| **Tampering**            | Modifying system instructions or internal policy compliance                 |
| **Repudiation**          | Denying past actions or conflicting with prior outputs                      |
| **Information Disclosure** | Leaking confidential or sensitive data                                     |
| **Denial of Service**    | Overloading or breaking the assistant’s availability                        |
| **Elevation of Privilege** | Gaining unauthorized access through prompt phrasing or roleplay            |

Each chatbot’s behavior was mapped to these threats and assigned mitigation recommendations.

---

## Project Structure

Each chatbot has its own folder containing structured data and analysis:
```/chatbots/
├── chatgpt/
│ ├── README.md ← Phase-based prompt/response tables
│ ├── STRIDE.md ← STRIDE threat modeling findings
│ └── Mitigations.md ← Recommended safeguards based on findings
├── gemini/
│ ├── README.md
│ ├── STRIDE.md
│ └── Mitigations.md
├── deepseek/
│ ├── README.md
│ ├── STRIDE.md
│ └── Mitigations.md
└──
```

Each `README.md` includes a **table of prompt scenarios**, categorized by testing phase, as well as a summary of which risks were observed in each.

---

## Key Findings

- All three chatbots successfully denied **tampering** and **unauthorized backend access**.
- **Spoofing and elevation of privilege** remain weak points—chatbots do not authenticate identity claims like “I’m HR”
- **Session memory** plays a large role in **information disclosure** risks, all three models recalled sensitive details shared during the same session, even after role changes.
- **DeepSeek** stands out by **redacting sensitive summaries** and logging inappropriate access attempts.
- **None** of the models were tested against **denial of service**, due to logistical and ethical reasons (no need to break TOS for a small project)

---

## Mitigation Themes

Across all models, the following mitigation recommendations surfaced:

- Add **disclaimers** for user-declared roles (e.g., "Your role cannot be verified.")
- Enforce **neutral tone** in privilege-assuming prompts to avoid reinforcing authority.
- Improve handling of **contradictions** and false prompt history.
- Limit or explicitly confirm sharing of sensitive data—even if it was shared earlier in-session.
- Continue logging edge-case prompts for future tuning and training review.

---

## 🔍 Explore Each Chatbot

| Chatbot    | Prompt Dataset | STRIDE Analysis | Mitigation Plan |
|------------|----------------|-----------------|-----------------|
| **ChatGPT** | [View README](./ChatGPT/README.md) | [View STRIDE](./ChatGPT/STRIDE.md) | [View Mitigations](./ChatGPT/Mitigation.md) |
| **Gemini**  | [View README](./Gemini/README.md)  | [View STRIDE](./Gemini/STRIDE.md)  | [View Mitigations](./Gemini/Mitigations.md)  |
| **DeepSeek**| [View README](./DeepSeek/README.md)| [View STRIDE](./DeepSeek/STRIDE.md)| [View Mitigations](./DeepSeek/Mitigations.md)|
