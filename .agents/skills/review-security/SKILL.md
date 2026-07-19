---
name: review-security
description: Independently perform a risk-based security review of a feature, design, implementation, diff, or existing module without modifying code during the initial review.
---

# Review Security

## Purpose

Perform an independent, evidence-based security review of a defined system surface.

Identify realistic threats, exploitable weaknesses, unsafe assumptions, missing controls, and residual risks across design, implementation, data, infrastructure, operations, and user workflows.

This skill reviews and reports. It does not modify code during the initial pass, perform destructive exploitation, silently accept risk, approve its own implementation, access production without authorization, or replace specialist assessment where one is required.

## Applicable Review Targets

This skill may review:

* a feature specification;
* an architectural or technical design;
* an implemented vertical slice;
* a complete diff or pull request;
* an existing module or integration;
* an authentication, authorization, data, administrative, or operational subsystem.

State clearly whether conclusions apply to design intent, implementation reality, or both.

## Independence Requirement

The reviewer should not be the sole designer or implementer of the reviewed change.

Use repository sources, direct inspection, independently executed checks, and reproducible evidence. Treat prior security claims, passing tests, scanner output, and implementer reports as inputs rather than proof.

## Required Inputs

Read, in precedence order:

1. `AGENTS.md` and applicable nested instructions.
2. Approved product scope, feature specification, non-goals, and acceptance criteria.
3. Architecture, trust-boundary, quality-attribute, privacy, and ADR documentation.
4. Relevant ExecPlan, implementation handoff, change review, and acceptance-verification reports.
5. Complete implementation or diff, tests, migrations, schemas, dependencies, configuration, CI/CD, infrastructure, and operational documentation.
6. `docs/project-status.md`, known incidents, accepted risks, and baseline failures.

When authoritative sources conflict, record the conflict and block affected conclusions rather than selecting the safest-looking interpretation silently.

## Scope and Baseline

Record:

* review target and exact revision;
* comparison baseline when reviewing a change;
* included and excluded components;
* environments assessed;
* affected users, roles, tenants, data, integrations, and infrastructure;
* assumptions and inaccessible systems;
* permitted verification methods;
* known accepted risks and previous findings.

Do not generalize conclusions beyond the reviewed scope.

## Readiness Gate

Before reviewing, verify that:

* the target and complete change surface are identifiable;
* security-sensitive contracts and data flows can be inspected;
* roles, ownership, tenancy, and trust boundaries are sufficiently defined;
* relevant configuration, migrations, dependencies, and deployment changes are available;
* safe test environments and representative test identities exist where runtime verification is required;
* the reviewer has no need to expose real secrets or harm real users.

Classify missing prerequisites as:

* **Security blocker** — prevents a trustworthy risk conclusion;
* **Design ambiguity** — security behavior lacks authoritative definition;
* **Evidence limitation** — review can continue with reduced confidence;
* **Specialist dependency** — cryptography, compliance, infrastructure, mobile, hardware, or another area requires qualified review.

## Operating Rules

* Use a risk-based approach: prioritize assets, attack paths, likelihood, and impact.
* Seek practical exploitation paths, not checklist completion alone.
* Distinguish implemented controls from documented intentions.
* Verify enforcement at trusted boundaries.
* Prefer safe, reversible, non-destructive validation.
* Record exact evidence, locations, commands, environments, and assumptions.
* Separate exploitable weaknesses, defense-in-depth gaps, accepted risks, and personal preferences.
* Deduplicate findings by root cause.
* Complete the initial review before modifying any implementation.

## Prohibited Actions

Do not:

* modify code, tests, configuration, infrastructure, or documentation during the initial pass;
* retrieve, print, copy, or expose real secrets unnecessarily;
* access production, real customer data, or privileged accounts without explicit approval;
* perform destructive queries, denial-of-service testing, persistence, data exfiltration, or irreversible external actions;
* bypass authorization beyond the minimum safe proof required;
* trigger real payments, messages, deletions, account recovery, or third-party side effects without approval;
* weaken controls to demonstrate a vulnerability;
* report theoretical concerns without a plausible asset, path, and impact;
* treat scanners or dependency reports as conclusive without validation;
* declare encryption, authentication, authorization, or tenant isolation secure solely from library choice.

## Review Procedure

### 1. Model the Security Context

Identify:

* assets requiring protection;
* users, administrators, services, attackers, support personnel, and third parties;
* trust boundaries;
* entry points;
* privileged operations;
* data flows and storage locations;
* external dependencies;
* security assumptions;
* likely attacker capabilities and motivations.

Assets may include identities, sessions, credentials, personal data, tenant data, payments, files, business rules, availability, audit records, infrastructure, and reputation.

Document abuse cases and misuse paths, not only normal workflows.

### 2. Review Authentication and Identity Lifecycle

Evaluate:

* registration and identity proofing;
* login and credential handling;
* password storage and policy;
* multifactor authentication where required;
* session creation, rotation, expiry, revocation, and fixation;
* remember-me and device behavior;
* logout and global revocation;
* email or phone verification;
* account recovery and reset-token handling;
* identity linking and external providers;
* account disablement, deletion, reactivation, and role lifecycle;
* resistance to enumeration, brute force, credential stuffing, and replay.

Recovery must not be weaker than normal authentication.

### 3. Review Authorization and Isolation

Evaluate:

* authorization at every trusted entry point;
* deny-by-default behavior;
* role and permission calculation;
* object ownership;
* cross-user and cross-tenant access;
* row-level or equivalent data controls;
* privilege escalation;
* role assignment and removal;
* stale authorization after role changes;
* administrative overrides;
* impersonation and delegated access;
* service-to-service privileges;
* confused-deputy risks.

UI hiding, route naming, or client-provided identifiers are not authorization controls.

### 4. Review Input, Output, and Request Handling

Evaluate applicable risks:

* missing server-side validation;
* SQL, command, template, LDAP, NoSQL, or expression injection;
* cross-site scripting;
* cross-site request forgery;
* server-side request forgery;
* path traversal and unsafe file paths;
* unsafe deserialization;
* prototype or object pollution;
* open redirects;
* header injection and response splitting;
* insecure URL, parser, archive, or document handling;
* mass assignment;
* integer, length, encoding, and normalization boundaries;
* unsafe error messages and information disclosure.

Verify validation after decoding and normalization at the system boundary that trusts the value.

### 5. Review Secrets and Cryptography

Evaluate:

* secrets in source, history, logs, artifacts, tests, images, or configuration;
* environment separation and least-privileged credentials;
* secret rotation and revocation;
* encryption in transit and at rest;
* key generation, storage, access, rotation, backup, and destruction;
* use of established cryptographic libraries and safe modes;
* token entropy, expiry, audience, issuer, and purpose binding;
* sensitive logging, telemetry, crash reporting, and support exports.

Custom cryptography or unclear key management requires specialist review.

### 6. Review Privacy and Sensitive Data

Identify personal, financial, authentication, behavioral, location, health, or otherwise sensitive data.

Evaluate:

* necessity and minimization;
* lawful and expected collection;
* purpose limitation;
* consent where applicable;
* retention and automatic deletion;
* user deletion and export;
* backups and delayed deletion;
* masking and access restrictions;
* analytics and telemetry;
* third-party sharing and subprocessors;
* data residency or regulatory constraints;
* production data used in development or testing.

Documentation without enforceable lifecycle controls is insufficient.

### 7. Review Interfaces and Asynchronous Systems

Evaluate:

* APIs and public contracts;
* webhooks and signature verification;
* file uploads, metadata, type validation, malware risk, storage permissions, and serving behavior;
* object storage and signed URLs;
* events, queues, background jobs, schedulers, and dead-letter paths;
* retries, duplicate delivery, ordering, idempotency, and replay;
* integration authentication and credential scope;
* outbound requests, callbacks, redirects, and tenant context;
* partial external side effects and reconciliation.

Assume external input and delivery semantics are hostile or unreliable.

### 8. Review Abuse and Availability

Evaluate:

* rate limits and quotas;
* brute force and enumeration;
* replay and duplicate actions;
* fraud and incentive abuse;
* scraping and automated misuse;
* amplification;
* expensive queries or unbounded work;
* decompression, regex, parser, and file-processing exhaustion;
* queue flooding and job fan-out;
* storage exhaustion;
* lock contention and hot resources;
* degraded dependency behavior;
* safe backpressure, timeouts, circuit breaking, and cancellation.

Security controls must fail predictably without creating a simpler bypass.

### 9. Review Data, Infrastructure, and Supply Chain

Evaluate:

* database credentials and network access;
* parameterized access and privilege separation;
* row-level controls;
* migrations, constraints, backups, restores, and recovery permissions;
* dependency provenance, advisories, integrity, maintenance, and unnecessary packages;
* lockfiles and build reproducibility;
* install scripts and generated artifacts;
* CI/CD tokens, fork permissions, protected environments, and approval boundaries;
* artifact signing or integrity controls where required;
* deployment defaults, debug modes, exposed services, headers, storage, and network configuration.

A vulnerable dependency is actionable only when exposure, reachability, or required policy justifies it.

### 10. Review Administrative and Operational Controls

Evaluate:

* admin tools and hidden operational endpoints;
* impersonation and support access;
* approval requirements for sensitive actions;
* audit-trail completeness and tamper resistance;
* separation of duties;
* monitoring, alerting, and anomaly detection;
* incident investigation data;
* credential and session revocation;
* containment and recovery;
* secure feature flags and emergency controls;
* rollback behavior and data consequences;
* documented incident and disclosure procedures.

Administrative convenience must not bypass ownership, audit, or least privilege silently.

### 11. Evaluate Security Evidence

Inspect:

* unit, integration, contract, end-to-end, authorization, tenant-isolation, migration, and abuse tests;
* static analysis and secret scanning;
* dependency and container scans;
* runtime configuration checks;
* penetration-test or specialist reports when available.

Look for false confidence from:

* tests that only exercise UI restrictions;
* excessive mocking;
* assertions that cannot fail for the intended reason;
* skipped or stale checks;
* scans run against a different revision;
* missing negative cases;
* insecure defaults hidden by test configuration;
* unverified assumptions about frameworks or managed services.

## Findings

Every finding must include:

* **ID and title**
* **Location**
* **Evidence**
* **Affected assets**
* **Attack scenario**
* **Attacker prerequisites**
* **Existing controls**
* **Impact**
* **Likelihood**
* **Severity**
* **Confidence**
* **Recommended mitigation**
* **Compensating controls**
* **Required verification after remediation**
* **Residual risk**

Severity:

* **Critical** — practical path to broad compromise, tenant escape, exposed secrets, irreversible sensitive-data loss, unauthorized privileged control, or catastrophic availability impact.
* **High** — realistic exploitation causing significant confidentiality, integrity, authorization, financial, or recovery failure.
* **Medium** — meaningful weakness requiring additional conditions, limited scope, or partial control failure.
* **Low** — limited exposure or defense-in-depth weakness with low practical impact.
* **Observation** — non-blocking hardening opportunity, assumption, or preference.

Likelihood:

* **High** — readily reachable with common capabilities.
* **Medium** — requires specific conditions or moderate effort.
* **Low** — requires unusual access, timing, or expertise.

Confidence:

* **High** — reproduced or proven directly.
* **Medium** — strongly supported but not fully exercised.
* **Low** — plausible and requiring confirmation.

Do not present a Low-confidence theoretical concern as an exploitable defect.

## Safe Verification Rules

Use the least harmful proof sufficient to establish the risk.

Prefer:

* static tracing;
* isolated test environments;
* synthetic accounts and data;
* non-sensitive canary values;
* bounded requests;
* mocked external side effects only when validating local enforcement.

Stop before extracting real data, obtaining persistence, affecting another tenant, exhausting resources, or crossing an irreversible boundary.

## Stop Conditions and Approval Gates

Stop immediately and escalate when:

* an active secret, private key, token, or credential is exposed;
* a Critical vulnerability is confirmed;
* verification may affect production, real users, billing, or external systems;
* tenant isolation may be broken beyond the safe proof already obtained;
* destructive exploitation would be required;
* evidence suggests active compromise;
* required legal, privacy, compliance, cryptographic, or infrastructure expertise is unavailable.

Do not continue collecting unnecessary proof after severity and remediation are clear.

## Required Output

Create or update the repository’s designated security-review report.

Include:

1. Metadata, revision, target, scope, and independence statement.
2. Assets, actors, entry points, trust boundaries, and threat model.
3. Readiness, assumptions, limitations, and specialist dependencies.
4. Findings ordered by severity and likelihood.
5. Authentication, authorization, data, interface, infrastructure, and operational assessments.
6. Security tests and evidence quality.
7. Exposed secrets or emergency actions, without reproducing secret values.
8. Compensating controls and residual risks.
9. Required remediation, approvals, and re-verification.
10. Final gate.

## Remediation Verification

After fixes:

1. Review the full updated change against the original baseline.
2. Confirm the exact revision.
3. Reproduce each Critical, High, and relevant Medium finding safely.
4. Verify the root cause, not only the demonstrated payload.
5. Test equivalent entry points and bypasses.
6. Confirm no new exposure, regression, or weakened control was introduced.
7. Reassess severity and residual risk.
8. Record accepted risks with approver, justification, expiry, and compensating controls.

Do not mark a finding resolved from a code comment, implementer statement, or unexecuted test.

## Final Gate

Return exactly one outcome:

* **SECURITY APPROVED** — no unresolved exploitable or policy-blocking security risk remains, and required evidence is sufficient.
* **APPROVED WITH CONDITIONS** — no unresolved Critical risk remains; explicitly approved bounded risks or controls remain with owners, deadlines, and re-verification requirements.
* **REMEDIATION REQUIRED** — one or more actionable security findings must be corrected before approval or merge.
* **BLOCKED** — missing evidence, inaccessible systems, conflicting requirements, exposed secrets, unsafe verification conditions, or required specialist review prevents a trustworthy conclusion.

Never return **SECURITY APPROVED** solely because scanners or tests pass, a trusted framework is used, no exploit was attempted, or the reviewer did not find an obvious vulnerability.
