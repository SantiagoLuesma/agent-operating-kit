---
name: generate-handoff
description: Create or update a revision-specific repository handoff so a fresh agent, chat, or human can continue work safely without conversation history.
---

# Generate Handoff

## Purpose

Use this skill to create or update a concise, operationally complete handoff for an active workstream. The handoff captures temporary execution state at a specific repository revision and enables a contributor with no prior context to resume safely.

The handoff is not authority for stable product behavior, UX, architecture, feature rules, public contracts, decisions, or operations. Link to those sources instead of copying or redefining them.

This skill does not implement work, approve unresolved decisions, invent evidence, or use chat history as the source of truth.

## Core rules

* Follow `AGENTS.md` and applicable nested instructions.
* Inspect repository reality before writing.
* Record facts, evidence, assumptions, unknowns, and proposals separately.
* Make every material statement revision-specific and reproducible.
* Prefer links and precise locations over duplicated stable content.
* Never write secrets, credentials, personal data, customer data, private tokens, or unsafe access instructions.
* Never claim work, tests, review, rollback, or compatibility is complete without evidence.
* Never use vague directions such as “continue the work,” “finish testing,” or “fix remaining issues.”

## Required inputs

Locate or establish:

1. Handoff purpose: session transfer, agent transfer, interruption, review preparation, blocker escalation, pre-merge continuation, or recovery.
2. `AGENTS.md`, nested instructions, and `docs/project-status.md`.
3. Active ExecPlan and previous active handoff, when present.
4. Relevant product, feature, UX, architecture, ADR, contract, schema, security, and runbook documents.
5. Current branch, worktree, revision, base branch, upstream, working-tree state, and relevant commit range.
6. Complete diff, changed files, tests, migrations, dependencies, configuration, and generated artifacts.
7. Acceptance-verification results, review findings, approvals, blockers, and executed evidence.
8. Known rollback, recovery, compatibility, deployment, or migration constraints.

If repository identity, active scope, revision, or required authority cannot be established, do not guess.

## Repository inspection

Inspect from the active worktree, using repository-equivalent commands where Git is unavailable:

* repository root and applicable instructions;
* branch and detached-HEAD state;
* absolute or unambiguous worktree location;
* `HEAD` revision and base revision;
* configured upstream and divergence;
* staged, unstaged, untracked, conflicted, and relevant ignored files;
* active stashes or submodule state when they affect continuation;
* commits in the handoff range;
* complete diff and name-status summary;
* active plan, status document, handoff, and authoritative links;
* current implementation, contracts, migrations, tests, and documentation for the changed area.

Useful read-only Git commands include:

```text
git rev-parse --show-toplevel
git branch --show-current
git rev-parse HEAD
git status --short --branch
git worktree list --porcelain
git remote -v
git log --oneline --decorate <base>..HEAD
git diff --name-status <base>...HEAD
git diff --stat <base>...HEAD
```

Do not assume the base branch is `main`. Derive it from the approved plan, pull-request target, upstream, repository convention, or verified merge base. Mark it `UNKNOWN` when evidence is insufficient.

When the working tree is dirty, `HEAD` alone does not identify the current state. Enumerate staged, unstaged, untracked, and conflicted changes explicitly. Do not create a commit merely to simplify the handoff unless repository workflow permits it.

## Procedure

### 1. Establish purpose and active scope

State why the handoff exists, what approved workstream it covers, and the exact non-goals. Link to the active ExecPlan and stable specifications. Record any scope conflict without resolving it silently.

### 2. Capture repository identity

Record:

* repository and worktree;
* branch or detached revision;
* full `HEAD` commit;
* base branch and base commit;
* upstream and ahead/behind state when relevant;
* working-tree status;
* relevant commits;
* handoff creation or update time in an unambiguous format with timezone.

Use full commit hashes for identity and short hashes only as supplemental display.

### 3. Classify work status

Separate work into:

* **Completed:** implemented and supported by stated evidence.
* **Partially completed:** started, with exact finished and unfinished portions.
* **Pending:** approved but not started.
* **Blocked:** cannot proceed, including blocker, owner, required decision, and safe interim state.
* **Explicitly excluded:** non-goals and tempting adjacent work that must remain untouched.

Do not classify code presence as completion when required tests, documentation, review, or acceptance evidence is missing.

### 4. Reconcile plan, acceptance, and review state

For each active ExecPlan milestone, record status, deviations, and evidence.

For each acceptance criterion, use one status:

* `SATISFIED`
* `PARTIALLY SATISFIED`
* `NOT SATISFIED`
* `NOT VERIFIED`
* `NOT APPLICABLE`

Link to the criterion and reference the implementation, test, or executed evidence. Preserve failed or inconclusive results.

Summarize review findings by identifier, severity, disposition, and location:

* fixed and verified;
* fixed but not reverified;
* open;
* accepted risk with approval;
* disputed or awaiting decision.

### 5. Build the implementation map

List changed files using the diff, then identify only the locations a fresh contributor needs:

* primary entry points and module boundaries;
* contracts, APIs, events, schemas, and generated sources;
* migrations, backfills, fixtures, or data transforms;
* authorization, tenancy, security, and configuration boundaries;
* added or changed dependencies and lockfiles;
* tests and documentation affected;
* temporary files, debug artifacts, or generated outputs requiring attention.

Group mechanical or generated files instead of narrating every line. Link to authoritative design and contract documents instead of restating them.

### 6. Record executed evidence

For every relevant command or test, record:

* exact command;
* working directory;
* revision;
* environment and material tool or runtime versions;
* required non-secret configuration profile;
* result, exit code, and concise evidence;
* whether it exercises the changed behavior.

Separate:

1. passing checks;
2. failures caused by the current work;
3. proven pre-existing failures;
4. skipped, unavailable, or not-run checks.

A failure is “pre-existing” only when reproduced on the base revision or supported by equivalent recorded evidence. Otherwise classify it as unresolved or origin unknown.

Never paste sensitive environment values, credentials, or excessive logs. Reference retained artifacts when available.

### 7. Record safety and recovery context

Capture only what affects safe continuation:

* explicit assumptions and their evidence level;
* unresolved decisions and decision owner;
* known defects and user or operational impact;
* temporary workarounds, why they exist, and their removal condition;
* backward-compatibility and versioning concerns;
* migration sequencing and compatibility windows;
* rollback or recovery path and whether it was tested;
* residual risks and accepted-risk approvals.

Do not place privileged production procedures in the handoff. Link to the authorized runbook and state the required approval.

### 8. Define the next safe action

Provide exactly one primary next action that includes:

* target file, component, criterion, finding, or milestone;
* recommended skill;
* prerequisites;
* concrete action;
* validation to run;
* expected evidence;
* stop conditions.

Example form:

```text
Next action: Run `verify-acceptance-criteria` for AC-04 against revision <hash>.
Prerequisites: clean working tree and required local test service available.
Validate: <commands or repository check>.
Expected evidence: <specific result or artifact>.
Stop if: a contract conflict appears, a migration is destructive, or required authority is unavailable.
```

Add secondary actions only when ordered and dependent.

Never instruct the next contributor to deploy, merge, migrate production, change public contracts, access sensitive data, or accept material risk without the required approval.

## Required handoff structure

Store active handoffs under the repository convention, normally `docs/handoffs/active/<workstream>.md`, with these sections:

1. Purpose and scope
2. Authoritative references
3. Repository state
4. Work status
5. ExecPlan and acceptance status
6. Review findings
7. Implementation map
8. Commands and evidence
9. Assumptions, risks, defects, and workarounds
10. Compatibility, rollback, and recovery
11. Approval gates and prohibited actions
12. Next safe action and stop conditions

Use tables where they improve scanning, but keep explanations concise.

## Lifecycle rules

* **Create** a handoff when active work must cross a session, agent, chat, worktree owner, review boundary, or interruption.
* **Update** the existing active handoff for the same workstream whenever revision, scope status, evidence, blockers, or next action changes.
* **Supersede** when a replacement changes workstream identity, branch, base, or continuation strategy. Link both directions and mark the old handoff inactive.
* **Archive** after merge, abandonment, completion, or transfer into a completed plan according to repository convention.
* **Remove** only accidental duplicates or valueless generated copies after preserving necessary history in Git.

Avoid multiple active handoffs claiming authority over the same workstream. Do not archive an unresolved blocker without moving it to an authoritative active record.

## Handoff-quality gates

All gates must be evaluated:

### G1 — Identity

Repository, worktree, branch, `HEAD`, base, commit range, and working-tree state are exact and current.

### G2 — Scope and state

Approved scope, non-goals, completed work, partial work, pending work, blockers, and exclusions are unambiguous.

### G3 — Evidence

Plan progress, acceptance status, review findings, commands, tests, failures, and implementation claims are traceable to executed or inspectable evidence.

### G4 — Authority and safety

Stable sources are linked rather than duplicated; approvals and prohibited actions are explicit; no sensitive or unsafe information is exposed.

### G5 — Resumability

A fresh contributor can perform one exact next safe action, run the specified validation, recognize success, and stop under defined conditions.

## Quality review

Before finishing, check that the handoff is:

* **Fresh:** branch, revision, diff, plan, and working-tree state still match.
* **Consistent:** it does not contradict authoritative documents or executed evidence.
* **Non-speculative:** unverified claims are marked unknown or not verified.
* **Complete:** all required status categories and safety information are addressed.
* **Actionable:** the next contributor can perform one exact safe step.
* **Concise:** stable rules are linked, not duplicated.
* **Safe:** no secret, personal data, credential, sensitive log, or unsafe procedure appears.
* **Traceable:** claims point to paths, commits, criteria, findings, commands, or evidence.

Re-inspect repository identity and status after editing the handoff. Distinguish the handoff file’s own expected modification from pre-existing working-tree changes.

## Autonomy, approval gates, and stop conditions

Proceed autonomously with read-only inspection and local, reversible handoff edits.

Stop for human authority when continuation requires:

* scope expansion or acceptance-criteria changes;
* public-contract or compatibility changes;
* destructive migrations or irreversible data operations;
* production or sensitive-data access;
* secret or credential modification;
* authentication, authorization, tenancy, privacy, retention, or billing changes;
* deployment, release, merge, or shared-history rewriting;
* acceptance of Critical or High residual risk.

Use `REMEDIATION REQUIRED` when the state can be described but unsafe inconsistencies, missing documentation, failing change-related checks, or unresolved review findings must be corrected before normal continuation.

Use `BLOCKED` when repository identity or scope cannot be established, authoritative sources conflict critically, evidence may expose sensitive information, or no safe next action exists.

## Completion criteria

A handoff is complete only when:

* all five quality gates were evaluated;
* repository and worktree identity are exact;
* scope and non-goals are explicit;
* completed, partial, pending, blocked, and excluded work are addressed;
* plan, acceptance, and review states are evidence-based;
* changed locations, contracts, migrations, dependencies, tests, and documentation are mapped;
* executed commands and pre-existing failures are correctly separated;
* risks, approvals, recovery, and prohibited actions are clear;
* authoritative sources are linked without duplication;
* one exact next safe action, validation path, recommended skill, expected evidence, and stop conditions are provided;
* freshness, consistency, sensitivity, and verifiability checks pass.

## Outcomes

* **HANDOFF READY** — All quality gates pass; the handoff is current, safe, evidence-based, and independently usable.
* **READY WITH KNOWN GAPS** — Safe to continue; non-blocking gaps are explicit, bounded, and assigned a next action.
* **REMEDIATION REQUIRED** — Material repository, documentation, review, or evidence problems must be corrected before normal continuation.
* **BLOCKED** — A safe, truthful, revision-specific handoff cannot be produced.

## Required final report

Report:

1. Outcome.
2. Handoff path.
3. Workstream, branch, worktree, `HEAD`, and base.
4. Scope status summary.
5. Quality-gate results.
6. Evidence and review status.
7. Known gaps, risks, and blockers.
8. Approval gates and prohibited actions.
9. Exact next safe action and recommended skill.
10. Archive or update condition.

Do not report `HANDOFF READY` when the recorded revision is stale, material claims are unverified, authoritative sources conflict, sensitive information is exposed, or the next action is ambiguous.
