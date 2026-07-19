---
name: update-documentation
description: Update repository documentation after an approved change so behavior, contracts, decisions, operations, and project state remain accurate, traceable, safe, and non-duplicated.
---

# Update Documentation

## Purpose

Use this skill after an approved product, UX, architecture, API, data, operational, migration, or implementation change. Reconcile repository documentation with the approved intent, actual diff, and executed evidence so the repository remains the source of truth.

This skill updates documentation. It does not invent behavior, redesign the change, implement missing functionality, approve its own scope, or treat chat history as authority.

Document behavior, contracts, decisions, risks, and operations. Do not narrate code line by line or restate details already obvious from the implementation.

## Core rules

* Follow `AGENTS.md` and the repository's documented authority hierarchy.
* Inspect before editing. Never update docs from the task description alone.
* Separate approved intent, implemented reality, executed evidence, assumptions, and unknowns.
* Prefer one canonical explanation with links from dependent documents.
* Preserve useful history without leaving obsolete instructions active.
* Never claim a command, example, migration, recovery path, or workflow works without appropriate evidence.
* Never expose secrets, credentials, personal data, customer data, private endpoints, or unsafe operational details.
* Keep changes limited to documentation affected by the approved change.

## Required inputs

Obtain or locate:

1. `AGENTS.md` and applicable nested instructions.
2. `docs/project-status.md` when present.
3. The approved requirement, feature specification, acceptance criteria, ADR, contract, migration review, or equivalent authority.
4. The active ExecPlan and latest relevant handoff, when present.
5. The complete change diff, including migrations, configuration, generated files, tests, and deleted or renamed paths.
6. Review and verification results, commands executed, revision, environment, and known failures.
7. Existing documentation for every affected product area, interface, subsystem, data owner, and operational procedure.

If the approved source, change boundary, comparison base, or implementation evidence cannot be established, do not guess. Record the gap and use `BLOCKED` or `REMEDIATION REQUIRED` as appropriate.

## Documentation authority map

Use the repository's own map when defined. Otherwise treat these as conventional defaults, without creating duplicate structures:

| Concern                                                          | Typical authoritative source                                               |
| ---------------------------------------------------------------- | -------------------------------------------------------------------------- |
| Agent governance and gates                                       | `AGENTS.md`                                                                |
| Project purpose and setup entry point                            | `README.md`                                                                |
| Product goals, scope, rules, and non-goals                       | `docs/product/`                                                            |
| User flows, states, content, and accessibility behavior          | `docs/ux/`                                                                 |
| Architecture, boundaries, data ownership, and quality attributes | `docs/architecture/`                                                       |
| Stable feature behavior and acceptance criteria                  | `docs/features/<feature>/spec.md`                                          |
| Feature implementation design and trade-offs                     | `docs/features/<feature>/technical-design.md`                              |
| Verification strategy and coverage                               | `docs/features/<feature>/test-plan.md`                                     |
| Public APIs, events, schemas, and compatibility                  | `contracts/`, OpenAPI, AsyncAPI, GraphQL schemas, or repository equivalent |
| Accepted decisions                                               | `docs/decisions/adr/`, `docs/decisions/product/`                           |
| Operational procedures                                           | `docs/runbooks/`, deployment docs, `SECURITY.md`                           |
| Temporary execution state                                        | `docs/plans/active/`, `docs/handoffs/active/`                              |
| Completed execution history                                      | `docs/plans/completed/`, archived handoffs                                 |
| Current phase, gate, risks, blockers, and next action            | `docs/project-status.md`                                                   |
| Implemented evidence                                             | code, tests, migrations, configuration, generated artifacts                |

Code and tests may prove current behavior, but they do not silently replace an approved product decision or public contract. When authority and implementation conflict, surface the conflict rather than choosing the convenient source.

## Stable documentation versus temporary state

Stable documentation describes behavior or decisions expected to remain true across sessions and implementations. Examples include product scope, feature specs, architecture, contracts, ADRs, schemas, and runbooks.

Temporary documentation describes work in progress: branch, revision, completed steps, pending commands, blockers, deviations, and next safe action. Keep it in active plans or handoffs. Do not promote temporary observations into stable truth without approval and evidence. When work completes, move or mark temporary artifacts completed according to repository convention.

## Procedure

### 1. Establish the documentation boundary

* Identify the approved change and its explicit non-goals.
* Determine the base and target revisions.
* Inspect `git status`, the complete diff, relevant commits, renames, deletions, and generated outputs.
* List affected behavior, actors, permissions, data, contracts, dependencies, operations, and risks.
* Exclude unrelated cleanup, broad rewrites, formatting sweeps, and speculative future behavior.

### 2. Perform documentation impact analysis

For each changed concern, identify:

* its canonical document;
* dependent documents that should link to it;
* requirements and acceptance criteria affected;
* implementation and migration evidence;
* tests or operational evidence;
* compatibility, rollout, rollback, support, or security implications.

Classify documentation defects:

* **Stale:** describes behavior no longer true.
* **Contradictory:** authoritative sources disagree.
* **Duplicated:** the same rule is maintained in multiple places.
* **Orphaned:** no longer linked, owned, or applicable.
* **Missing:** changed behavior or operation lacks an authoritative explanation.
* **Unverified:** commands, examples, or claims lack current evidence.

Resolve defects within scope. Record adjacent defects instead of silently expanding the task.

### 3. Update the canonical documents

Apply the smallest coherent update:

* **Feature specs:** update observable behavior, actors, permissions, states, validation, edge cases, failure behavior, non-goals, and acceptance criteria only when the approved change altered them.
* **Technical designs:** update boundaries, responsibilities, dependencies, data flows, consistency, failure handling, trade-offs, rollout, and rollback. Avoid implementation narration.
* **Test plans:** map changed acceptance criteria and risks to test levels, fixtures, environments, and required evidence. Distinguish automated, manual, and not-yet-covered checks.
* **Architecture diagrams:** update affected boundaries, trust zones, integrations, ownership, and flows. Preserve an editable source when the repository uses one; do not keep a stale image beside an updated description.
* **API or event contracts:** update the canonical machine-readable source first, including compatibility, errors, authorization, idempotency, pagination, versioning, and deprecation where relevant.
* **Schemas and data docs:** document ownership, constraints, defaults, nullability, indexes, lifecycle, tenant boundaries, retention, migrations, backfills, and compatibility. Do not copy the full schema into prose.
* **Runbooks:** update prerequisites, safe commands, expected signals, failure detection, rollback or recovery, escalation, and access boundaries. Mark unexecuted procedures explicitly as unverified.
* **Changelogs or release notes:** include user- or operator-relevant changes under the repository's existing convention. Do not invent a version, release date, or deployment status.
* **`project-status.md`:** update current phase, gate, objective, completed scope, blockers, risks, authoritative documents, next safe action, and next recommended skill. Do not turn it into a historical log.
* **ExecPlans and handoffs:** record actual progress, evidence, decisions, deviations, revision, and next action. Do not use them to override stable documentation.

For generated documentation, edit the source and run the established generator. Do not hand-edit generated output unless the repository explicitly requires it. Record generator failures or unavailable tooling.

### 4. Maintain traceability

For every materially changed behavior or contract, make it possible to trace:

`requirement or decision -> acceptance criterion -> implementation or migration -> test evidence -> operational procedure`

Use stable identifiers or links already present. Add identifiers only when they improve navigation and do not create a parallel tracking system. Reference canonical material rather than copying it.

### 5. Manage document and ADR lifecycle

* **Create** a document only when no canonical home exists and the information is stable and necessary.
* **Update** when the same concern and decision remain active.
* **Supersede** an ADR when a new approved decision replaces it; retain the old rationale and link both directions.
* **Archive** temporary, historical, or no-longer-active material that remains useful for audit or context.
* **Delete** only when content is accidental, fully duplicated, generated from another source, or valueless after history is preserved in Git. Obtain approval before deleting authoritative or audit-relevant records.

Do not rewrite an accepted ADR to make an old decision appear never to have existed. Mark status, consequences, replacement, and effective scope clearly. Do not create an ADR for routine implementation detail.

### 6. Validate documentation

Run the repository's established documentation checks when available. Otherwise perform targeted validation:

* links, anchors, references, and file paths resolve;
* commands and examples match current interfaces and repository conventions;
* terminology, names, status labels, and versions are consistent;
* diagrams match prose and implementation;
* contracts and generated docs are synchronized with their source;
* examples use synthetic, non-sensitive data;
* no secret, token, personal data, internal credential, or unsafe access detail was introduced;
* changed claims agree with the actual diff and executed evidence;
* deleted or renamed artifacts have no stale active references.

Never run destructive, production, privileged, or externally visible commands merely to validate documentation. Use existing evidence or request approval.

### 7. Review the documentation diff

Review the complete final diff independently from the editing pass. Confirm that:

* every impacted canonical document was considered;
* no unchanged behavior was accidentally redefined;
* no temporary state became stable policy;
* no information was duplicated unnecessarily;
* known gaps are explicit and actionable;
* scope and non-goals remain intact;
* historical context is preserved without activating obsolete guidance.

## Autonomy, approval gates, and stop conditions

Proceed autonomously with local, reversible documentation corrections that faithfully reflect approved behavior and evidence.

Stop and request approval before documenting a new product rule, acceptance criterion, public compatibility guarantee, architecture decision, security or privacy policy, billing behavior, destructive operation, production access procedure, or accepted Critical/High risk that was not already approved.

Stop with `BLOCKED` when critical authorities conflict, sensitive information may be exposed, the actual change cannot be inspected, or the required decision owner is unavailable. Use `REMEDIATION REQUIRED` when implementation, contracts, tests, or operations materially contradict approved documentation and documentation alone cannot make the repository truthful.

## Completion criteria

Documentation work is complete only when:

* the approved change and diff were inspected;
* impact analysis covered all affected concerns;
* canonical documents are accurate and non-duplicated;
* stable and temporary state are correctly separated;
* traceability is sufficient for a fresh agent or reviewer;
* links, paths, examples, terminology, versions, and generated docs were validated;
* security and privacy review found no unsafe disclosure;
* remaining gaps, owners, and next actions are recorded;
* the final documentation diff matches implemented and executed evidence.

## Outcomes

* **DOCUMENTATION UPDATED** — All impacted documentation is accurate, validated, traceable, and complete for the approved scope.
* **UPDATED WITH KNOWN GAPS** — Canonical documentation is accurate enough to proceed, with explicit non-blocking gaps, limitations, owners, and next actions.
* **REMEDIATION REQUIRED** — Material divergence, missing evidence, or implementation/contract defects prevent documentation from becoming reliably truthful without additional work.
* **BLOCKED** — Critical authority, evidence, access, safety, or approval is missing; safe documentation updates cannot be completed.

## Required final report

Report:

1. Outcome.
2. Approved change and revisions inspected.
3. Documentation impact summary.
4. Files created, updated, superseded, archived, or deleted.
5. Traceability established.
6. Checks and commands executed, with results and environment.
7. Contradictions, stale material, and duplication resolved.
8. Known gaps, risks, and unverified claims.
9. Security and privacy findings.
10. Remaining work and next safe action.

Do not report `DOCUMENTATION UPDATED` when material claims remain unverified or canonical sources still disagree.
