---
name: prepare-release
description: >
  Prepare a release after the integration branch is healthy: verify release
  scope, version/changelog readiness, migrations and rollout plans, monitoring
  and rollback, artifacts and checklist for human release approval. Use after
  verify-main (or equivalent). Does not deploy to production, change traffic,
  or approve the release—stops at a release package and go/no-go recommendation.
---

# Prepare Release

## Purpose

Determine whether a verified integration revision is **ready to release** to a
target environment (staging promotion or production), and assemble an
evidence-based release package for human approval.

This skill prepares. It does **not** deploy, flip production flags, run
production migrations, or grant release authority.

## When to use

Use when:

* `verify-main` (or equivalent) passed for the intended revision;
* a version/tag or release train is planned;
* migrations, flags, or multi-service ordering need an explicit plan;
* stakeholders need a go/no-go checklist.

Do not use as a substitute for:

* feature acceptance (`verify-acceptance-criteria`);
* PR readiness (`prepare-pr`);
* incident response.

## Expected inputs

* integration branch revision and `verify-main` evidence;
* merged PRs / changelog fragments in scope;
* feature flags, migrations, runbooks;
* `docs/architecture/deployment.md`, `docs/runbooks/*`, `SECURITY.md`;
* monitoring dashboards/alerts definitions when they exist;
* previous release notes if any.

## Deliverables

Create or update:

```text
docs/plans/active/release-<version-or-date>.md   # or docs/releases/
docs/project-status.md
```

Optionally draft release notes under the repository’s conventional path.

## Procedure

### 1. Pin the release candidate

Record:

* exact git revision / tag candidate;
* integration branch name;
* verify-main (or CI) results and time;
* included changes (PR list or commit range);
* explicit exclusions.

Do not prepare a moving target.

### 2. Confirm scope and risk class

Classify the release:

* routine / low risk;
* features user-visible;
* migrations;
* security-sensitive;
* breaking contract changes;
* rollback-hard.

Ensure breaking changes and auth/tenancy/billing impacts have approvals.

### 3. Versioning and notes

* propose version per repository scheme (semver or calendar);
* draft user/operator-facing notes from actual merged changes;
* never invent features that are not in the revision.

### 4. Migration and data plan

If schema/data/API migrations exist:

* order of operations;
* expand/contract stages;
* backfill strategy;
* expected duration and locks;
* verification queries;
* rollback or roll-forward plan;
* whether `review-migration` was completed.

Stop for human approval before any production migration.

### 5. Rollout plan

Define:

* target environments sequence;
* feature flag defaults and owners;
* percentage/staged rollout if used;
* bake time and promotion criteria;
* abort signals.

### 6. Monitoring and support

List:

* metrics/logs/traces to watch;
* alerts that must be green or newly added;
* known issues and customer communication needs;
* on-call / support owner during rollout.

### 7. Rollback and recovery

Document:

* how to stop rollout;
* how to revert app vs data;
* irreversible steps already taken;
* time objectives if defined in quality attributes.

“Redeploy previous image” alone is insufficient when data changed.

### 8. Artifacts and checklist

Assemble:

* revision and build identifiers;
* artifact locations (without secrets);
* config/secret requirements (names only);
* runbook links;
* go/no-go checklist with owners.

### 9. Adversarial go/no-go

Challenge:

* Is verify evidence for this exact revision?
* Any open Critical/High defects?
* Any migration without rollback story?
* Any flag default that exposes unfinished work?
* Any dependency not yet released?

## Gates

### RELEASE READY

Package complete; human may approve deployment through normal controls.

### READY WITH CONTROLS

Releasable under explicit guardrails (staged %, flag off by default, etc.).

### NOT READY

Blockers must be fixed; list them.

### BLOCKED

Missing evidence, authority, or unsafe unknowns.

## Prohibitions

Do not:

* deploy or migrate production;
* change live traffic or DNS;
* store secrets in release docs;
* mark RELEASE READY with failing verify evidence;
* include unmerged work;
* skip migration review for destructive changes;
* approve your own production release.

## Final report

1. Gate / go-no-go recommendation  
2. Candidate revision and version  
3. Scope summary  
4. Migration/rollout/rollback posture  
5. Monitoring and owners  
6. Blockers and residual risks  
7. Docs updated  
8. Required human approvals  

Human gates remain: **release approval** and **production execution**.
