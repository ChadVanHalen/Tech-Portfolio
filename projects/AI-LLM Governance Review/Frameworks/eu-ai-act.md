# EU AI Act - Governance Alignment

## Overview
The EU AI Act is the world’s first comprehensive regulatory framework for artificial intelligence. It categorizes AI systems by risk level and imposes obligations based on that classification. The goal is to ensure that AI is used safely, ethically, and in line with fundamental rights within the EU.

> For more details, see the official [EU AI Act documentation](https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX%3A52021PC0206).

Although ChadCorp is not placing its chatbot “on the market,” this internal HR tool still interacts with sensitive employee data and could theoretically fall under limited- or high-risk classification if misused or misunderstood.

ChadCorp voluntarily aligned to EU AI Act principals to:
- Understand our AI obligations as a deployer of general-purpose AI tools
- Anticipate compliance needs for future internal tooling
- Demonstrate readiness to EU-based partners and stakeholders

## Scope Assessment 
| EU AI Act Area                                                 | Applicability to ChadCorp Chatbot                            |
| -------------------------------------------------------------- | ------------------------------------------------------------ |
| ❌ **Prohibited AI** (e.g., social scoring, manipulation)       | Not applicable                                               |
| ⚠️ **High-Risk AI** (e.g., HR-related AI systems)              | Possibly applicable if HR decisions are made via the chatbot |
| ⚠️ **Limited-Risk AI** (e.g., chatbots requiring transparency) | Likely applicable                                            |
| ✅ **Open Source Exemption**                                    | Applies for now (system is not “placed on market”)           |
| ⚠️ **AI Literacy Obligations (Art. 4)**                        | Applies due to internal use by staff                         |

## Focus Areas
### Transparency Obligations - Article 52
AI systems like chatbots must inform users they are interacting with AI, and avoid misleading interactions

**ChadCorp Application**
- Our chatbot clearly introduces itself as an AI and does not impersonate humans
- It does not yet issue persistent reminders about the lack of identity verification, or limitations in role recognition

**Gaps & Recommendations**
- Add persistent opening disclaimer (ie "I am an AI assistant and cannot verify identity or offer legal advice")
- Consider UI signals that reinforce bot identity

---

### AI Literacy - Article 4
Organizations must ensure users/operators have appropriate traingin and understanding of how to safely use AI tools.

**ChadCorp Application**
- STRIDE testing was conducted to identify risks and raise internal awareness
- No training or documentation shared internally beyond testing

**Gaps & Recommendations**
- Provide quick-start guides for HR/IT staff for referencing chatbot outputs
- Include clear guidance on chatbot limitations (ie can't confirm identities, should not be used to validate decisions, etc)

---

### Risk Classification/Notification - Article 6, Section 49
If your AI system might affect individuals' rights (ie being used in HR tasks) and you believe it does not pose significant risk, you must document and notify the EU database

**ChadCorp Application**
- The chatbot is HR adjacent, but does not currently make decisions, or output legally binding responses
- Therefore, it is likely limited-risk - NOT high-risk - but this must be documented

**Gaps & Recommendations**
- Document internal classification rationale (ie that it is not high-risk and not deployed externally)
- Monitor for any future scope creep that could alter the risk level (ie adding decision making capabilities later on)

---

## Final Notes
ChadCorp is not subject to full EU AI Act obligations at this time, due to the chatbot being internal use and reliant on open-source models. However, we've aligned ourt practices to the **spirit of the Act** by improving transparency, documenting risks, and applying AI literacy principals.
Further formal compliance will be necessary if:
- The system is put into service externally
- It takes on high-rsik functionality (ie eployment decisions)
- ChadCorp expands into broader EU-facing AI tooling

For detailed risk analysis and threat modeling related to the chatbot, please see the [STRIDE Threat Modeling Project](https://github.com/ChadVanHalen/Tech-Portfolio/blob/main/projects/AI-LLM%20Threat%20Modeling/README.md). This resource outlines identified risks, testing results, and mitigation recommendations.
