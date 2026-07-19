---
name: verify-main
description: Verify the actual protected integration-branch revision after an approved merge, proving repository and representative runtime health before release preparation begins.
---

# Verify Main

## Purpose

Use this skill after an approved merge reaches the repository's protected integration branch. Verify the exact current integrated revision in a clean, reproducible state and determine whether release preparation may begin.

This skill does not deploy, release, modify production, approve a release, or repair the protected branch directly. Pull-request checks and feature-branch evidence are inputs, not substitutes for verification of the merged revision.

Any corrective change must be implemented on a new branch, independently reviewed, and merged through the normal protected workflow.

## Core rules

* Follow `AGENTS.md` and applicable nested instructions.
* Verify the configured integration branch; do not assume it is named `main`.
* Pin every claim to the exact remote revision tested.
* Prefer a fresh clone or disposable detached worktree over a reused developer workspace.
* Do not hide, retry away, weaken, skip, or reclassify failures without evidence.
* Do not reset, clean, amend, commit, or edit the protected branch.
* Do not use production or sensitive customer data.
* Stop release work when integration health is materially uncertain.

## Required inputs

Locate or establish:

1. Repository instructions, required verification commands, and branch-protection conventions.
2. The configured integration branch and authoritative remote.
3. The merged revision, merge record, source PR or reviewed branch, expected commits, approved scope, and non-goals.
4. The last known healthy integration revision or pre-merge revision when available.
5. Acceptance-verification, independent review, security review, migration review, PR evidence, and accepted-risk records.
6. Relevant feature, architecture, contract, schema, runbook, release, ExecPlan, handoff, and `project-status.md` documents.
7. A representative non-production environment and required non-secret configuration.

If the actual remote revision, intended merge, or authoritative scope cannot be identified, do not infer success.

## Establish the verification revision

Use repository-equivalent read-only commands. Typical Git inspection includes:

```text
git remote -v
git symbolic-ref refs/remotes/origin/HEAD
git fetch --prune <remote>
git rev-parse <remote>/<integration-branch>
git log --oneline --decorate -n 20 <remote>/<integration-branch>
git status --short --branch
git worktree list --porcelain
```

Confirm:

* remote synchronization completed or its limitation is explicit;
* the tested revision equals the current remote integration revision;
* the branch is protected according to repository policy;
* the verification workspace is clean, detached or otherwise protected from edits, and contains no inherited build output;
* dependencies can be installed from the committed lockfile using the supported toolchain;
* required services and configuration are reproducible without secret values being recorded.

Do not use `reset --hard`, destructive clean commands, or local changes to manufacture a clean state. Create a disposable worktree or clone instead.

## Procedure

### 1. Verify merge integrity

Prove that the intended change is present in the tested integration revision. Account for merge, squash, and rebase strategies.

* Confirm the merge or replacement commit is reachable from integration `HEAD`.
* Compare the actual integrated diff with the approved PR scope and expected changed paths.
* Confirm required contracts, migrations, generated artifacts, tests, and documentation were merged completely.
* Inspect merge resolutions and files concurrently changed by other merges.
* Identify unexpected additions, deletions, reversions, dependency changes, configuration changes, or semantic conflicts.
* Preserve explicit non-goals.

When multiple merges landed together, identify the exact verification interval and distinguish the target merge from concurrent changes without assuming either is harmless.

### 2. Reproduce the repository

From the clean verification workspace:

* install dependencies using committed manifests and lockfiles;
* verify supported runtime, package-manager, compiler, database, and service versions;
* generate required artifacts from canonical sources;
* confirm generation leaves no unexplained diff;
* initialize disposable local services or data using documented procedures;
* validate required environment-variable names, defaults, schemas, and feature-flag configuration without exposing values.

A successful reused cache is not sufficient when clean-install reproducibility is material to the change.

### 3. Run integrated validation

Run repository verification scripts first, then relevant underlying checks when coverage or failure diagnosis requires them:

* formatting and generated-file checks;
* lint and static analysis;
* type checking;
* unit, integration, contract, end-to-end, and regression tests;
* build, packaging, and startup checks;
* schema, migration-order, rollback-safety, and data-reconciliation checks;
* secret, dependency, license, and security checks;
* accessibility, performance, compatibility, and operational checks when affected.

Test the integration revision, not artifacts produced from the feature branch. Record exact command, directory, revision, environment, material versions, exit code, duration when useful, and retained evidence.

Passing checks only support claims they actually exercise.

### 4. Smoke test representative behavior

Use an existing authorized local, preview, or staging environment that runs the tested revision. Do not deploy one as part of this skill.

Smoke test:

* application startup and health endpoints;
* critical user journeys;
* the newly merged behavior and its primary acceptance criteria;
* loading, empty, validation, unauthorized, failure, retry, and recovery states when relevant;
* APIs, events, integrations, and background processing;
* authentication, authorization, ownership, and tenant isolation;
* feature-flag enabled and disabled paths when both remain supported;
* migration compatibility with the application version and representative synthetic data;
* required logs, metrics, traces, alerts, and audit signals.

Record the environment revision and configuration profile. A staging URL alone does not prove it runs the verified commit.

### 5. Check integration-only regressions

Specifically test assumptions that may fail only after merge:

* concurrent edits to shared modules, schemas, routes, configuration, or dependency locks;
* version skew between clients, services, generated code, contracts, and migrations;
* merge-resolution mistakes and lost changes;
* shared mutable state, ordering, timing, cache, queue, or transaction assumptions;
* migration collisions, duplicate identifiers, incompatible defaults, and seed conflicts;
* feature-flag interactions and environment-specific defaults;
* global build, bundle, performance, or test-order regressions.

Broaden verification beyond the PR's focused tests when shared boundaries changed.

### 6. Reconcile repository state documentation

Confirm the merged revision contains accurate:

* stable product, feature, architecture, ADR, contract, schema, and runbook documentation;
* `docs/project-status.md` phase, gate, risks, blockers, and next action;
* completed or correctly transitioned ExecPlan;
* archived, superseded, or updated handoff;
* migration, rollout, recovery, support, and release prerequisites.

Do not edit discrepancies on the protected branch. Record them for a remediation branch.

### 7. Classify failures

Classify each non-passing result:

* **Merge-caused:** absent on the verified pre-merge revision and present after integration.
* **Concurrent-integration regression:** caused by interaction with another merged change.
* **Pre-existing:** reproduced on the pre-merge or last accepted healthy revision with equivalent conditions.
* **Environment-specific:** supported by evidence that repository behavior is not the cause.
* **Flaky:** demonstrated nondeterminism with all attempts recorded.
* **Not run / unavailable:** blocked by an explicit environment or tooling limitation.
* **Origin unknown:** insufficient evidence; treat as unresolved.

Pre-existing and environment failures do not excuse regressions or missing evidence. Never report only the successful retry of a flaky check.

### 8. Define remediation or recovery

When integration is unhealthy:

* stop release preparation and recommend pausing dependent merges when failure could compound;
* preserve logs, revision identifiers, and reproduction steps;
* identify the smallest safe corrective branch and recommended skill;
* determine whether a normal fix-forward or reviewed revert is safer;
* inspect migration, contract, data, and compatibility consequences before recommending revert;
* state rollback or recovery prerequisites, untested assumptions, and approval owner.

Do not perform the revert, branch-protection change, deployment rollback, or production repair under this skill.

## Verification gates

### G1 — Revision integrity

The current remote integration branch, exact tested revision, merge interval, and clean workspace are proven.

### G2 — Merge integrity

The intended change is complete, scoped correctly, and free of unexplained merge or concurrent-change damage.

### G3 — Repository health

Required clean install, generation, formatting, lint, types, tests, build, contracts, migrations, and security checks provide sufficient current evidence.

### G4 — Runtime health

Critical journeys and merged behavior work in a representative environment running the verified revision.

### G5 — Integration safety

Configuration, dependencies, flags, APIs, data, permissions, tenancy, migrations, observability, and shared-state interactions are consistent.

### G6 — Operational continuity

Documentation, project status, plans, handoffs, recovery information, and release prerequisites match the merged revision.

## Stop conditions and approval gates

Stop before release, deployment, further risky merges, or cleanup when:

* the tested revision is not the current remote integration revision;
* Critical or High regressions, security issues, migration hazards, data-integrity risks, or tenant-isolation failures exist;
* required checks fail or material evidence is unavailable;
* the environment revision cannot be proven;
* authoritative contracts or documentation conflict with implementation;
* rollback or recovery could be destructive or is not understood;
* suspected secrets or sensitive data were exposed.

Human approval is required before production access, deployment, release, revert, branch-protection changes, destructive migration, data repair, acceptance of Critical/High residual risk, or resuming a deliberately paused merge queue.

Do not delete the verification workspace, logs, failed artifacts, source branch, or handoff until evidence is retained and cleanup is authorized by repository policy.

## Completion criteria

Verification is complete only when:

* all six gates were evaluated against the current remote revision;
* merge content and concurrent changes were inspected;
* a clean reproducible workspace was used;
* required integrated checks and representative smoke tests were executed or explicitly bounded;
* integration-only risks were tested;
* failures were evidence-based and correctly classified;
* documentation and operational state match the merge;
* remediation, revert, or recovery options are understood where needed;
* release and approval boundaries are explicit;
* the final report enables a fresh contributor to reproduce the conclusion.

## Outcomes

* **MAIN VERIFIED** — All gates pass; the actual integration revision is healthy and release preparation may begin. This is not release approval.
* **VERIFIED WITH OBSERVATIONS** — The revision is healthy enough for release preparation, with bounded non-blocking observations, pre-existing issues, or manual follow-ups explicitly recorded.
* **REMEDIATION REQUIRED** — A reproducible integration, documentation, migration, security, runtime, or evidence defect must be corrected through a new reviewed branch before release work proceeds.
* **BLOCKED** — The actual revision, environment, authority, or evidence cannot be established safely enough to determine health.

## Required final report

Report:

1. Outcome and release-preparation recommendation.
2. Remote, integration branch, tested revision, merge interval, and workspace.
3. Expected merge and integrity findings.
4. Commands, environments, versions, and results.
5. Smoke-tested journeys and runtime evidence.
6. Configuration, contracts, permissions, tenancy, migrations, flags, and observability findings.
7. Integration-only regression analysis.
8. Failure classification, including pre-existing and environment-specific issues.
9. Documentation, plans, handoffs, and project-status findings.
10. Risks, stop conditions, remediation or recovery path, approvals, and next safe action.

Never report `MAIN VERIFIED` from PR evidence alone or when the tested revision is stale.
