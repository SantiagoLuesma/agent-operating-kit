---

name: implement-vertical-slice
description: Implement one approved vertical slice end to end, producing complete, testable behavior with executed evidence and synchronized repository documentation.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Implement Vertical Slice

## Purpose

Implement the smallest approved end-to-end behavior that delivers observable value across every required layer of the system.

A vertical slice may include user interface, application logic, contracts, data, permissions, integrations, tests, documentation, and operational controls. It must not stop at an isolated frontend, backend, database, or testing layer.

This skill implements one approved slice from an active ExecPlan. It does not redefine the feature, redesign the architecture, approve its own work, merge to the protected branch, or release to production.

## Use This Skill When

Use this skill when:

* an approved feature specification and active ExecPlan exist;
* one slice or milestone has explicit scope, acceptance criteria, validation, and failure handling;
* blocking product, architecture, security, and data decisions are resolved;
* the repository baseline and required commands are sufficiently known;
* implementation can occur in an isolated branch or worktree.

Do not use it to discover requirements or compensate for an execution plan containing vague or unresolved steps.

## Required Inputs

Read, in precedence order:

1. `AGENTS.md` and applicable nested instructions.
2. The active ExecPlan and current milestone.
3. Approved feature specification, review, technical design, and test plan.
4. Architecture documentation, ADRs, and quality attributes.
5. `docs/project-status.md` and the latest relevant handoff.
6. Existing implementation, tests, contracts, migrations, configuration, operational tooling, Git status, baseline revision, and relevant history.

Record any conflict between sources. Follow the repository’s declared source-of-truth hierarchy and stop when a material conflict cannot be resolved without approval.

## Readiness Gate

Before editing, verify that:

* the exact slice and its non-goals are identified;
* every acceptance criterion has a planned validation method;
* required dependencies, credentials, fixtures, and environments are available;
* affected permissions, ownership, and tenancy rules are explicit;
* applicable migration, compatibility, rollback, and recovery requirements are known;
* the worktree or branch is correct and not the protected integration branch;
* unrelated working-tree changes are absent or documented and safely isolated;
* baseline commands and pre-existing failures are recorded from repository evidence.

Classify a missing item as:

* **Blocking decision** — implementation would invent product, contract, data, security, or architectural behavior;
* **Blocking dependency** — a required system, secret, environment, or upstream change is unavailable;
* **Approved assumption** — work may proceed only with explicit validation and failure handling;
* **Local implementation detail** — may be resolved autonomously within approved behavior and established conventions.

Do not begin implementation when a blocking decision or dependency affects the slice’s correctness or safety.

## Operating Rules

* Inspect before modifying and keep the active ExecPlan synchronized with repository reality.
* Prefer the smallest behavior that is complete, secure, testable, and independently reviewable.
* Implement through every applicable layer.
* Preserve existing contracts and behavior unless an approved change explicitly replaces them.
* Reuse established patterns before introducing abstractions.
* Validate at system boundaries and enforce authorization at trusted server-side boundaries.
* Keep the repository runnable and execute evidence-producing checks; never infer success from inspection alone.
* Update documentation as behavior and operational knowledge change.
* Escalate material deviations instead of silently redesigning the slice.

## Prohibited Actions

Do not:

* work directly on the protected integration branch;
* broaden scope or implement adjacent “nice to have” behavior;
* perform unrelated refactors, dependency upgrades, formatting sweeps, or file moves;
* disable, skip, weaken, delete, or bypass tests, linting, type checks, security controls, migrations, hooks, or CI requirements to make work pass;
* update snapshots or expected outputs without verifying approved behavior;
* hard-code secrets, production identifiers, permissions, or environment-specific behavior;
* silently change public contracts, data ownership, tenancy, authentication, authorization, retention, or compatibility guarantees;
* apply destructive or production migrations without explicit approval;
* deploy, release, merge, force-push, rewrite shared history, or access production unless separately authorized;
* claim completion using unexecuted commands, stale results, or assumed evidence.

## Implementation Procedure

### 1. Inspect the Repository and Establish the Baseline

Inspect the actual paths, symbols, call flows, contracts, tests, schemas, configuration, and documentation named by the ExecPlan.

Confirm current behavior, extension points, conventions, ownership boundaries, focused test commands, migration history, flags, telemetry, error handling, and recovery patterns.

Run the smallest relevant baseline checks before editing. Record command, environment, result, revision, and any pre-existing failure in the ExecPlan.

Do not fix unrelated baseline failures unless they prevent validation and approval is obtained to expand scope.

### 2. Synchronize the ExecPlan

Compare the plan with observed repository reality.

Update the plan when paths, dependencies, sequencing, validation, risks, or assumptions differ. Preserve decision history and mark superseded details.

Stop if repository evidence invalidates approved behavior, architecture, security boundaries, or the milestone’s feasibility.

### 3. Define the Slice Boundary

Restate in the ExecPlan:

* actor and trigger;
* successful observable outcome;
* included rules and states;
* explicit non-goals;
* affected layers and contracts;
* acceptance criteria covered by this slice;
* rollback or recovery boundary.

Split the milestone when it cannot be implemented, validated, reviewed, or recovered safely as one coherent change; never into disconnected technical layers.

### 4. Implement the End-to-End Behavior

Implement only what the slice requires, in the safest dependency order.

Address, when applicable:

* UI interactions, accessibility semantics, and state presentation;
* application or domain rules and boundary validation;
* APIs, commands, events, queues, webhooks, and versioned contracts;
* persistence, ownership, transactions, indexes, and migrations;
* authentication, authorization, tenancy isolation, and audit records;
* external integrations, timeouts, retries, idempotency, and reconciliation;
* configuration, feature flags, telemetry, runbooks, and documentation.

Keep abstractions proportional to demonstrated need and consistent with local conventions.

### 5. Implement Complete State and Failure Behavior

Cover all states required by the approved design:

* initial and loading;
* success;
* empty or no-results;
* validation failure;
* unauthenticated and unauthorized;
* not found, conflict, duplicate, stale, or already-processed;
* dependency timeout or unavailability;
* partial failure and retry;
* recovery, cancellation, or safe restart.

Errors must be safe, actionable, observable, and free of sensitive leakage; retries must not duplicate effects.

### 6. Protect Cross-Cutting Qualities

Evaluate applicable safeguards for:

* backward and forward compatibility;
* expand-and-contract migrations, backfills, reversibility, and mixed-version operation;
* transactions, concurrency control, race conditions, idempotency, and ordering;
* validation, least privilege, abuse resistance, secrets, and supply-chain risk;
* privacy, data minimization, retention, deletion, masking, and auditability;
* keyboard access, focus, semantics, contrast, motion, and assistive technology;
* query count, payload size, latency, memory, CPU, caching, and bounded work;
* logs, metrics, traces, correlation identifiers, alerts, and support diagnostics.

Mark a concern non-applicable only with a recorded reason.

### 7. Test Incrementally and Preserve Evidence

Test at the lowest reliable levels, adding broader coverage where boundaries or workflows require it.

Use, as applicable:

* static analysis, formatting, type, and schema checks;
* unit tests for rules and edge cases;
* integration tests for persistence, permissions, transactions, and integrations;
* contract tests for APIs, events, and external boundaries;
* end-to-end tests for user-visible behavior;
* migration, compatibility, security, accessibility, performance, and smoke tests.

Every acceptance criterion must map to executed evidence. Record:

* criterion identifier;
* command or procedure;
* environment and test data;
* expected and observed result;
* relevant output, artifact, screenshot, trace, or benchmark;
* revision on which it ran.

Happy-path tests alone are insufficient for permissions, failures, migrations, or recovery.

### 8. Review the Diff and Control Scope

After each coherent increment:

* inspect `git status` and the complete diff;
* verify every changed file is necessary;
* remove debugging artifacts, dead code, accidental generated files, and unrelated formatting;
* review authorization, data exposure, error paths, migrations, and compatibility again;
* rerun focused checks.

Create small, coherent commits when repository policy permits. Each commit should remain understandable and pass relevant checks. Do not mix unrelated cleanup with behavior changes.

Record pre-existing failures separately from new regressions. Pre-existing failures do not excuse new regressions.

### 9. Validate Rollback and Recovery

Verify the approved rollback or recovery path.

Confirm, when applicable:

* incomplete work can be reverted without corrupting data;
* migrations have a tested rollback, roll-forward, restore, or reconciliation procedure;
* flags can disable exposure without hiding unsafe side effects;
* retries and restarts are safe;
* partial external effects can be detected and reconciled;
* operators have sufficient telemetry and instructions.

Stop before an irreversible boundary when recovery cannot be demonstrated or explicitly accepted.

### 10. Synchronize Repository State

Update:

* the ExecPlan milestone status, progress, evidence, decisions, deviations, risks, and next action;
* stable feature documentation and test plan when behavior or contracts changed;
* architecture or ADR documentation only for approved architectural decisions;
* `docs/project-status.md` with current phase, gate, blockers, risks, and next skill;
* the handoff with branch, revision, commands run, results, incomplete work, and next safe action.

Documentation must describe implemented reality, not intended future behavior.

## Approval Gates and Stop Conditions

Stop and request approval before:

* destructive, irreversible, or production data operations;
* authentication, authorization, tenancy, billing, privacy, retention, or encryption changes not already approved;
* new public contracts or breaking compatibility changes;
* cross-cutting architecture changes or new infrastructure;
* dependency upgrades with material behavior, security, licensing, or operational impact;
* scope expansion or altered acceptance criteria;
* disabling safeguards, accepting critical risk, or proceeding without recovery.

Also stop when:

* tests reveal ambiguous expected behavior;
* the slice cannot remain complete without substantial adjacent work;
* required evidence cannot be executed or trusted;
* secrets or sensitive data are exposed;
* the repository cannot be returned to a safe state;
* actual behavior contradicts the approved plan.

## Completion Criteria

The slice is complete only when:

* the smallest approved end-to-end behavior works across all applicable layers;
* every acceptance criterion has executed, current evidence;
* required success, loading, empty, validation, unauthorized, failure, and recovery states are covered;
* focused and required repository checks pass, with pre-existing failures explicitly separated;
* compatibility, migration, concurrency, security, privacy, accessibility, performance, and observability checks are satisfied or approved as non-applicable;
* rollback or recovery is documented and verified to the required level;
* the final diff contains no unexplained or out-of-scope changes;
* commits are coherent and the branch is ready for independent review;
* ExecPlan, feature documentation, project status, and handoff are synchronized;
* no unresolved critical or high-severity implementation finding remains.

## Failure Criteria

The slice is incomplete when behavior is partial, evidence is stale or missing, checks are skipped, regressions remain, recovery is unsafe, documentation is inaccurate, or decisions exceed authority.

On failure, leave the repository safe, record the exact state and evidence, revert or isolate unsafe partial work when necessary, update the ExecPlan and handoff, and identify the next decision or recovery action.

## Final Gate

Return one result:

* **SLICE COMPLETE — READY FOR INDEPENDENT REVIEW** — all completion criteria and executed evidence are satisfied.
* **SLICE COMPLETE WITH APPROVED FOLLOW-UP** — the behavior is complete and safe, while explicitly approved non-blocking work remains tracked.
* **BLOCKED** — implementation cannot proceed without a decision, dependency, permission, or trustworthy environment.
* **FAILED — RECOVERY REQUIRED** — the attempted implementation is not safe or valid and requires documented corrective action.
* **ROLLED BACK** — changes were safely reverted and the repository state and reason are recorded.

The final report must include:

* gate result;
* slice and acceptance criteria implemented;
* branch, worktree, and final revision;
* changed areas and migration status;
* commands executed and results;
* evidence by acceptance criterion;
* pre-existing failures and new failures;
* security, compatibility, performance, and operational findings;
* rollback or recovery readiness;
* documentation updated;
* deviations, residual risks, blockers, and next required review.

Never report completion without executed evidence from the final relevant revision.
