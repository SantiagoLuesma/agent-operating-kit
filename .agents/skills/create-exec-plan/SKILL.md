---
name: create-exec-plan
description: Convert an approved, sufficiently defined change into a living, execution-ready implementation plan without implementing the change.
---

# Create Execution Plan

## Purpose

Create a self-contained, living execution plan that enables a fresh coding agent with no chat history to implement an approved change safely, incrementally, and verifiably.

The plan must translate approved product behavior, architecture, constraints, and quality attributes into concrete vertical slices, milestones, validation procedures, operational safeguards, and approval gates.

This skill plans implementation. It does not implement, redesign, or approve unresolved decisions.

## Use This Skill When

Use this skill after the change has:

- approved scope and non-goals;
- sufficiently defined behavior and acceptance criteria;
- reviewed architectural direction;
- identified quality attributes and material constraints;
- enough repository evidence to locate affected systems.

Do not use it to compensate for missing product or architectural decisions.

## Required Inputs

Read, in precedence order:

1. `AGENTS.md` and applicable nested agent instructions.
2. Current project status and repository documentation.
3. Approved product scope and feature specification.
4. Feature and architecture reviews.
5. Quality attributes and relevant ADRs.
6. Existing implementation, tests, migrations, contracts, and operational configuration.
7. Related active or completed plans and handoffs.
8. Git history when needed to understand conventions or prior decisions.

Record every source used with its repository path and, when useful, section or symbol.

If sources conflict, identify the conflict and apply the repository’s declared source-of-truth hierarchy. Do not silently choose whichever source is convenient.

## Preconditions Gate

Before planning, verify that:

- the objective and user-visible outcome are explicit;
- in-scope and out-of-scope behavior are distinguishable;
- acceptance criteria are testable;
- required product and architectural decisions are approved;
- affected ownership and permission rules are known;
- critical quality attributes have measurable expectations;
- the current repository baseline is sufficiently understood;
- required environments, dependencies, and integrations are available or explicitly planned.

Classify missing information as:

- **Blocking decision** — implementation would require inventing product, security, data, or architectural behavior;
- **Blocking dependency** — required system, credential, contract, environment, or prerequisite is unavailable;
- **Resolvable implementation detail** — may be decided by the implementer within existing conventions;
- **Tracked assumption** — planning may proceed only if its validation and failure response are explicit.

Do not produce an execution-ready result while blocking items remain.

## Operating Rules

- Inspect before planning.
- Ground steps in actual repository paths, modules, symbols, commands, and conventions.
- Prefer end-to-end vertical slices over horizontal technical layers.
- Each milestone must produce observable, independently verifiable behavior.
- Each step must state what changes, where, why, how it is validated, and what happens if validation fails.
- Separate facts, approved decisions, assumptions, proposals, and unknowns.
- Preserve approved scope. Do not add “helpful” capabilities silently.
- Treat the plan as mutable operational state, not a one-time prediction.
- Optimize for safe execution and review, not maximum apparent parallelism.
- Use exact commands when known. Mark commands requiring discovery instead of inventing them.
- Include negative paths, permission boundaries, partial failures, and operational behavior.
- Keep irreversible or production-sensitive actions behind explicit gates.

## Prohibited Actions

Do not:

- implement or edit production code;
- apply migrations or modify live data;
- deploy, release, or alter production infrastructure;
- create product behavior not present in approved sources;
- silently choose unresolved schemas, contracts, authorization models, tenancy boundaries, retention rules, or rollout policies;
- hide uncertainty behind vague wording;
- use steps such as “implement backend,” “build UI,” “add tests,” or “handle errors” without decomposition;
- declare work parallelizable when it shares unstable contracts, schemas, files, or sequencing dependencies;
- treat test execution alone as proof of acceptance;
- remove safeguards to simplify the plan;
- mark the plan ready merely because a document was produced.

## Planning Procedure

### 1. Establish the Change Baseline

Document:

- objective and expected outcome;
- business and technical context;
- approved scope;
- explicit non-goals;
- current behavior;
- desired behavior;
- affected actors and workflows;
- authoritative source documents;
- repository revision or baseline inspected.

Explain why the change is needed and what observable outcome proves it succeeded.

### 2. Build the Readiness Register

List:

- prerequisites;
- internal and external dependencies;
- environment or credential requirements;
- approved assumptions;
- unresolved decisions;
- known constraints;
- required spikes or contract confirmations.

For every unresolved item define:

- owner or approval authority;
- latest safe resolution point;
- consequence of proceeding incorrectly;
- stop condition;
- fallback, when one is approved.

### 3. Map the Change Surface

Identify concrete affected areas:

- modules, packages, services, components, routes, jobs, and configuration;
- public and internal APIs;
- commands, events, queues, webhooks, and third-party integrations;
- data models, ownership, indexes, retention, and migrations;
- authentication, authorization, tenancy, and audit boundaries;
- generated artifacts and compatibility surfaces;
- tests, fixtures, documentation, runbooks, dashboards, and alerts.

Distinguish:

- create;
- modify;
- preserve;
- deprecate;
- remove;
- investigate.

Include likely indirect effects and explicitly excluded adjacent systems.

### 4. Define the Delivery Strategy

Select the smallest coherent vertical slices that can be integrated and validated independently.

Each slice must include, where applicable:

- user or system behavior;
- minimal data and contract changes;
- business rules;
- permissions;
- interface or integration path;
- failure behavior;
- tests;
- documentation;
- observability.

Avoid slices that leave the repository in an invalid, unsecured, or operationally ambiguous state.

Define:

- milestone sequence;
- dependency graph;
- critical path;
- safe checkpoints;
- worktree or branch boundaries;
- parallelizable work;
- integration order.

Parallel work is permitted only when contracts are stable and merge overlap, migration ordering, and test interference are controlled.

### 5. Specify Every Milestone

For each milestone provide:

- **Outcome:** verifiable behavior produced.
- **Scope:** exact responsibilities included and excluded.
- **Change locations:** expected paths, modules, symbols, or artifacts.
- **Implementation steps:** concrete ordered actions.
- **Dependencies:** required prior milestones or decisions.
- **Acceptance criteria:** externally observable and testable conditions.
- **Validation:** commands, tests, inspection, evidence, and reviewer checks.
- **Failure handling:** diagnosis, containment, rework, rollback, or escalation.
- **Completion gate:** conditions required before continuing.
- **Status:** not started, in progress, blocked, complete, or superseded.

A milestone is not complete because files exist. Its behavior and safety properties must be demonstrated.

### 6. Define Acceptance and Definition of Done

Trace every approved acceptance criterion to one or more milestones and validation methods.

The plan-level Definition of Done must require, as applicable:

- all in-scope behavior implemented;
- non-goals still excluded;
- tests passing at required levels;
- negative and permission paths verified;
- contracts and migrations reviewed;
- compatibility expectations satisfied;
- security and privacy checks completed;
- performance expectations measured;
- operational controls available;
- documentation synchronized;
- independent review completed;
- rollout and rollback readiness demonstrated;
- no unresolved critical findings;
- evidence recorded.

Unmapped acceptance criteria block plan readiness.

### 7. Design the Validation Matrix

For each behavior or risk define:

- validation level: static, unit, integration, contract, end-to-end, migration, security, performance, accessibility, smoke, or operational;
- exact command or procedure;
- environment and test data;
- expected result;
- evidence to preserve;
- failure interpretation;
- responsible review gate.

Prefer deterministic repository commands. If validation is manual, define precise steps and expected observations.

Do not use “manually verify” without a reproducible procedure.

### 8. Plan Cross-Cutting Checks

Explicitly evaluate and plan checks for:

- authentication and authorization;
- least privilege and multitenancy isolation;
- secrets, sensitive data, privacy, and retention;
- input validation and abuse resistance;
- backward and forward compatibility;
- transaction boundaries, concurrency, idempotency, and retries;
- performance, capacity, and resource use;
- accessibility and supported clients;
- auditability, logging, metrics, tracing, and alerting;
- support, incident diagnosis, backup, and recovery.

Mark non-applicable concerns with a reason. Do not omit them silently.

### 9. Plan Change Introduction and Recovery

Define:

- feature flag or configuration strategy;
- schema and data migration stages;
- expand-and-contract sequencing when compatibility matters;
- backfill behavior, batching, throttling, resumability, and verification;
- deployment order across components;
- canary, staged, tenant-scoped, or percentage rollout;
- monitoring signals and observation period;
- rollback criteria and procedure;
- roll-forward strategy when rollback is unsafe;
- data recovery and reconciliation;
- cleanup timing for temporary compatibility paths.

Any destructive, irreversible, production, billing, authentication, authorization, or sensitive-data action requires an explicit approval gate.

### 10. Create the Risk and Control Register

For each material risk or unknown record:

- description;
- likelihood and impact;
- detection signal;
- prevention or mitigation;
- contingency;
- owner;
- decision deadline;
- stop condition;
- escalation path;
- residual risk.

Stop and escalate when:

- implementation would contradict approved scope or architecture;
- a security, privacy, permission, or tenancy boundary is unclear;
- migration safety cannot be demonstrated;
- validation cannot distinguish success from failure;
- required rollback or recovery is unavailable;
- observed repository behavior invalidates a core assumption;
- the change expands materially beyond the approved plan.

### 11. Define Living-Plan Maintenance

The implementation agent must update the plan during execution.

Require:

- timestamped progress entries;
- completed evidence and command results;
- newly discovered facts and unknowns;
- decisions with rationale and approver;
- deviations from the original plan;
- changed risks or sequencing;
- blockers and escalation status;
- milestone status updates;
- remaining work and next action.

Minor implementation details may be updated autonomously when they preserve approved behavior and architecture.

Material deviations require approval before continuing, including changes to:

- scope or acceptance criteria;
- public contracts;
- data ownership or destructive migrations;
- security or permission models;
- architectural boundaries;
- compatibility promises;
- rollout, recovery, or operational risk.

Never rewrite history. Append decisions and mark superseded content clearly.

## Required Output

Create or update an active plan under the repository’s designated plan location, normally:

`docs/plans/active/<change-name>.md`

The plan must contain:

1. Title, status, owner, baseline, and last-updated timestamp.
2. Objective and success outcome.
3. Context and source documents.
4. Scope and non-goals.
5. Current and desired behavior.
6. Prerequisites, dependencies, assumptions, and unresolved decisions.
7. Change-surface map.
8. Delivery strategy and dependency graph.
9. Milestones and vertical slices.
10. Acceptance-criteria traceability.
11. Definition of Done.
12. Validation matrix and evidence requirements.
13. Cross-cutting checks.
14. Migration, rollout, rollback, recovery, and observability.
15. Risks, stop conditions, gates, and escalation rules.
16. Progress log.
17. Decision and deviation log.
18. Handoff requirements.
19. Closure criteria.

The document must contain enough repository-specific context for a fresh agent to begin without relying on chat history.

## Handoff Requirements

At any interruption point, the plan must reveal:

- current milestone and status;
- completed work and evidence;
- exact repository state or revision;
- active branch or worktree when applicable;
- unresolved blockers and decisions;
- commands already run and their results;
- risky or partially completed operations;
- next safe action;
- actions that must not be taken without approval.

A separate handoff may reference the plan but must not replace it.

## Closure Criteria

Move the plan from active to completed only when:

- every milestone is complete or explicitly cancelled;
- acceptance criteria and Definition of Done are satisfied;
- required evidence and reviews are recorded;
- deviations and residual risks are resolved or accepted by the proper authority;
- rollout, migration, rollback, and recovery outcomes are documented;
- stable project and feature documentation is updated;
- temporary flags, compatibility paths, branches, or follow-up work are assigned;
- the final implementation state can be understood without chat history.

## Final Gate

Return one result:

- **EXECUTION READY** — complete, sequenced, independently executable, and no blocking decisions remain.
- **CONDITIONALLY READY** — execution may begin only through explicitly identified safe milestones while listed gates remain.
- **REVISION REQUIRED** — material gaps prevent reliable execution planning.
- **BLOCKED** — required product, architecture, security, dependency, or repository evidence is unavailable.

The final report must state:

- gate result;
- plan path;
- objective;
- milestone summary;
- blocking and conditional items;
- approval gates;
- highest risks;
- first safe execution step;
- evidence used to judge readiness.

Do not report **EXECUTION READY** unless a fresh agent can execute the plan without inventing material behavior or relying on unstated context.