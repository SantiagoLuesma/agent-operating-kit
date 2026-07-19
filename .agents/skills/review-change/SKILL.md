---
name: review-change
description: Independently and adversarially review a complete implemented change for correctness, safety, scope compliance, architecture, test quality, and merge readiness without modifying code during the initial pass.
---

# Review Change

## Purpose

Perform an independent, evidence-based, adversarial review of an implemented change against its approved scope, feature specification, architecture, acceptance criteria, execution plan, and repository standards.

Review the complete change, not only highlighted files or the implementing agent’s summary. Search for defects, regressions, missing behavior, unsafe assumptions, accidental complexity, and operational risk.

This skill reviews and reports. It does not modify code during the initial review pass, silently reinterpret requirements, approve its own implementation, merge, or release the change.

## Independence Requirement

The reviewer must not be the sole implementing agent and must not rely on implementation chat history.

Use repository documentation, the complete diff, direct inspection, independently executed validation, and reproducible evidence. Treat implementation reports and existing test results as claims until verified.

Prefer a clean worktree or checkout of the exact candidate revision.

## Required Inputs

Read, in precedence order:

1. `AGENTS.md` and applicable nested instructions.
2. Approved scope, non-goals, feature specification, and acceptance criteria.
3. Relevant feature, architecture, UX, quality-attribute, and ADR documentation.
4. Active ExecPlan, decisions, deviations, risks, and validation evidence.
5. Acceptance-verification report, when available.
6. Implementation handoff and pull request description.
7. Complete diff, commit history, tests, migrations, dependencies, generated files, configuration, CI, and operational documentation.
8. `docs/project-status.md` and known baseline failures.

When sources conflict, apply the repository’s source-of-truth hierarchy. Do not silently choose an interpretation that makes the change appear correct.

## Review Scope and Baseline

Record:

* candidate revision, branch, and worktree;
* comparison baseline and merge target;
* complete commit and file range;
* approved scope and non-goals;
* affected actors, roles, tenants, modules, contracts, data, integrations, and environments;
* commands and environments available for review;
* pre-existing failures and known limitations.

Review committed, staged, unstaged, generated, renamed, and deleted files relevant to the candidate state.

Do not review a moving target without recording the exact revision.

## Readiness Gate

Before reviewing, verify that:

* the complete diff is available;
* scope, non-goals, and authoritative requirements are identifiable;
* the candidate can be inspected and relevant checks can be executed;
* migrations, generated artifacts, lockfiles, and configuration changes are included;
* known baseline failures are recorded or reproducible;
* unresolved implementation decisions and deviations are visible;
* the reviewer is independent.

Classify missing prerequisites as:

* **Review blocker** — prevents a trustworthy conclusion;
* **Specification defect** — requirements are ambiguous, contradictory, obsolete, or untestable;
* **Evidence limitation** — review may continue, but confidence is constrained;
* **Missing artifact** — required code, migration, documentation, or generated output is absent.

## Operating Rules

* Inspect the entire diff before forming the final recommendation.
* Review behavior and system effects, not formatting alone.
* Seek disconfirming evidence.
* Trace important findings to approved requirements or concrete engineering risk.
* Distinguish defects and risks from personal preferences.
* Prefer the simplest correction that restores approved behavior and safety.
* Deduplicate findings that share one root cause.
* Report pre-existing problems separately unless the change worsens or depends on them.
* Execute relevant checks independently.
* Preserve exact evidence, paths, symbols, commands, revisions, and observations.
* Complete the initial review pass before proposing or applying fixes.

## Prohibited Actions

Do not:

* modify production code, tests, migrations, configuration, or documentation during the initial pass;
* broaden or rewrite approved scope;
* approve based only on passing tests or the implementer’s report;
* report style preferences as defects when established standards are satisfied;
* demand speculative abstractions, unrelated refactors, or premature optimization;
* ignore a defect because fixing it is inconvenient;
* split one root cause into many inflated findings;
* hide multiple independent defects inside one vague finding;
* disable, skip, weaken, or bypass checks;
* access production, real user data, secrets, or irreversible operations without approval;
* merge, deploy, release, force-push, or rewrite shared history.

## Review Procedure

### 1. Reconstruct the Intended Change

Summarize:

* problem and intended outcome;
* included and excluded behavior;
* acceptance criteria;
* architectural constraints;
* quality attributes;
* rollout, migration, rollback, and recovery expectations.

Map each intended behavior to the files, contracts, data, tests, and documentation expected to support it.

### 2. Inspect the Complete Diff

Review:

* additions, modifications, deletions, and renames;
* commit boundaries and sequencing;
* generated files and lockfiles;
* dependency and configuration changes;
* migrations and fixtures;
* CI, deployment, feature-flag, and observability changes;
* documentation and operational instructions.

Identify unrelated changes, accidental files, debug output, dead code, broad formatting, duplicated logic, hidden generated changes, and unexplained deletions.

### 3. Review Correctness and Scope Compliance

Evaluate whether the implementation:

* satisfies each approved acceptance criterion;
* preserves required existing behavior;
* handles all approved actors, states, and business rules;
* omits required behavior or introduces unintended effects;
* implements excluded or unapproved behavior;
* depends on assumptions not approved or validated;
* fails safely under invalid or partial conditions.

Do not duplicate the acceptance-verification report mechanically. Confirm its conclusions against the diff and runtime evidence.

### 4. Review Architecture and Maintainability

Evaluate:

* module and ownership boundaries;
* dependency direction and layering;
* coupling, cohesion, duplication, and cyclic dependencies;
* domain rules placed in appropriate trusted layers;
* consistency with approved architecture and ADRs;
* unnecessary abstractions or frameworks;
* extension points introduced without demonstrated need;
* naming, readability, failure handling, and future change cost.

A different personal design preference is not a finding unless the chosen design violates requirements, repository conventions, or creates demonstrable risk.

### 5. Review Trust Boundaries

Evaluate:

* authentication and session assumptions;
* authorization at server-side or trusted boundaries;
* resource ownership and tenant isolation;
* privilege escalation and confused-deputy risks;
* direct-object-reference and enumeration risks;
* input validation, output encoding, injection, and unsafe parsing;
* abuse, rate, replay, automation, and resource-exhaustion cases;
* secret handling and sensitive logging;
* privacy, minimization, retention, deletion, masking, and auditability.

UI visibility is not authorization.

### 6. Review Data and State Integrity

Evaluate:

* schema correctness and ownership;
* migration ordering, compatibility, reversibility, and backfills;
* constraints, indexes, defaults, and nullability;
* transactions and partial writes;
* race conditions, stale writes, locking, and isolation;
* duplicate requests, events, retries, and idempotency;
* ordering, reconciliation, recovery, and corruption risks;
* mixed-version operation during rollout.

Require specialist migration or security review when risk exceeds a general change review.

### 7. Review Contracts and Integrations

Evaluate:

* API, event, queue, webhook, command, and file contracts;
* backward and forward compatibility;
* serialization, versioning, validation, and error semantics;
* timeouts, retries, idempotency, deduplication, and dead-letter handling;
* external side effects and reconciliation;
* integration authentication, secrets, quotas, and failure isolation;
* producer and consumer coordination.

Flag breaking changes that lack explicit approval and rollout sequencing.

### 8. Review User and Recovery States

Evaluate applicable:

* initial, loading, success, empty, and no-result states;
* validation, conflict, duplicate, and stale states;
* unauthenticated, unauthorized, and not-found behavior;
* timeout, dependency failure, partial failure, retry, and cancellation;
* recovery after refresh, restart, rollback, or repeated action;
* keyboard navigation, focus, semantics, labels, contrast, motion, and assistive technology;
* responsive and supported-client behavior.

### 9. Review Performance and Operations

Evaluate:

* query count and indexing;
* network requests and payload size;
* latency, memory, CPU, storage, and bounded work;
* batching, pagination, caching, and invalidation;
* blocking operations and repeated computation;
* logs, metrics, traces, correlation, audit events, and alerts;
* support diagnostics and incident response;
* feature flags, rollout controls, rollback, recovery, and cleanup.

Require measurable evidence when approved performance budgets exist.

### 10. Review Test Quality

Inspect whether tests:

* map to acceptance criteria and risk;
* cover positive, negative, boundary, unauthorized, failure, recovery, concurrency, idempotency, and compatibility scenarios;
* exercise real changed paths;
* assert observable behavior and side effects;
* can fail for the intended reason;
* isolate the correct system boundary;
* avoid excessive mocking;
* use representative roles, tenants, data, and flag states;
* are deterministic and maintainable.

Look for weak assertions, swallowed failures, implementation-only tests, snapshot misuse, skipped or focused tests, conditional disabling, stale fixtures, false positives, and tests that passed before the implementation.

Run relevant formatting, linting, type, unit, integration, contract, end-to-end, build, migration, security, accessibility, and performance checks. Record pre-existing failures separately.

### 11. Assess Merge Safety

Determine whether the change:

* is one coherent, reviewable unit;
* is appropriately sized;
* can be rolled back or recovered safely;
* has all required approvals;
* contains no unresolved Critical or High findings;
* has synchronized documentation and evidence;
* is safe to merge without relying on undocumented follow-up work.

Large size alone is not a defect, but unreviewable coupling or unsafe integration is.

## Findings

Every actionable finding must include:

* **ID and title**
* **Location:** path, lines, symbols, contract, or runtime surface
* **Evidence:** observed behavior, diff, command, or reproducible scenario
* **Expected behavior**
* **Observed behavior**
* **Impact**
* **Severity**
* **Confidence**
* **Recommended correction**
* **Verification required after correction**

Severity:

* **Critical** — exploitable security boundary failure, tenant escape, destructive corruption, irreversible loss, secret exposure, or unsafe release condition.
* **High** — core behavior fails, authorization is bypassed, compatibility breaks, migration is unsafe, or recovery is unreliable.
* **Medium** — meaningful regression, boundary failure, maintainability hazard, accessibility defect, performance risk, or operational gap.
* **Low** — limited defect with minor impact and clear correction.
* **Observation** — non-blocking concern, clarification, or optional improvement.

Confidence:

* **High** — directly reproduced or proven by deterministic evidence.
* **Medium** — strongly supported but not fully reproduced.
* **Low** — plausible concern requiring confirmation.

Do not block approval on Low-confidence speculation. Convert it into a verification request or blocker only when the uncertainty itself creates unacceptable risk.

## Stop Conditions and Approval Gates

Stop immediately when review activity would risk production, secrets, billing, external irreversible effects, or real user data.

Escalate when:

* authoritative requirements conflict;
* the baseline or complete diff cannot be established;
* security, privacy, tenant, or migration safety cannot be assessed;
* candidate evidence belongs to another revision;
* destructive or irreversible behavior lacks approval;
* review requires specialist expertise unavailable to the reviewer.

## Second Verification Pass

After fixes:

1. Review the new complete diff against the original baseline.
2. Confirm the exact new revision.
3. Reproduce every Critical, High, and Medium finding.
4. Verify the correction addresses the root cause.
5. Check for regressions and scope expansion introduced by fixes.
6. Rerun affected and required validation.
7. Reopen findings that remain, regress, or were only partially corrected.
8. Record newly discovered findings separately.

Do not accept assertions such as “fixed” without independent evidence.

## Required Output

Create or update the repository’s designated change-review report.

Include:

1. Metadata, revisions, baseline, and independence statement.
2. Approved scope, non-goals, and sources.
3. Review readiness and limitations.
4. Complete diff and change-surface summary.
5. Findings ordered by severity.
6. Acceptance, regression, and excluded-scope assessment.
7. Architecture, security, data, contract, UX, performance, and operational assessment.
8. Test-quality and validation results.
9. Dependencies, configuration, generated files, CI, documentation, rollout, and rollback assessment.
10. Pre-existing failures.
11. Required approvals and specialist reviews.
12. Final gate and second-pass requirements.

## Final Gate

Return exactly one outcome:

* **APPROVE** — no actionable defects or unaccepted material risks remain; the change is appropriately scoped and safe to merge.
* **APPROVE WITH OBSERVATIONS** — no merge-blocking defect remains; only explicit, non-blocking observations or accepted Low risks remain.
* **CHANGES REQUIRED** — one or more actionable findings must be corrected before merge.
* **BLOCKED** — missing evidence, conflicting requirements, unavailable environment, incomplete diff, or required specialist review prevents a trustworthy decision.

The final report must state:

* outcome;
* candidate and baseline revisions;
* findings by severity;
* commands executed and results;
* acceptance and regression status;
* scope deviations;
* required corrections and approvals;
* residual risks;
* exact requirements for the second verification pass.

Never return **APPROVE** or **APPROVE WITH OBSERVATIONS** when a Critical or High finding remains unresolved, required evidence was not executed, or the reviewed revision is not the final candidate revision.
