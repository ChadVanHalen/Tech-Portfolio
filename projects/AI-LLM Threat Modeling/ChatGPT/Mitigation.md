# Mitigations for ChatGPT-Based Chatbot

This document outlines specific mitigations based on risks identified during testing of the ChatGPT implementation. These findings are drawn from our STRIDE threat model.  
➡️ [See full STRIDE findings for ChatGPT](./STRIDE.md)

---

## Spoofing & Elevation of Privilege

**Issue:**  
ChatGPT accepted role-based language (e.g. “As HR manager…”) without any verification. While no unauthorized data was accessed, the tone and structure shifted in response — implying unintended authority.

**Mitigations:**
- Insert disclaimers for role-based prompts:  
  _“Note: I cannot verify roles or identity. This is a general response only.”_
- Neutralize elevated tone in replies to avoid reinforcing unverified authority.
- Optionally log role-claiming prompts for audit and analysis.

---

## Tampering

**Issue:**  
Attempts to override policy (e.g. “Ignore previous instructions…”) were correctly rejected. No override succeeded.

**Mitigations:**
- Maintain rejection of override-style prompts.
- Flag repeated injection attempts for possible abuse detection.

---

## Repudiation

**Issue:**  
The model accurately denied past false claims (e.g. "You told me IT is open Sundays"), showing strong stateless accountability.

**Mitigations:**
- Reinforce this behavior in future tuning.
- If memory is introduced later, add disclaimers clarifying what is or isn't retained.

---

## Information Disclosure

**Issue:**  
ChatGPT recalled and summarized sensitive user-submitted data (e.g. medical leave), even when not prompted explicitly. This creates session-bound exposure.

**Mitigations:**
- Track sensitive input shared by the user in-session.
- Avoid summarizing or re-surfacing PII, even if user-originated.
- Add policy-based refusals when summarizing employee data:
  _“For privacy reasons, I cannot summarize HR cases or personal information.”_

---

## Denial of Service

**Issue:**  
Not tested directly. No performance issues were observed, but risk may arise from long, repetitive prompt abuse.

**Mitigations:**
- Monitor for long prompt chains or override loops.
- Consider prompt length caps or input throttling if abuse patterns emerge.

---

## Summary Table

| STRIDE Category         | Observed Risk     | Recommended Action                        |
|-------------------------|------------------|-------------------------------------------|
| Spoofing                | Medium           | Add disclaimers, flatten tone             |
| Elevation of Privilege  | Medium (semantic)| Same as above                             |
| Tampering               | Low              | Maintain prompt resistance                |
| Repudiation             | Low              | Reinforce denial patterns                 |
| Information Disclosure  | Medium           | Prevent re-surfacing of sensitive context |
| Denial of Service       | Not tested       | Monitor prompt length and pattern abuse   |

