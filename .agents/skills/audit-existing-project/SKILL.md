---
name: audit-existing-project
description: Audit an existing software project to build a verifiable baseline of its product, architecture, code, data, security, operations, quality, and documentation. Use when onboarding AI agents to an existing repository, inheriting a system, resuming an abandoned project, assessing technical debt, preparing a migration, or before implementing major changes. Inspect real behavior, run safe verification, identify divergences among documentation, code, tests, and known production, classify risks, and propose a gradual adoption plan. Must not refactor, modernize, or change system behavior during the audit.
---

# SKILL: Audit Existing Project

---

## PRIORITY PROTOCOL (read first)

The following rules take precedence over any instruction in later stages. If there is a conflict, this section wins.

### RULE-01 — AUDIT, DO NOT REFACTOR

During the entire skill it is **forbidden** to:

- Fix bugs, update dependencies, reorganize folders, rename modules, rewrite tests, migrate technologies, replace architecture, improve style, delete code (even if it appears dead), or change behavior.

**Only allowed:** observe, reproduce, verify, document, classify, recommend.

### RULE-02 — DO NOT TRUST CODE OR DOCUMENTATION WITHOUT VERIFICATION

- Code may contain bugs, dead paths, obsolete rules, or insufficient protections.
- Documentation may be obsolete, incomplete, or contradict the tests.
- **Never claim** that a behavior works solely because a function appears to implement it.
- Seek additional evidence: tests, execution, contracts, cross-references, configuration, history.

### RULE-03 — DO NOT CLAIM VERIFICATION WITHOUT HAVING EXECUTED

Every command must be classified with one of these states:

| Status | Meaning |
|---|---|
| ✅ Verified successfully | Executed and passed |
| ⚠️ Verified with failures | Executed but failed |
| 📋 Identified, not executed | Found but not run |
| 🚫 Blocked by environment | Missing dependency, service, or permission |
| 🗑️ Obsolete | Command no longer works or no longer applies |
| ❓ Unknown | Existence is unknown |
| 🔒 Risky, requires approval | Could affect data, production, or cost |

### RULE-04 — DO NOT JUDGE BY PREFERENCE

Do not classify something as debt only because the agent would have used a different technology, pattern, or style.

A decision is problematic **only if it produces a verifiable impact** on: correctness, security, maintainability, performance, scalability, operations, experience, cost, velocity, or testability.

### RULE-05 — PRIORITIZE RISK OVER AESTHETICS

Immutable priority order:

1. Data loss or exposure
2. Authentication and authorization
3. Tenant isolation
4. Irreversible operations
5. Deployment failures
6. Data integrity
7. Absence of recovery
8. Incorrect behavior
9. Inability to validate changes
10. Maintainability
11. Consistency
12. Style

### RULE-06 — SAFETY IN EXECUTION

**Never execute** commands that: delete data, modify production, publish packages, deploy, rotate secrets, migrate shared databases, delete resources, force-push, alter remote branches, incur cost, contact real users, send email, execute payments, or process real webhooks.

### RULE-07 — DO NOT SHOW SECRETS IN THE REPORT

If an exposed credential is detected: record type, location, severity, and required action. **Redact the value.** Example:

> An apparently active credential was detected in `config/credentials.json`. The value was deliberately omitted. Action: revoke, rotate, remove from history.

### RULE-08 — STOP CONDITIONS (halt execution, continue documentation)

Stop executable actions immediately when:

- Productive credentials are found exposed
- It cannot be assured that a command will not affect production
- A destructive migration is found connected to shared data
- The local environment uses real services without isolation
- A script requires elevated privileges
- A test could send real payments, emails, or messages
- A possible security compromise is detected
- The repository contains real personal data
- A command implies significant cost

**Action:** stop the command → retain safe evidence → hide sensitive data → document the risk → recommend action → continue with unaffected areas.

---

## EVIDENCE CLASSIFICATION (use for every finding)

| Level | Name | Meaning |
|---|---|---|
| E0 | Unknown | Insufficient information exists |
| E1 | Inferred | Deduced from names, structure, or patterns; not confirmed |
| E2 | Documented | Explicit documentation exists; not verified against the system |
| E3 | Implemented | Code exists that appears to implement the behavior |
| E4 | Tested | A test exists that validates the behavior |
| E5 | Reproduced | The behavior was executed and observed in a controlled environment |
| E6 | Observed | Reliable operational evidence exists (metrics, logs, incidents) |

**Rule:** A high-criticality claim is not considered confirmed with E1 or E2 evidence alone.

---

## FINDING SEVERITY

| Level | Meaning | Action |
|---|---|---|
| **P0** — Emergency | Exposed secret, public data, active loss, auth bypass, broken tenants, compromise in progress | Stop normal work immediately |
| **P1** — Blocking | Insufficient authorization, destructive migration, no backup, setup against production, broken CI | Resolve before next delivery |
| **P2** — Important | Structural debt with impact, incomplete observability, partial tests, obsolete docs | Plan in the roadmap |
| **P3** — Improvement | Consistency, minor automation, secondary docs, local simplifications | Opportunistic |
| **P4** — Informational | Context or recommendation with no immediate risk | Record, do not act |

---

## DECISION TREE: WHICH DEPTH TO CHOOSE

```
Is this the first time an agent touches this repo?
  ├── YES → Is the project large (monorepo, >5 services, >500 source files)?
  │         ├── YES → STANDARD AUDIT with a layered deepening plan
  │         └── NO  → Full STANDARD AUDIT
  └── NO  → Does a partial baseline already exist?
            ├── YES → FOCUSED AUDIT on uncovered areas
            └── NO  → Is it urgently needed?
                      ├── YES → QUICK AUDIT (setup + commands + auth + P0/P1 risks)
                      └── NO  → DEEP AUDIT
```

---

## EXECUTION PLAN BY DEPTH

### Quick audit

Execute **PHASE 0 → PHASE A → PHASE B → PHASE H** (see matrix below). Target time: complete in one session.

**Minimum deliverable:** `docs/audit/audit-report.md` with: executive summary, verified commands, auth/permissions baseline, P0/P1 risks, blocking unknowns, immediate adoption plan.

### Standard audit

Execute **PHASE 0 → PHASES A–G → PHASE H**. Covers all phases at a depth proportional to project size.

**Deliverable:** file structure under `docs/audit/` according to project size.

### Deep audit

Execute **all phases** at maximum depth. Includes: detailed module map, contract review, historical migrations, Git hotspots, complete debt and risk registers.

### Focused audit

Execute **PHASE 0 + only the phases indicated by the user** for the specific area.

---

## AUDIT PHASES

### PHASE 0 — PREPARATION AND CONTEXT

**Objective:** Establish scope and constraints without modifying anything.

**Mandatory actions:**

1. Read available `AGENTS.md`, `README.md`, and `docs/`.
2. Identify the current branch. Confirm it is not a protected branch.
3. Review `git status`. If there are uncommitted changes: **record them, do not modify them, isolate them from the baseline.**
4. Classify repository type: single application, monorepo, library, backend, frontend, distributed system, infrastructure, mobile, plugin, data/ML, embedded, multi-repo.
5. Select depth using the decision tree.
6. Record: branch, commit, scope, environment limitations, date.

**Edge-case handling:**

| Scenario | Action |
|---|---|
| No Git (new repo, ZIP) | Document absence. Use a content hash as reference. |
| CI/CD in a separate repo | Register the external repo as a dependency; document what is visible. |
| No package manager (loose scripts) | Inventory scripts manually; document absence of a package manager. |
| Multiple repositories form the product | Audit the current repo. Document cross-repo dependencies as external integrations. |

**Output:** `Audit Scope` section in the report.

---

### PHASE A — REPOSITORY AND REPRODUCIBILITY

Groups: repository inventory, commands, environment, dependencies, configuration, and secrets.

#### A.1 Structural inventory
- Root files, package managers, workspaces, applications, packages, services, libraries, scripts, infrastructure, documentation, tests, fixtures, migrations, schemas, generated artifacts, assets, configurations, workflows, tools.
- **Do not mark as obsolete without evidence.** Do not assume that `legacy/` is unused.
- Identify: languages, frameworks, runtimes, package managers, build systems, format/lint/test frameworks, CI, containers, providers, databases.
- For systems without a package manager, inventory manual build scripts.

#### A.2 Verifiable commands
- Search for commands in: `package.json`, `Makefile`, `Taskfile`, `justfile`, scripts, Docker Compose, docs, CI, IDE configuration.
- Classify by type: install, dev, build, lint, format, typecheck, test (unit/integration/e2e), generate, migration, seed, deploy, smoke test, security.
- Execute safely (see RULE-06): install with lockfile, lint/format (check mode), typecheck, tests, build.
- **Do not run automatically:** destructive seeds, migrations against a shared DB, deploy, publish, scripts named `reset`, `clean`, `destroy`, `prod` without prior inspection.

**For each command, document:**

| Command | Purpose | Status | Result | Duration | Dependencies | Risk |
|---|---|---|---|---|---|---|

**Critical rule for `AGENTS.md`:** do not write commands as valid without having executed them or without explicitly marking that they were not verified.

#### A.3 Environment reproducibility
Evaluate: pinned runtime versions, versioned lockfiles, required environment variables, required services (DB, cache, queue, storage, emulators), local vs CI configuration, OS differences, system tools, ports, volumes, seeds, minimum data.

**Key questions:**
- Is installation deterministic?
- Are there undocumented global dependencies?
- Can it run without production secrets?
- Is the local database isolated?
- Is there a safe reset procedure?
- Can a test user be created?

**Output:** verified setup guide.

#### A.4 Dependencies
Classify: runtime, development, build, testing, infrastructure, external provider, internal, critical transitive.

Evaluate: version, actual usage, maintenance, license, known vulnerabilities, duplication, deprecated APIs, upgrade risk, lockfile, code that reimplements a dependency, dependency without abstraction.

**Caution:** a package listed but not imported is not proof it is unused (it may be a CLI, plugin, dynamic load, peer dependency, or build tool).

#### A.5 Configuration and secrets
Review: `.env.example`, tracked `.env` files, per-environment configuration, CI secrets, Docker, infrastructure, credentials, tokens, certificates, hardcoding, URLs, CORS, cookies, headers, storage.

**Checks:** versioned secrets, production values in code, undocumented variables, insecure defaults, inconsistent configuration across environments, secrets exposed to the client, logging of secrets, real data in fixtures.

**Apply RULE-07:** redact any sensitive value detected.

---

### PHASE B — PRODUCT AND UX

**Objective:** Document what product actually exists, contrasting documentation, code, and observable behavior.

**Sources:** docs, routes, screens, endpoints, models, tests, seeds, feature flags, navigation, permissions, integrations, copy, analytics, billing, onboarding.

**Distinguish explicitly:**

| Type | Definition |
|---|---|
| Expected behavior | What the business believes it does |
| Documented behavior | What the documentation says it does |
| Implemented behavior | What the code appears to do |
| Tested behavior | What the tests validate |
| Reproduced behavior | What was observed when executing |
| Divergences | Differences among the above |

**Identify:** actors, roles, capabilities, main flows, entities, rules, states, limits, monetization, incomplete/hidden/abandoned features, flags, administrative operations.

**Divergence signals:** screen without endpoint, endpoint without consumer, model without use, tests for undocumented behavior, permanent feature flag, copy that promises something not implemented, docs with nonexistent modules, migrations for removed features, multiple implementations of the same flow.

**Do not reconstruct the product solely from file names.**

---

### PHASE C — ARCHITECTURE

**Objective:** Represent the architecture as it exists.

**Document:** context, applications, services, packages, modules, boundaries, dependencies, data flows, synchronous/asynchronous processes, storage, integrations, infrastructure, entry points.

**For each critical component:**

- Responsibility
- Public interfaces
- Dependencies
- Data it owns
- External systems
- Runtime
- Failure impact
- Tests
- Observability
- Evidence (level E0–E6)
- Unknowns

**Detect:** circular dependencies, modules with too many responsibilities, business rules in the UI, duplicated rules, infrastructure coupling, cross-cutting database access, implicit contracts, global utilities without ownership, critical components without tests, boundaries that exist only as folders.

**Do not recommend microservices** only because a module is large. First evaluate: cohesion, coupling, change frequency, ownership, independent scalability, failure isolation, operational complexity.

---

### PHASE D — DATA, MIGRATIONS, AND PERSISTENCE

#### D.1 Data model
Review: schemas, models, migrations, constraints, indexes, relationships, enums, triggers, views, policies, seeds, repositories, queries, transactions, files, caches, search, derived data, external storage.

**Document:** data stores, main entities, ownership, relationships, constraints, lifecycle, retention, sensitive fields, derived data, search/indexing, backups, restore procedure, known risks.

**Evaluate:** PKs, FKs, unique constraints, nullability, defaults, states, timestamps, soft/hard delete, cascades, tenant keys, audit, consistency, idempotency, concurrency, transactions, referential integrity, time zones, currency, decimal precision, personal data, orphan files.

**Critical questions:** Which data belongs to each tenant? How is cross-access prevented? Is ownership explicit? What happens when an account is deleted? Can it be restored? Are backups tested?

#### D.2 Migrations
Evaluate: order, consistency, missing migrations, migrations edited after application, schema vs migration differences, destructive operations, renames, backfills, defaults, locks, duration, rollback, compatibility, dependent seeds.

**Classify each risky migration:** additive, compatible, potentially blocking, destructive, irreversible, data-dependent, code-dependent, unknown.

**Look for:** `DROP`, type changes, constraint removal, `NOT NULL` without backfill, large indexes, table rewrites, migrations that mix schema and business logic, unversioned manual scripts.

**Do not apply migrations during the audit** except against an ephemeral database created specifically for validation and with explicit approval.

---

### PHASE E — SECURITY, IDENTITY, AND ISOLATION

#### E.1 Authentication
Review: registration, login, logout, sessions, refresh, cookies, tokens, external providers (OAuth, SAML, SSO), recovery, verification, MFA, email/password change, revocation, expiration, impersonation, service accounts.

**Evaluate:** overly long sessions, tokens in insecure storage, cookies without flags (`HttpOnly`, `Secure`, `SameSite`), weak recovery, lack of revocation, user enumeration, login CSRF, open redirects, shared credentials, development bypasses, environments that share identity.

#### E.2 Authorization
Review authorization in: UI, middleware, routes, controllers, services, repositories, database, storage, jobs, webhooks, administration, exports, files.

**Key questions:**
- Does the UI hide or actually prevent?
- Is authorization always verified server-side?
- Are resources loaded with tenant scope?
- Is ownership validated on every operation?
- Are IDs guessable?
- Do jobs revalidate permissions?
- Can webhooks modify any account?
- Is revocation immediate?
- Are there implicit permissions by role name?

**Produce matrix:** Resource × Action × Actor × UI control × Server control × Data control × Test.

**Critical finding:** hiding a button is not authorization.

#### E.3 Multitenancy
Identify model: separate database, separate schema, shared tables with tenant key, row-level security, service isolation, combination.

**Review:** tenant resolution, context switching, queries, caches, storage, jobs, queues, search, exports, logs, analytics, webhooks, administration, invitations, transfers, deletion, backups.

**Classify isolation:** verified, partial, implicit, not verified, critical risk.

#### E.4 General security (baseline review)
Surfaces: authentication, authorization, sessions, data, APIs, uploads, webhooks, dependencies, configuration, secrets, frontend, SSR, administration, infrastructure, CI, logs, jobs.

**Review:** input validation, output encoding, injection (SQL, NoSQL, command), XSS, CSRF, SSRF, path traversal, file uploads, deserialization, open redirects, rate limiting, brute force, enumeration, replay, IDOR, privilege escalation, tenant isolation, error exposure, secrets, cloud permissions, supply chain.

**Do not run destructive exploits.** Tests must be safe and limited to the authorized environment.

---

### PHASE F — APIS, INTEGRATIONS, AND ASYNCHRONOUS PROCESSES

#### F.1 APIs and contracts
Include: REST, GraphQL, RPC, server actions, webhooks, events, queues, files, SDK, inter-package contracts, internal APIs, frontend interfaces.

**For each contract:** consumer, provider, auth, input/output, errors, versioning, idempotency, rate limiting, compatibility, tests, evidence.

**Detect:** implicit contracts, inconsistent responses, errors that leak internal details, endpoints without authorization, unused endpoints, unknown consumers, excessive payloads, validation duplication.

#### F.2 External integrations
Identify: payments, email, SMS, auth providers, storage, maps, analytics, search, AI, CRM, ERP, inbound/outbound webhooks, public APIs, internal services, cloud providers.

**For each integration:** purpose, provider, direction (inbound/outbound/bidirectional), credentials, data exchanged, sensitive data, availability assumptions, timeout, retry, idempotency, rate limits, failure behavior, reconciliation, sandbox, monitoring, ownership, exit strategy.

**Key questions:** What happens if the provider is down? Is retry idempotent? Is there reconciliation? Are signatures verified? Is there replay protection? Are sensitive payloads logged? Do tests call real services? Is there lock-in?

#### F.3 Asynchronous processes
Review: cron, workers, queues, retries, dead letters, schedulers, domain events, integration events, webhooks, file processing, notifications.

**Evaluate:** idempotency, retries with backoff, duplicates, ordering, locks, concurrency, timeouts, poison messages, observability, recovery, cancellation, deployments, payload versioning.

**Common findings:** job without retry limit, non-idempotent effects, cron run by multiple instances, unversioned events, silent errors, queue without dead-letter, payloads with sensitive data.

---

### PHASE G — QUALITY, CI/CD, AND OPERATIONS

#### G.1 Testing
Inventory: unit, integration, contract, e2e, visual, accessibility, performance, security, migrations, smoke, snapshots, documented manual tests.

**Evaluate:** which behaviors they cover, which criticalities they do not cover, stability, isolation, fixtures, mocks, speed, flakiness, external dependencies, assertion quality, false positives, disabled tests, meaningful coverage (not only line %).

**Questions:** Can tests fail for the right reason? Do they test behavior or implementation? Are permissions and cross-access tested? Are migrations tested? Are errors and retries tested? Can e2e run locally?

**Classify areas:** well protected, partially protected, superficial coverage, unprotected, unknown.

#### G.2 Build and CI
Review build: compilation, bundling, client/type generation, codegen, containers, artifacts, assets, caches, clean build, determinism.

Review CI: triggers, permissions, jobs, matrices, caching, secrets, artifacts, conditions, branches, environments, approvals, timeouts, concurrency, required checks.

**Common risks:** green CI without running relevant tests, optional jobs, non-required checks, excessive permissions, secrets available on fork PRs, automatic deploy without a gate, `continue-on-error` hiding failures.

#### G.3 Deployment and release
Document: environments, provider, artifacts, pipeline, owners, approvals, migrations, feature flags, smoke tests, rollback, rollforward, versioning, changelog, post-deploy monitoring.

**Classify:** automated and verified, partially automated, documented manual, undocumented manual, unknown, risky.

#### G.4 Observability
Evaluate: logs, metrics, traces, error tracking, health checks, dashboards, alerts, audit, correlation IDs, structured logging, retention, redaction of sensitive data, ownership, runbooks.

**Critical findings:** secrets in logs, unredacted personal data, silent errors, total absence of monitoring, alerts without an owner, logs impossible to correlate, missing audit on administrative actions.

#### G.5 Operations and support
Review: admin panel, internal tools, runbooks, support, account recovery, data correction, moderation, reconciliation, export, deletion, disputes, fraud, incidents, maintenance.

**Identify:** dangerous operations in informal scripts, knowledge residing in a single person, undocumented manual tasks.

---

### PHASE H — CONSOLIDATION AND PLAN

#### H.1 Technical debt
Record debt with **concrete impact**, not vague labels ("ugly code", "bad architecture").

For each item: category, evidence, current impact, future impact, probability, severity, estimated effort (XS–XL), remediation, dependencies, remediation risk, suggested timing.

#### H.2 Product debt
Detect: incomplete flow, incorrect copy, incoherent permissions, functionality without a clear user, missing administrative process, unrepresented state, feature without metrics, blocked onboarding, unimplemented promise, actions without recovery.

#### H.3 Risk register
Categories: product, security, privacy, data, architecture, operations, availability, integrations, dependency, performance, scalability, testing, deployment, compliance, knowledge.

**For each risk:** description, evidence, probability, impact, detectability, current controls, missing controls, mitigation, contingency.

#### H.4 Unknowns
Explicitly record what is not known. Categorize as: product, users, data, production, security, costs, volume, integrations, infrastructure, operations, compliance, ownership.

**"Unknown" is a valid result.** Do not replace ignorance with false confidence.

#### H.5 Agent readiness (Level 0–5)

| Level | Description | Minimum requirements |
|---|---|---|
| 0 — Not prepared | No commands, tests, or isolation | — |
| 1 — Exploration | Read-only and documentation | Repo access |
| 2 — Supervised changes | Small tasks with review | Reproducible setup, basic checks |
| 3 — Branch autonomy | Implementation with PR | Tests, CI, instructions, worktrees |
| 4 — Operational autonomy | Previews, smoke tests, rollback | Observability, staging, human gates |
| 5 — High automation | Mature processes | Validations, progressive releases, incident response |

#### H.6 Gradual adoption plan (Phases A–F)

- **Phase A — Basic security:** remove exposed secrets, protect branches, document commands, avoid production access.
- **Phase B — Reproducibility:** pin runtimes, isolate environment, `.env.example`, test data.
- **Phase C — Verification:** lint, typecheck, build, stabilize tests, CI, smoke tests.
- **Phase D — Source of truth:** `AGENTS.md`, `project-status.md`, architecture baseline, ADRs.
- **Phase E — Agent work:** branches, small tasks, vertical slices, PR, independent review.
- **Phase F — Operational maturity:** observability, staging, rollback, safe migrations, feature flags, runbooks.

#### H.7 Audit outcome

| Outcome | When to use it |
|---|---|
| **BASELINE ESTABLISHED** | Setup works (or limitations are clear), commands identified, architecture mapped, critical risks identified, unknowns recorded, adoption plan exists. |
| **PARTIAL BASELINE** | Areas partially verified, access limitations, missing environments, important unknowns; progress possible in limited areas. Specify which areas are safe. |
| **BLOCKED** | Inspection impossible, setup impossible without information, exposed secrets require immediate action, risk of affecting production, data could be lost, evidence of compromise. |

Before marking `BLOCKED`, complete all safe inspection possible.

#### H.8 Final documentation

**`AGENTS.md`** — Include only: brief purpose, sources of truth, relevant structure, proven commands, workflow, restrictions, required approvals, definition of done, security rules. **Do not include:** theories, unverified commands, secrets, preferences without impact.

**`docs/project-status.md`** — Format:

```markdown
# Project Status
## Current phase — Existing project baseline
## Audit status — Complete | Partial | Blocked
## Verified commands
## Critical risks
## Critical unknowns
## Blocking remediation
## Agent readiness level
## Recommended next action
## Recommended skill
```

**Audit file structure:**

```
Small project  → docs/audit/audit-report.md
Medium project → docs/audit/{executive-summary, product-baseline, architecture-baseline,
                   data-baseline, security-baseline, testing-baseline, risk-register, adoption-plan}.md
Monorepo/large → docs/audit/index.md + sub-audits per component/application
```

---

## FINDING FORMAT (use consistently)

```markdown
## [P1] Finding title

### Area
Security | Data | Architecture | Testing | Operations | Product

### Description
What is happening.

### Evidence
- Component/file:
- Reference:
- Command executed (if applicable):
- Result:
- Evidence level: E0-E6
- Confidence: High | Medium | Low

### Impact
What could happen and who is affected.

### Scenario
How it manifests.

### Recommendation
What should be done.

### Timing
Immediate | Before next change | Planned | Opportunistic
```

---

## EXECUTIVE SUMMARY FORMAT (report to the user)

```markdown
# Audit Existing Project — Result

## Status
BASELINE ESTABLISHED | PARTIAL BASELINE | BLOCKED

## Summary
Main conclusion in 2–3 sentences.

## Agent readiness level
Level X — brief description.

## Critical findings (P0/P1)
1. [P0] ...
2. [P1] ...

## Verifications executed
- ✅ command: result
- ⚠️ command: result with failures
- 📋 command: identified, not executed (reason)

## Areas not verified
1. Area — reason
2. Area — reason

## Documents created or updated
- `path`
- `path`

## Immediate actions
1. ...
2. ...

## Recommended next stage
Description and recommended skill (`skill-name`).
```

**Do not include:** secrets, tokens, personal data, sensitive payloads.

---

## HOW TO INVOKE THIS SKILL

### Standard audit (recommended for first contact)

```text
Run the audit-existing-project skill on this repository in standard mode.

First read AGENTS.md, README.md, docs/, and project configuration.

Do not refactor, do not update dependencies, do not change behavior,
do not apply migrations, do not access production.

Run safe local verifications and update documentation.

Explicitly distinguish: documented, implemented, tested, reproduced,
inferred, and unknown.

When finished, update docs/project-status.md and deliver a gradual plan.
```

### Quick audit

```text
Run audit-existing-project in quick mode.

Prioritize: setup, commands, architecture, data, auth/permissions, tests,
P0/P1 risks, agent readiness.

Do not modify code.
```

### Deep audit

```text
Run audit-existing-project in deep mode.

Include: module map, contracts, migrations, multitenancy,
integrations, asynchronous processes, CI/CD, observability, security,
privacy, operations, Git hotspots, complete risk and debt registers.

Do not perform remediations.
```

### Focused audit

```text
Run audit-existing-project only on [area or module].

Evaluate dependencies and cross-cutting effects, but do not expand to the rest
of the repository unless there is direct risk.
```

---

## FINAL RULE

The audit must leave the project **more understandable and safer to change**, without turning discovery into a covert refactor.

The correct result **is not:** "The project should be rewritten."

The correct result **is:** "This is the system that exists, this is the available evidence, these are its risks, these areas can be changed safely, and this is the incremental path to improve the rest."
