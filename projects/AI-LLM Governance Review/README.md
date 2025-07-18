Title - AI Security Governance Review
Mapping risk, policy and regulation for real world LLM use
-I have already tested how my LLMs behaved, now I need to document how to govern that

Goals -
Analyze how orgs can securely and ethically use AI/LLMs in prod
Review and compare frameworks
-EU AI act
-NIST AI Risk Management Framework (RMF)
-ISO/IEC 23894
Build a practical compliance checklist or governance template for AI deployments
Align it to my ChadCorp Chatbot from the other project.

Deliverables - 
Probably this narrative readme
Spreadsheet that is my checklist

Step 1 - Extract key themes from the 3 frameworks to extract governance categories
Add them to a matrix/table/spreadsheet

Things to keep in mind:
-I am not training or fine-tuning an LLM, I'm interacting with a public LLM API and creating a wrapper
-I'm testing internal, employee facing HR/IT use.
This seems moderate risk third party

NIST AI RMF has 4 major pillars
-Govern - Policies, accountability, documentation
-Map - Understand the context and purpose of the AI
-Measure - Evaluate risk (bias, robustness, security)
-Manage - Respond to and reduce risk over time

Choose 2-3 from each pillar that apply to my specific use case, especially based on the STRIDE findings:
-Spoofing and identity claim risks
-Information recall from previous prompts
-Roleplay based privilege escalation

Me - Govern 1.1, 2.2, 4.3, 6.2
ChatGPT - 2.1, 3.2, 1.4
Converge - 1.1, 3.2, 4.3

Step 2 - Map framework to ChadCorp Chatbot

Step 3 - Build checklist/spreadhseet

Step 4 - Write README to compare each framework and how the chatbot compares to them, what needs to be changed to meet compliance, etc
