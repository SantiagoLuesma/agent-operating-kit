---
name: prepare-pr
description: Prepare an implemented and independently reviewed change for a pull request by validating repository state, evidence, scope, commits, risks, and reviewer guidance without pushing, opening, merging, or deploying.
---

# Prepare Pull Request

## Purpose

Use this skill after implementation, acceptance verification, independent review, and documentation work are substantially complete. Determine whether the current branch is ready to be presented as a pull request and prepare an evidence-based PR package for human review.

This skill prepares a change for a PR. It does not approve the change, push without authorization, open the PR unless explicitly authorized, merge, deploy, release, apply production migrations, or claim that reviewers will accept it.

`PR READY` means ready to open for review. It never means approved to merge.

## Core rules

* Follow `AGENTS.md` and applicable nested instructions.
* Inspect repository reality; do not rely on chat history or summaries alone.
* Compare the complete branch, not only the latest commit or visible working-tree diff.
* Keep scope, evidence, failures, risks, and unresolved decisions explicit.
* Never hide failures, weaken checks, fabricate evidence, or label an unverified result as passing.
* Never force-push, rewrite shared history, merge, deploy, or perform an irreversible operation.
* Do not mix unrelated cleanup, generated noise, or speculative follow-up work into the PR.

## Required inputs

Locate or establish:

1. Repository-wide and nested `AGENTS.md` instructions.
2. `docs/project-status.md`, active ExecPlan, and latest relevant handoff.
3. Approved scope, non-goals, feature specification, acceptance criteria, ADRs, contracts, and operational requirements.
4. Current worktree, branch, full `HEAD` revision, base branch, merge base, upstream, and working-tree state.
5. Complete branch diff and commit history against the intended base.
6. Acceptance-verification report and evidence.
7. Independent review findings and their dispositions.
8. Security, privacy, migration, compatibility, documentation, rollout, rollback, and operational evidence.
9. Repository PR template, ownership rules, required checks, and reviewer conventions.

If the intended base, approved scope, branch identity, or required evidence cannot be established, do not guess.

## Repository and readiness inspection

Inspect from the active worktree using repository-equivalent commands:

```text
git rev-parse --show-toplevel
git branch --show-current
git rev-parse HEAD
git status --short --branch
git worktree list --porcelain
git merge-base HEAD <base>
git log --oneline --decorate <base>..HEAD
git diff --name-status <base>...HEAD
git diff --stat <base>...HEAD
git diff <base>...HEAD
```

Also inspect staged, unstaged, untracked, conflicted, submodule, and generated-file state when relevant. Derive the base from the ExecPlan, handoff, upstream, repository policy, or verified integration target.

Preparation normally requires:

* a non-protected feature branch;
* no unresolved conflicts;
* a known base and merge base;
* no unexplained working-tree changes;
* an inspectable commit range;
* authoritative scope and acceptance criteria;
* independent review evidence;
* documentation synchronized with the implementation.

A dirty tree is acceptable only when every change is intentional and accounted for before opening the PR.

## Procedure

### 1. Reconstruct intended scope

Link to the authoritative requirement, feature specification, ExecPlan, ADRs, and contracts. State:

* intended outcome;
* included behavior;
* explicit non-goals;
* approved deviations;
* affected users, systems, data, interfaces, and operations.

Do not infer new scope from the implementation. When code exceeds or contradicts approved scope, classify it as remediation or an approval-required decision.

### 2. Review the complete branch diff

Inspect every changed, added, renamed, deleted, generated, and binary file. Compare the branch against the merge base and intended scope.

Detect and remove or disclose:

* unrelated refactors, formatting sweeps, dependency upgrades, or file moves;
* debug logging, breakpoints, commented experiments, dead code, test-only bypasses, and temporary flags;
* snapshots, lockfile changes, generated artifacts, coverage output, caches, editor files, local databases, and build products not required by policy;
* secrets, credentials, tokens, personal data, production identifiers, sensitive logs, and unsafe fixtures;
* accidental environment, CI, deployment, permission, routing, feature-flag, or configuration changes;
* stale TODOs, placeholder copy, temporary workarounds, and incomplete migrations.

Do not delete unfamiliar files merely to shrink the diff. Suspected secret exposure is `BLOCKED`; stop propagation and follow incident guidance.

### 3. Reconcile acceptance, review, security, and documentation

Confirm that every acceptance criterion has a status and evidence. Confirm independent review findings are:

* fixed and reverified;
* explicitly accepted by authorized owners;
* disclosed as unresolved; or
* correctly classified as not applicable.

Reassess security, authorization, tenancy, privacy, data ownership, and recovery. Confirm affected contracts, schemas, ADRs, feature docs, runbooks, project status, ExecPlan, and handoff match reality.

Open Critical or High findings, unapproved public-contract changes, destructive migrations, or unresolved authority conflicts prevent `PR READY`.

### 4. Validate the change

Run the repository-required checks on the revision intended for the PR. Include, as applicable:

* format and generated-file checks;
* lint and static analysis;
* type checking;
* unit, integration, contract, end-to-end, and regression tests;
* build and packaging;
* migration validation and data reconciliation checks;
* security, secret, dependency, license, and policy checks;
* accessibility, performance, compatibility, observability, and operational checks.

Record command, directory, revision, environment, material versions, result, and exercised behavior.

Classify non-passing evidence precisely:

* **Change-caused failure:** must be remediated.
* **Pre-existing failure:** proven on the base revision or by equivalent retained evidence; disclose it and its impact.
* **Flaky:** reproduced as nondeterministic, with attempts and observed outcomes; never report only the passing retry.
* **Skipped:** state who or what skipped it, why, and the remaining risk.
* **Not run / unavailable:** state the environment limitation and required manual or CI follow-up.
* **Origin unknown:** treat as unresolved, not pre-existing.

Do not disable, quarantine, loosen, or rewrite checks merely to obtain a passing result.

### 5. Review commits and synchronization risk

Assess whether commits are focused, comprehensible, correctly authored, and free of secrets or unrelated changes. Commit messages should describe intent and consequences rather than low-level activity.

Prefer logical commits when they aid review, rollback, or bisecting. Never amend, rebase, squash, or force-push shared commits without explicit approval and coordination.

Inspect base divergence and likely conflicts. Determine whether synchronization is required by repository policy. Before rebasing or merging the base branch:

* confirm the correct base;
* check whether history is shared;
* assess migration, generated-file, lockfile, and semantic-conflict risk;
* obtain approval when the operation rewrites or materially changes shared work.

After any synchronization, rerun affected validation and refresh all revision-specific evidence.

### 6. Assess delivery and operational readiness

Document, when applicable:

* backward and forward compatibility;
* API, event, schema, and client version guarantees;
* feature-flag defaults, ownership, enablement, and removal plan;
* migration and deployment order;
* expand/contract or compatibility window;
* backfill, data validation, and reconciliation;
* rollout stages and abort signals;
* observability, dashboards, alerts, logs, and audit signals;
* rollback or recovery steps and whether they were tested;
* support, runbook, and incident implications.

A PR may be ready while deployment remains gated, but the distinction and prerequisites must be explicit.

### 7. Select reviewers

Use ownership rules and changed concerns to identify reviewers. Recommend roles, not invented people, unless repository ownership identifies them.

Request specialist review when the diff affects:

* product or UX behavior;
* architecture or public contracts;
* authentication, authorization, tenancy, security, or privacy;
* database schemas, migrations, retention, or data ownership;
* billing or financial behavior;
* infrastructure, deployment, observability, or incident response;
* accessibility, performance, localization, or regulated domains.

The implementer cannot substitute for required independent or specialist review.

## Required PR package

Prepare the repository's PR template or an equivalent draft containing:

1. **Title** — concise, imperative or repository-conventional, describing the user or system outcome.
2. **Summary** — why the change exists and what it accomplishes.
3. **Scope** — included behavior and affected systems.
4. **Non-goals** — intentionally excluded work.
5. **Implementation notes** — important boundaries, contracts, trade-offs, and reviewer-relevant choices; do not narrate every file.
6. **Acceptance criteria** — status and evidence links.
7. **Tests and validation** — exact commands, environments, results, skipped checks, flakiness, and pre-existing failures.
8. **Visual or behavioral evidence** — screenshots, recordings, traces, contract diffs, benchmarks, or logs when useful, using synthetic or non-sensitive data.
9. **Security and privacy** — findings, controls, residual risks, and specialist-review needs.
10. **Migrations and rollout** — order, compatibility window, feature flags, prerequisites, and manual steps.
11. **Rollback or recovery** — safe reversal path, limitations, and evidence.
12. **Risks and unresolved items** — decisions, accepted risks with approver, limitations, and follow-up work.
13. **Reviewer guidance** — high-risk files, invariants, test focus, and requested specialists.
14. **Authoritative references** — feature docs, ADRs, contracts, ExecPlan, verification, review, documentation update, and handoff.

Never invent screenshots, tests, approvals, deployments, or manual verification.

## Readiness gates

Evaluate every gate:

### G1 — Repository integrity

Branch, base, revision, merge base, worktree, commit range, and diff are exact; no unexplained or sensitive changes remain.

### G2 — Scope integrity

The complete diff matches approved scope and preserves explicit non-goals.

### G3 — Evidence integrity

Acceptance criteria, tests, review findings, security concerns, migrations, and documentation are resolved or truthfully disclosed.

### G4 — Commit and integration quality

Commits are reviewable; authorship is correct; synchronization and conflict risks are understood; shared history was not rewritten.

### G5 — Delivery safety

Compatibility, rollout, flags, migration order, observability, rollback, and operational prerequisites are sufficient for review.

### G6 — PR usability

The title, description, evidence, risks, reviewer guidance, and authoritative links allow an independent reviewer to assess the change without chat history.

## Autonomy, approval gates, and stop conditions

Proceed autonomously with inspection, reversible in-scope cleanup, validation, documentation synchronization, and a local PR draft.

Stop and request human authority before:

* pushing a branch or opening a PR unless explicitly authorized for the task;
* changing scope, acceptance criteria, public contracts, or compatibility guarantees;
* accepting Critical or High residual risk;
* rewriting shared history, rebasing shared commits, or force-pushing;
* applying destructive migrations or accessing production or sensitive data;
* changing secrets, authentication, authorization, tenancy, privacy, retention, billing, or encryption outside prior approval;
* merging, deploying, releasing, enabling production flags, or executing irreversible operations.

Stop with `BLOCKED` for suspected secret exposure, unknown repository identity, unresolved conflicts, unavailable authoritative scope, or a critical safety/authority contradiction.

Use `REMEDIATION REQUIRED` when the state is inspectable but branch cleanup, implementation fixes, missing evidence, failing checks, unresolved review findings, documentation drift, or migration defects prevent PR preparation.

## Completion criteria

Preparation is complete when:

* all six readiness gates were evaluated;
* the complete branch diff and commit history were reviewed;
* repository identity and intended base are exact;
* scope and non-goals match the diff;
* accidental, unrelated, sensitive, temporary, and generated noise is removed or explicitly justified;
* acceptance, independent review, security, migrations, and documentation are resolved or disclosed;
* validation evidence is revision-specific and failures are honestly classified;
* commit, synchronization, compatibility, rollout, observability, and recovery risks are understood;
* the PR package is complete and identifies appropriate reviewers;
* no merge, deployment, approval, push, or PR-opening claim was made without authority.

## Outcomes

* **PR READY** — All readiness gates pass. The branch and PR package are ready to be opened for independent review; merge approval remains pending.
* **READY WITH DISCLOSED RISKS** — Safe to open for review, with bounded non-blocking risks, skipped evidence, pre-existing failures, or manual checks clearly disclosed.
* **REMEDIATION REQUIRED** — Correctable scope, code, test, review, documentation, commit, migration, or evidence problems prevent opening a responsible PR.
* **BLOCKED** — Critical repository, authority, conflict, security, or evidence conditions make safe preparation impossible.

## Required final report

Report:

1. Outcome and recommendation: open PR, open with disclosed risks, remediate, or block.
2. Branch, worktree, `HEAD`, base, merge base, upstream, and working-tree state.
3. Scope and non-goals confirmed.
4. Diff and commit-history findings.
5. Acceptance, independent review, security, migration, and documentation status.
6. Commands, environments, and results, separating failure categories.
7. Compatibility, rollout, observability, and rollback considerations.
8. PR draft path or prepared content.
9. Recommended reviewers and specialist needs.
10. Unresolved decisions, risks, follow-ups, approval gates, and next safe action.

Never describe `PR READY` as approval to merge.
