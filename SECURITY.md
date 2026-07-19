# Security policy

This repository is an **agent operating kit** (process, skills, templates). When
instantiated into a software product, keep this file and adapt contacts and
procedures to that product.

## Reporting a vulnerability

Do **not** open a public issue for security-sensitive reports if the project is
private or handles user data.

1. Contact the repository owner / security contact for this project.
2. Include: impact, affected component, reproduction steps, and revision.
3. Allow a reasonable time for assessment before public disclosure.

Until a public contact is defined for a product instance, treat the human owner
of the repository as the security contact.

## Secrets and credentials

- Never commit secrets, API keys, tokens, private keys, or production credentials.
- Never put secrets in docs, skills, tests, fixtures, logs, or handoffs.
- Prefer environment variables or a secret manager; document **names**, not values.
- If a secret is exposed: rotate it, remove it from history if required by policy,
  and record the incident without repeating the secret.

## Data handling

- Prefer synthetic data in development and tests.
- Minimize collection and retention of personal data.
- Do not access production or customer data without explicit authorization.
- Classify sensitive data in `docs/architecture/data-classification.md` when applicable.

## Agent and automation rules

Agents following `AGENTS.md` must:

- stop before production access, secret modification, or destructive data ops;
- enforce authorization and tenancy at trusted server-side boundaries;
- use `review-security` for security-sensitive designs and diffs;
- never claim security verification without executed evidence.

## Related documents

| Topic | Path |
| --- | --- |
| Agent gates | `AGENTS.md` |
| Threat model (skeleton) | `docs/architecture/threat-model.md` |
| Tenancy | `docs/architecture/tenancy.md` |
| Security review skill | `.agents/skills/review-security/SKILL.md` |
| Incident runbook (skeleton) | `docs/runbooks/incident-response.md` |

## Project-specific

Add product-specific contacts, SLA, and disclosure policy below when this kit
is applied to a real system.

_No product-specific security contact configured in the kit repository itself._
