---
name: build-walking-skeleton
description: >
  Implement the thinnest end-to-end path that proves the approved architecture
  and core product loop: one vertical slice through UI or API, application
  logic, persistence or equivalent, and verification. Use after architecture
  review approval and before building out full feature breadth. Produces a
  runnable skeleton with tests and docs updates, not a full product. Follow
  implement-vertical-slice discipline without expanding to all MUST features.
---

# Build Walking Skeleton

## Purpose

Prove that the proposed architecture and core loop can run **end to end** with
the smallest amount of behavior: enough to exercise real boundaries (identity
stub or real auth as approved, one write/read path, one output, observability
hooks if required), so later vertical slices extend a living system instead of
a slide deck.

A walking skeleton is a **vertical** thin slice, not a horizontal layer cake
(frontend-only or database-only).

## When to use

Use when:

* architecture has gate `APPROVED` or `CONDITIONALLY APPROVED` with skeleton
  allowed;
* quality attributes that affect the skeleton are known enough;
* the team needs a runnable baseline before multiple feature slices;
* greenfield or major brownfield path needs integration proof.

Do not use when:

* only a local bug fix is needed (`quick`);
* architecture is rejected or blocked;
* the “skeleton” would require irreversible production migration—stop for
  approval and planning first.

## Relationship to other skills

| Skill | Role |
| --- | --- |
| `design-architecture` / `review-architecture` | Define/approve structure |
| `build-walking-skeleton` | First runnable end-to-end proof |
| `implement-vertical-slice` | Subsequent full-behavior slices |
| `create-exec-plan` | Optional plan wrapping skeleton + follow-on slices |

Prefer creating a short ExecPlan milestone named “walking skeleton” when the
repository uses plans.

## Expected inputs

* approved architecture docs and review outcome;
* scope core loop and MUST outcome for the increment;
* `docs/project-status.md`;
* repo toolchain / `scripts/verify` hooks;
* explicit non-goals for the skeleton (what not to build yet).

## Skeleton scope rules

**Include (minimum that proves the path):**

* one primary actor happy path through the real architectural boundaries;
* persistence or equivalent durable effect if the architecture requires it;
* authorization check at a trusted boundary (even if only one role exists);
* automated test(s) that fail when the path breaks;
* basic error path or explicit deferred error list with reason;
* runnable local (or approved preview) instructions.

**Exclude unless drivers demand them now:**

* full feature set, polish UI, every role, every edge case;
* multi-region, elaborate caching, speculative microservices;
* production data migration;
* billing integrations;
* broad refactors unrelated to the path.

## Procedure

### 1. Define skeleton contract

Write in the ExecPlan or `docs/architecture/` note:

* actor and trigger;
* observable success outcome;
* boundaries crossed (list containers/modules);
* data written/read;
* explicit non-goals;
* acceptance checks for the skeleton only;
* rollback: how to disable or delete the skeleton safely.

### 2. Baseline the repository

* confirm branch is not protected main;
* run `./scripts/verify` (or record NOT CONFIGURED and establish minimum
  commands);
* record revision and pre-existing failures.

### 3. Implement the thin path

Implement only what the skeleton contract requires, in dependency-safe order:

* contract/API or UI entry;
* application/domain rule (minimal);
* authz at trusted boundary;
* persistence or external call with timeout/error handling as needed;
* wiring/config for local run;
* tests at the lowest reliable level plus one end-to-end or integration check.

Follow repository conventions. No drive-by refactors.

### 4. Prove it runs

Execute:

* unit/integration tests for the path;
* `./scripts/verify` and `./scripts/test` when configured;
* manual smoke only if automated coverage cannot yet hit the path—document
  steps.

Capture evidence: commands, results, revision.

### 5. Observe and harden lightly

Add only essential logging/metrics hooks required by architecture drivers.
Do not build a full observability platform.

### 6. Document

Update:

* ExecPlan milestone status;
* architecture note “skeleton implemented at revision …”;
* `docs/project-status.md`;
* handoff if work may switch agents (`generate-handoff`).

### 7. Hand off to full slices

List the next vertical slices that extend the skeleton toward MUST scope.
Do not implement them inside this skill unless explicitly ordered as separate
milestones.

## Acceptance for the skeleton

The skeleton is done when:

* a new contributor can run it locally (or approved env) with documented steps;
* the primary path crosses the intended architectural boundaries for real;
* tests fail if the path is broken;
* non-goals remain unbuilt;
* verify evidence is recorded;
* risks deferred from the skeleton are explicit.

## Gates

### SKELETON COMPLETE

Path proven; ready for further `implement-vertical-slice` work.

### SKELETON COMPLETE WITH FOLLOW-UPS

Path proven; listed non-blocking follow-ups tracked.

### REFINEMENT REQUIRED

Architecture or scope ambiguity prevents a meaningful thin path.

### BLOCKED

Toolchain, credentials, or approvals missing; or only unsafe paths exist.

### FAILED — RECOVERY REQUIRED

Partial implementation left the repo unhealthy; restore safety before
continuing.

## Prohibitions

Do not:

* work on protected main;
* expand into full feature delivery under the skeleton name;
* skip authz because “it’s only a skeleton” when real data is involved;
* disable tests to pass;
* deploy to production as part of this skill without separate approval;
* claim SKELETON COMPLETE without executed evidence.

## Final report

* Gate  
* Skeleton contract (path proven)  
* Boundaries exercised  
* Commands and results  
* Deferred work list  
* Docs/plans updated  
* Next slice recommendation  

## Note

If the repository already has a mature runnable system and only a new
subsystem is introduced, the skeleton may be limited to that subsystem’s
end-to-end path—still vertical, still proven with evidence.
