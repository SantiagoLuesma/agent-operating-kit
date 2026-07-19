---
name: verify-acceptance-criteria
description: Independently verify whether an implemented change satisfies every approved acceptance criterion using executed, criterion-specific evidence.
---

# Verify Acceptance Criteria

## Purpose

Independently determine whether an implemented change satisfies every approved acceptance criterion at a fixed repository revision.

Verification must examine actual behavior, implementation, contracts, data, permissions, documentation, and failure modes as applicable. Passing tests and the implementing agent’s report are inputs, not proof.

This skill verifies. It does not silently reinterpret criteria, fix defects during the initial verification pass, approve unrelated risks, merge, or release the change.

## Independence Requirement

Verification must be performed by an agent or session that did not implement the change and does not depend on the implementing agent’s chat history.

Use repository sources, executed commands, direct observations, and reproducible evidence. Treat implementation reports as untrusted claims until independently confirmed.

Prefer a clean worktree or checkout of the exact revision under review.

## Required Inputs

Read, in precedence order:

1. `AGENTS.md` and applicable nested instructions.
2. Approved feature specification and acceptance criteria.
3. Active ExecPlan, including scope, non-goals, validation matrix, decisions, and deviations.
4. Relevant UX, architecture, quality-attribute, ADR, contract, data, and permission documentation.
5. Implementation handoff and implementer-provided evidence.
6. The complete change diff, commit history, tests, migrations, configuration, and operational documentation.
7. `docs/project-status.md` and known baseline failures.

Record the authoritative source and identifier for every criterion.

## Verification Scope

Define:

* change, branch, worktree, and exact revision under review;
* comparison baseline;
* included acceptance criteria;
* approved non-goals and excluded behavior;
* affected actors, roles, tenants, modules, contracts, data, and environments;
* validation environments and test data;
* checks that cannot be executed and why.

Do not verify a moving branch without recording the final revision. Evidence from another revision is stale unless reproduced.

## Readiness Gate

Before verification, confirm that:

* acceptance criteria are approved, identifiable, and versioned;
* the implementation revision is available and sufficiently stable;
* the complete diff can be inspected;
* required services, credentials, fixtures, and environments are available;
* relevant commands are known or discoverable from repository sources;
* migrations and generated artifacts are present when applicable;
* pre-existing failures are documented or can be baselined;
* the verifier is independent from the implementer.

Classify readiness problems as:

* **Criterion defect** — ambiguous, contradictory, obsolete, untestable, or missing authority;
* **Environment blocker** — required system, data, credential, or platform is unavailable;
* **Evidence gap** — a claim lacks a reproducible validation method;
* **Verification limitation** — partial verification is possible, but confidence is constrained.

Do not silently resolve criterion defects.

## Operating Rules

* Verify every criterion individually.
* Seek disconfirming evidence, not only confirmation.
* Prefer observable behavior over implementation intent.
* Execute relevant checks independently.
* Inspect whether tests exercise the real changed path.
* Verify permissions at trusted boundaries, not only in the UI.
* Distinguish product acceptance from code quality and broader change review.
* Record exact commands, environment, revision, inputs, outputs, and observations.
* Separate pre-existing failures from regressions introduced by the change.
* Continue verifying unaffected criteria when one criterion is blocked, unless safety requires stopping.
* Make no implementation changes during the initial verification pass.

## Prohibited Actions

Do not:

* accept the implementing agent’s report as sufficient evidence;
* mark a criterion satisfied solely because a test with a similar name passes;
* rewrite, weaken, combine, split, or remove acceptance criteria;
* declare a criterion obsolete without an approved superseding source;
* fix implementation defects during the initial verification pass;
* change expected outputs or snapshots to match observed defects;
* disable, skip, quarantine, or bypass checks;
* add mocks that conceal missing behavior;
* ignore unauthorized, failure, recovery, compatibility, or excluded-scope behavior;
* use stale evidence from a different revision;
* claim runtime verification when only code inspection occurred;
* infer completion from file presence or code paths that were not exercised.

## Evidence Classification

Classify every evidence item as:

* **Automated evidence** — an independently executed test, check, benchmark, or deterministic command with captured result.
* **Manual evidence** — a reproducible human-observed procedure with exact steps, inputs, environment, and expected observations.
* **Inferred evidence** — a conclusion derived from code, configuration, schema, or documentation inspection without exercising behavior.
* **Missing evidence** — required verification was not provided or executed.
* **Unverifiable claim** — the claim cannot be reliably tested or inspected with available authority, environment, or observability.

Inferred evidence may support a conclusion but must not be the sole basis for runtime, security-boundary, migration, concurrency, recovery, accessibility, or integration claims when direct verification is feasible.

## Verification Procedure

### 1. Establish the Baseline

Record:

* baseline and candidate revisions;
* branch and worktree state;
* changed files and commits;
* environment and dependency versions;
* relevant baseline command results;
* pre-existing failures;
* feature flags, migrations, and configuration needed to expose the behavior.

Confirm the evidence corresponds to the candidate revision.

### 2. Build the Criterion Inventory

Copy each approved criterion verbatim into a verification matrix and assign a stable identifier.

For each criterion identify:

* actor and preconditions;
* trigger or operation;
* expected observable behavior;
* applicable roles, tenants, states, and boundaries;
* relevant non-goals;
* required evidence;
* source and approval status.

Do not “clarify” wording by changing it. Record interpretations separately and mark material uncertainty as blocked.

### 3. Trace Criteria to the Change

For every criterion trace:

* implementation paths and symbols;
* UI surfaces;
* application or domain logic;
* APIs, commands, events, queues, or integrations;
* data models, migrations, indexes, and ownership;
* authentication, authorization, and tenant enforcement;
* tests and fixtures;
* documentation, telemetry, and operational procedures.

Missing implementation traceability is a finding even when a broad end-to-end test passes.

### 4. Assess Existing Tests and Claims

Inspect implementer-provided tests and evidence for false confidence.

Look for:

* tests that do not execute the changed path;
* assertions that cannot distinguish correct from incorrect behavior;
* tests that mirror implementation details rather than requirements;
* excessive mocking of the system or contract being verified;
* wrong roles, tenants, fixtures, or feature-flag states;
* swallowed exceptions or assertions after unreachable code;
* snapshots accepted without behavioral review;
* skipped, focused-only, quarantined, flaky, or conditionally disabled tests;
* stale caches, generated files, or results from another revision;
* tests that pass before the change or for the wrong reason;
* checks that assert status only while ignoring data or side effects;
* UI tests that confirm rendering but not user behavior;
* retries that hide deterministic failures.

Use negative controls, alternate inputs, direct state inspection, or existing mutation-testing facilities when safe and available. Do not add dependencies or modify production behavior merely to prove a test is weak.

### 5. Design Verification Scenarios

For each applicable criterion verify:

* positive or happy path;
* invalid input and validation boundaries;
* minimum, maximum, empty, missing, duplicate, stale, and malformed values;
* unauthenticated and unauthorized actors;
* cross-user and cross-tenant isolation;
* not-found, conflict, timeout, partial failure, and dependency failure;
* retry, cancellation, rollback, restart, and recovery;
* concurrent execution, races, ordering, and duplicate delivery;
* idempotent repeated requests or events;
* backward and forward compatibility;
* legacy or mixed-version behavior;
* keyboard, focus, semantics, assistive technology, and responsive behavior;
* performance or capacity thresholds;
* logging, audit, metrics, traces, and sensitive-data handling.

Mark scenarios non-applicable only with a documented reason.

### 6. Execute Independent Verification

Run the smallest reliable checks first, then broader checks needed to demonstrate complete behavior.

Use, as applicable:

* formatting, linting, type, schema, and build checks;
* unit, integration, contract, end-to-end, migration, and smoke tests;
* direct API, event, queue, database, or integration verification;
* runtime UI workflows;
* permission and tenant-isolation checks;
* accessibility tooling and manual keyboard inspection;
* security, compatibility, performance, and recovery procedures;
* data and side-effect inspection before and after operations.

Capture commands, exit codes, relevant output, test data, timestamps, artifacts, and observed state.

### 7. Check Regressions and Excluded Scope

Verify that:

* related existing behavior still works;
* public contracts and stored data remain compatible as approved;
* unrelated roles and tenants are unaffected;
* failures do not leave corrupt or partial state;
* excluded behavior was not implemented;
* unrelated refactors, dependencies, configuration, or permissions were not introduced;
* feature flags and defaults do not expose unfinished behavior.

Scope expansion is a finding even when the added behavior appears useful.

### 8. Inspect Documentation Consistency

Confirm that feature documentation, contracts, permissions, migration instructions, operational procedures, and ExecPlan status describe implemented reality.

Documentation cannot prove behavior, but contradictions may invalidate handoff, operation, or acceptance.

## Criterion-by-Criterion Matrix

Produce a matrix containing:

| Field                | Required content                                                               |
| -------------------- | ------------------------------------------------------------------------------ |
| Criterion            | Identifier and verbatim approved text                                          |
| Source               | Authoritative path and section                                                 |
| Status               | Verified, Conditionally Verified, Not Satisfied, Blocked                       |
| Implementation trace | Relevant paths, symbols, contracts, and data                                   |
| Scenarios            | Positive, negative, boundary, permission, recovery, and other applicable cases |
| Evidence             | Type, command or procedure, revision, environment, and result                  |
| Evidence quality     | Strong, Limited, Missing, or Unverifiable                                      |
| Findings             | IDs and severities                                                             |
| Residual risk        | Remaining uncertainty and impact                                               |
| Required action      | None, fix, clarification, approval, or re-verification                         |

No criterion may be omitted or represented only by a global test result.

## Defective Acceptance Criteria

When a criterion is:

* **Ambiguous:** record plausible interpretations and request authoritative clarification.
* **Contradictory:** cite the conflicting criteria or sources and block affected conclusions.
* **Obsolete:** require an approved superseding decision before excluding it.
* **Untestable:** identify the missing observable outcome or validation mechanism.
* **Impossible in the available environment:** distinguish environment limitation from implementation failure.
* **Partially applicable:** require approval before narrowing its scope.

Do not fail the implementation for an unresolved specification defect unless observed behavior clearly violates an authoritative interpretation. Mark verification blocked for the affected criterion.

## Findings and Severity

Record each finding with:

* identifier;
* affected criterion;
* evidence;
* expected and observed behavior;
* impact;
* severity;
* confidence;
* reproduction steps;
* required disposition.

Severity:

* **Critical** — security breach, tenant escape, destructive corruption, irreversible loss, or unsafe release condition.
* **High** — core criterion fails, unauthorized behavior succeeds, contract breaks, or recovery is unsafe.
* **Medium** — important boundary, failure, compatibility, accessibility, or operational behavior is incomplete.
* **Low** — limited defect with minor impact or weak evidence that does not invalidate core behavior.
* **Observation** — non-blocking concern or improvement outside acceptance.

## Stop Conditions and Approval Gates

Stop immediately when verification risks production, user data, secrets, billing, external side effects, or irreversible operations.

Require approval before:

* accessing production;
* running destructive migrations or recovery procedures;
* modifying secrets or real user data;
* triggering billable or irreversible integrations;
* changing criteria or approved scope;
* accepting Critical or High residual risk;
* treating an unverifiable criterion as satisfied.

Do not stop for safe, reversible verification activities within the approved environment.

## Required Output

Create or update a verification report in the repository’s designated review location.

Include:

1. Metadata, revisions, environment, and independence statement.
2. Scope, non-goals, sources, and baseline.
3. Readiness assessment and limitations.
4. Criterion-by-criterion verification matrix.
5. Commands and procedures executed.
6. Regression and excluded-scope results.
7. Findings ordered by severity.
8. Ambiguous, contradictory, obsolete, or untestable criteria.
9. Evidence gaps and unverifiable claims.
10. Residual risks and required approvals.
11. Final gate and re-verification requirements.

Update the ExecPlan and project status only with verification state and evidence. Do not mark implementation defects resolved unless a later revision is independently re-verified.

## Final Gate

Return exactly one outcome:

* **PASS — ACCEPTANCE VERIFIED** — every criterion is independently verified with sufficient current evidence, excluded scope remains excluded, and no unresolved acceptance-blocking finding remains.
* **CONDITIONAL PASS** — core behavior is verified, and only explicitly approved, non-critical limitations remain with owners, deadlines, and re-verification requirements.
* **FAIL — ACCEPTANCE NOT SATISFIED** — one or more criteria are disproven, a regression is confirmed, or unauthorized/out-of-scope behavior invalidates acceptance.
* **BLOCKED — VERIFICATION INCOMPLETE** — criteria, environment, authority, or evidence prevent a reliable conclusion.

The final report must state:

* outcome;
* candidate and baseline revisions;
* criteria verified, conditional, failed, and blocked;
* highest-severity findings;
* executed evidence and limitations;
* regressions and scope deviations;
* approvals required;
* exact fixes or clarifications needed;
* criteria requiring re-verification.

Never return **PASS — ACCEPTANCE VERIFIED** based solely on passing tests, implementer claims, inferred evidence, or checks that were not executed against the final revision.
