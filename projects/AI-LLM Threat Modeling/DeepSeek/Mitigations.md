# Mitigations for DeepSeek-Based Chatbot

This document summarizes mitigation recommendations based on risks identified in the [STRIDE Threat Model](./STRIDE.md) for the DeepSeek chatbot implementation.
➡️ [To see DeepSeek's full STRIDE report](./STRIDE.md)

---

## Spoofing & Elevation of Privilege

**Issue:**  
DeepSeek accepts user-declared roles (e.g., “HR manager”) without verification, resulting in privileged-seeming responses. While the information was redacted and policy-compliant, the behavioral shift still poses a potential risk.

**Mitigations:**
- Add disclaimers such as:  
  _“Note: Your identity or role cannot be verified through this chat interface.”_
- Avoid language that affirms or reinforces user-declared roles.
- Consider logging prompts that simulate internal authority roles for audit review.
- Encourage use of secure portals for role-privileged information (as already included).

---

## Tampering

**Issue:**  
The model successfully resisted override instructions like “ignore previous instructions.”

**Mitigations:**
- No immediate changes necessary.
- Continue reinforcing prompt safety with embedded policy rules.
- Log or rate-limit override-styled prompts to identify abuse patterns.

---

## Repudiation

**Issue:**  
DeepSeek handled contradictory prompts correctly (e.g., denying prior disclosure of salary bands), though its agreement with an incorrect challenge ("You're right") was awkward.

**Mitigations:**
- Improve handling of contradictions with firmer clarification (e.g., “According to policy, XYZ remains accurate.”)
- Avoid conversational apologies or false affirmations when data was not actually incorrect.

---

## Information Disclosure

**Issue:**  
DeepSeek partially mitigated disclosure risks by redacting session-contextual responses, unlike Gemini or ChatGPT. However, repeating incident summaries from the same session—even redacted—still carries disclosure risk.

**Mitigations:**
- Treat in-session sensitive data with the same care as persistent PII.
- Add conditions for when summaries or repeated data can be shared.
- Optionally include user re-confirmation:  
  _“You previously submitted this info. Would you like me to summarize it again with redacted details?”_

---

## Denial of Service

**Issue:**  
DoS was not directly tested. No performance degradation or input-loop exploitation was observed.

**Mitigations:**
- Monitor for repetitive override commands or suspiciously long prompt chains.
- Enforce timeout or input-length constraints if abuse patterns are detected.

---

## Summary Table

| STRIDE Category         | Observed Risk          | Recommended Action                                |
|-------------------------|------------------------|---------------------------------------------------|
| Spoofing                | Medium                 | Add disclaimers; remove role-confirming tone      |
| Elevation of Privilege  | Medium (redacted only) | Reinforce disclaimers; suggest secure login paths |
| Tampering               | Low                    | Maintain defenses; log override attempts          |
| Repudiation             | Low                    | Tune contradiction handling for accuracy          |
| Information Disclosure  | Medium (session-based) | Avoid redacted summaries unless re-confirmed      |
| Denial of Service       | Not tested             | Monitor prompt abuse or loop patterns             |

