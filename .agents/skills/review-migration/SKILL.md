---
name: review-migration
description: Independently review a database, schema, data, storage, API-contract, infrastructure, framework, dependency, or system migration before execution without applying it or modifying production.
---

# Review Migration

## Purpose

Perform an independent, evidence-based, risk-focused review of a proposed migration before it is executed.

Determine whether the migration can move the system from its current state to its approved target state without unacceptable data loss, corruption, incompatibility, downtime, security exposure, operational ambiguity, or irreversible failure.

This skill reviews and reports. It does not apply the migration, modify production, silently redesign the target state, accept risk without authority, or treat a successful dry run as sufficient proof of production safety.

## Applicable Migration Types

Use this skill for migrations involving:

* database schemas or data;
* object, file, or search storage;
* APIs, events, contracts, or protocols;
* frameworks, runtimes, or major dependencies;
* infrastructure, hosting, networks, or providers;
* authentication, authorization, tenancy, or identity systems;
* queues, jobs, caches, indexes, or integrations;
* service decomposition, consolidation, or platform replacement.

State whether the review covers design, implementation artifacts, operational execution, or all three.

## Independence Requirement

The reviewer should not be the sole migration designer or implementer.

Use repository documentation, migration artifacts, direct inspection, independent commands, rehearsals, and reproducible evidence. Treat author reports, generated plans, provider estimates, tests, and successful local runs as inputs rather than proof.

## Required Inputs

Read, in precedence order:

1. `AGENTS.md` and applicable nested instructions.
2. Approved migration objective, scope, non-goals, and acceptance criteria.
3. Architecture, data, contract, privacy, security, quality-attribute, and ADR documentation.
4. Active ExecPlan, sequencing, rollout, rollback, and recovery strategy.
5. Migration scripts, schema changes, mappings, backfills, configuration, infrastructure, dependency manifests, and deployment automation.
6. Relevant application code, APIs, events, jobs, integrations, tests, dashboards, alerts, and runbooks.
7. Data profiles, volume estimates, provider constraints, rehearsal results, and known incidents.
8. `docs/project-status.md`, implementation handoff, review reports, and accepted risks.

Record conflicts between sources. Do not silently select an interpretation that makes the migration easier to approve.

## Scope and Baseline

Record:

* migration identifier and exact revision;
* current and target states;
* included and excluded systems;
* affected environments, tenants, users, data, contracts, and integrations;
* compatibility window;
* expected deployment topology and version skew;
* migration owner and operational owner;
* assumptions, dependencies, and unresolved decisions;
* available environments and representative data;
* production constraints and approved maintenance windows.

Do not generalize conclusions beyond the inspected scope.

## Readiness Gate

Before reviewing, verify that:

* the objective and success conditions are explicit;
* current and target states are documented;
* affected systems and data flows are identifiable;
* sequencing and compatibility expectations exist;
* migration and recovery artifacts can be inspected;
* production volume and operational constraints are estimated;
* representative rehearsal is possible or its absence is justified;
* destructive and irreversible steps are explicitly identified;
* required approvers and operators are known.

Classify missing prerequisites as:

* **Migration blocker** — prevents a trustworthy safety conclusion;
* **Design ambiguity** — target behavior, ownership, contract, or retention is unresolved;
* **Evidence limitation** — review may continue with reduced confidence;
* **Rehearsal gap** — safety depends on untested behavior or scale;
* **Specialist dependency** — database, infrastructure, privacy, security, or vendor expertise is required.

## Operating Rules

* Review the complete migration path, not only the primary script.
* Prefer expand-and-contract and reversible sequencing.
* Assume mixed versions, retries, interruptions, and partial completion.
* Verify claims against actual code, schemas, configuration, and representative evidence.
* Distinguish unsafe risks from theoretical concerns and personal preferences.
* Require measurable stop conditions and observable success signals.
* Deduplicate findings by root cause.
* Complete the initial review without applying migrations or modifying production.

## Prohibited Actions

Do not:

* execute the migration against production;
* modify production data, infrastructure, contracts, or configuration;
* perform destructive rehearsal using irreplaceable data;
* access real sensitive data without explicit approval and safeguards;
* silently add cleanup, transformation, retention, or ownership rules;
* approve drops, rewrites, or irreversible conversions without explicit authority;
* assume backups are usable without restore evidence;
* assume transactions eliminate every partial-failure mode;
* accept “zero downtime” without version-skew and lock analysis;
* disable constraints, checks, alerts, or safeguards merely to complete the migration;
* treat a tool-generated migration plan as authoritative;
* approve based only on tests passing in a small local dataset.

## Review Procedure

### 1. Reconstruct the Migration

Document:

* objective and business reason;
* current state;
* target state;
* scope and non-goals;
* affected data and systems;
* assumptions and dependencies;
* compatibility period;
* sequence from preparation through cleanup;
* irreversible boundaries;
* success, failure, and abandonment criteria.

Confirm that each step contributes to the approved target state.

### 2. Review State Transition and Sequencing

Evaluate:

* deployment order;
* schema, application, worker, API, integration, and infrastructure dependencies;
* expand-and-contract stages;
* dual reads or writes;
* shadow mode;
* feature flags and exposure controls;
* old and new version coexistence;
* producer and consumer coordination;
* cache, index, and derived-data invalidation;
* cleanup timing.

Identify any sequence in which an old or new component encounters an incompatible state.

### 3. Review Structural Changes

Evaluate applicable:

* tables, columns, fields, resources, endpoints, topics, files, or services added or removed;
* constraints and foreign keys;
* unique rules and tenant keys;
* indexes and index build methods;
* defaults and default backfills;
* nullability;
* type conversions and precision;
* renames represented as destructive drop-and-create operations;
* partitioning or storage layout;
* API and event schema changes;
* dependency, framework, runtime, or provider incompatibilities.

Require explicit approval for destructive operations and breaking contracts.

### 4. Review Data Transformation

Evaluate:

* source-data profiling;
* nulls, duplicates, invalid values, orphaned records, encoding, and unexpected distributions;
* cleansing rules;
* source-to-target mapping;
* transformation determinism;
* timezone, currency, precision, normalization, and identifier behavior;
* backfill selection and ordering;
* checkpointing and resumability;
* validation and reconciliation;
* handling of records that cannot migrate;
* provenance and auditability.

Every dropped, merged, synthesized, or altered value must have an approved rule.

### 5. Review Ownership, Privacy, and Isolation

Evaluate:

* data ownership before and after migration;
* tenant boundaries and row-level controls;
* permissions used by migration tooling;
* personal and sensitive data exposure;
* minimization, retention, deletion, export, and legal holds;
* temporary copies, dumps, logs, caches, staging tables, and backups;
* third-party transfer and residency;
* audit records and operator attribution;
* cleanup of temporary sensitive artifacts.

Temporary migration infrastructure must not become an uncontrolled data store.

### 6. Review Runtime Safety

Evaluate:

* transaction boundaries;
* lock type and duration;
* table, file, queue, or resource contention;
* concurrent reads and writes;
* stale or lost updates;
* duplicate processing;
* idempotency;
* retries and backoff;
* resumability after interruption;
* partial failures across systems;
* ordering and replay;
* consistency during dual operation;
* downtime and degraded modes.

A single transaction does not protect side effects outside its boundary.

### 7. Review Scale and Production Impact

Evaluate:

* row, object, file, event, and request volume;
* data growth during execution;
* estimated duration and uncertainty;
* CPU, memory, disk, network, connection, and queue usage;
* write amplification and replication lag;
* provider quotas, rate limits, maintenance limits, and timeouts;
* lock and index-build behavior;
* application latency and capacity;
* financial cost;
* throttling, batching, pause, and resume controls.

Require evidence derived from representative scale rather than unsupported estimates.

### 8. Review Affected Ecosystem

Inspect effects on:

* APIs and clients;
* events, queues, webhooks, and jobs;
* caches and sessions;
* search and analytics indexes;
* files and object storage;
* reports and exports;
* third-party integrations;
* monitoring and audit systems;
* backups and disaster recovery;
* support and administrative tools;
* CI/CD and deployment automation.

Derived data must be rebuilt, reconciled, or explicitly declared disposable.

### 9. Review Rollout, Recovery, and Operations

Evaluate:

* preconditions and readiness checks;
* feature flags;
* canary or tenant-scoped rollout;
* shadow reads or writes;
* checkpoints;
* observability and alert thresholds;
* operator ownership;
* runbook accuracy;
* communication plan;
* maintenance window;
* escalation and incident roles;
* pause and abort procedures;
* rollback and roll-forward;
* backup creation and restore validation;
* reconciliation after recovery;
* cleanup and decommissioning.

When rollback is impossible, require a credible roll-forward and restore strategy before approval.

### 10. Review Verification Strategy

Require tests for:

**Before migration**

* schema and contract compatibility;
* source-data profiling;
* backup and restore;
* permissions;
* migration preconditions;
* representative performance baseline.

**During migration**

* progress and checkpoint accuracy;
* error capture;
* invariant monitoring;
* locks, latency, replication, queues, and resource use;
* retry and resume behavior;
* stop-condition alerts.

**After migration**

* counts, checksums, aggregates, invariants, and sampled records;
* tenant and ownership integrity;
* application and contract behavior;
* old and new version compatibility;
* derived-data reconciliation;
* performance and error rates;
* rollback or recovery readiness;
* absence of unacceptable data loss.

Evidence must prove completeness and correctness, not merely script completion.

## Migration Rehearsal

Require rehearsal in a representative isolated environment when the migration affects production data, availability, contracts, infrastructure, or irreversible state.

The rehearsal must use:

* production-like schema and configuration;
* representative volume and distributions;
* anonymized or synthetic data;
* realistic concurrency and version skew;
* the same executable artifacts and sequence intended for production.

Record duration, resource use, locks, failures, retries, reconciliation, rollback or restore results, and deviations.

A materially unrepresentative rehearsal cannot support full approval.

## Findings

Every finding must include:

* **ID and title**
* **Location**
* **Evidence**
* **Affected data or systems**
* **Failure scenario**
* **Prerequisites**
* **Impact**
* **Likelihood**
* **Severity**
* **Confidence**
* **Recommended mitigation**
* **Required evidence after remediation**
* **Residual risk**

Severity:

* **Critical** — credible risk of irreversible data loss, broad corruption, tenant breach, unrecoverable outage, or catastrophic contract failure.
* **High** — likely significant loss, incompatibility, downtime, isolation failure, or unsafe recovery.
* **Medium** — meaningful integrity, performance, operational, privacy, or resumability weakness.
* **Low** — bounded defect or defense-in-depth gap with limited impact.
* **Observation** — non-blocking improvement or clarification.

Do not report stylistic preferences as migration risks.

## Destructive and Irreversible Migrations

Destructive or irreversible migrations require:

* explicit human approval;
* identified affected data and users;
* verified backup and restore or approved roll-forward;
* reconciliation evidence;
* rehearsal at representative scale;
* defined final abort point;
* communication and incident ownership;
* accepted residual risk recorded in an ADR or equivalent decision.

Absence of any required safeguard prevents approval.

## Stop Conditions

Stop and escalate when:

* production access or modification would be required;
* an unapproved destructive operation is discovered;
* backup restoration is unverified;
* tenant isolation or sensitive-data handling is unclear;
* representative rehearsal reveals loss, corruption, unsafe locks, or unrecoverable partial state;
* no measurable stop condition exists;
* migration artifacts differ from the reviewed revision;
* required specialist expertise is unavailable.

## Required Output

Create or update the designated migration-review report with:

1. Metadata, revision, scope, baseline, and independence statement.
2. Current and target states.
3. Assumptions, dependencies, and compatibility window.
4. Sequencing and affected-system map.
5. Structural and data-transformation assessment.
6. Privacy, ownership, isolation, and security assessment.
7. Runtime, scale, cost, and operational assessment.
8. Rehearsal results and evidence limitations.
9. Findings ordered by severity.
10. Rollout, rollback, recovery, observability, and stop conditions.
11. Required approvals, ADRs, remediation, and residual risks.
12. Final gate.

## Re-review After Remediation

Review the complete updated migration against the original baseline.

Reproduce each blocking finding, rerun the representative rehearsal, confirm artifacts and runbooks match the reviewed revision, verify no new destructive or incompatible step was introduced, and reassess residual risk.

Do not accept “fixed” without independent evidence.

## Final Gate

Return exactly one outcome:

* **MIGRATION APPROVED** — the migration is sufficiently evidenced, rehearsed, recoverable, operationally owned, and contains no unresolved blocking risk.
* **APPROVED WITH CONDITIONS** — execution is allowed only under explicit conditions, approvals, owners, thresholds, and re-verification requirements.
* **REHEARSAL REQUIRED** — design may be plausible, but representative execution evidence is insufficient.
* **REMEDIATION REQUIRED** — one or more actionable risks must be corrected before execution.
* **BLOCKED** — missing authority, evidence, artifacts, environment, recovery capability, or specialist review prevents a trustworthy conclusion.

Never return **MIGRATION APPROVED** when a destructive or irreversible step lacks explicit approval, restore or roll-forward evidence is missing, representative rehearsal has not been completed where required, or the reviewed artifacts are not the final execution artifacts.
