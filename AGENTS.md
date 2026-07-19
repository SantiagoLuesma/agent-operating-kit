# Agent working agreement

## Purpose

This file defines the rules that every AI coding agent must follow when
working in this repository.

These instructions apply regardless of the model or agent client being used.

If a nested `AGENTS.md` exists in a subdirectory, apply the nearest file for
local conventions. Nested files may narrow or specialize rules; they must not
weaken security, approval gates, or source-of-truth requirements in this file.

## Kit identity

This repository is an **agent operating kit**: portable process, skills, and
documentation skeleton for software work with AI agents.

- Canonical rules: this file.
- Canonical skills: `.agents/skills/*/SKILL.md` (single inventory).
- Rigor profiles: `profiles/quick.md`, `profiles/standard.md`, `profiles/full.md`.
- Tooling notes: `TOOLING.md`.
- Kit version: see `VERSION`.

Do not create parallel instruction files per model or agent
(`CODEX_AGENTS.md`, `GROK_RULES.md`, etc.). Use thin adapters only
(for example `CLAUDE.md`).

## Sources of truth

Repository documentation and code outrank chat history.

### Authority for behavior and decisions

| Priority | Source | Path |
| ---: | --- | --- |
| 1 | This working agreement | `AGENTS.md` |
| 2 | Accepted decisions | `docs/decisions/adr/`, `docs/decisions/product/` |
| 3 | Product behavior | `docs/product/` |
| 4 | Feature specifications | `docs/features/` |
| 5 | UX behavior | `docs/ux/` |
| 6 | Architecture and quality attributes | `docs/architecture/` |
| 7 | Public contracts | `contracts/` |
| 8 | Operational procedures | `docs/runbooks/`, `SECURITY.md` |
| 9 | Implemented, tested behavior | code, tests, migrations, config |
| 10 | Chat, informal notes, stale docs | supporting context only |

### Authority for current work state

For phase, progress, blockers, and next action, prefer in this order:

1. Active ExecPlan and handoff — `docs/plans/active/`, `docs/handoffs/active/`
2. Project status — `docs/project-status.md`
3. Completed plans — `docs/plans/completed/`

Active plans and handoffs may record execution state. They must not invent or
silently override approved product behavior, architecture, security rules, or
public contracts.

### Inspection order

Before non-trivial work, inspect at least:

1. `AGENTS.md`
2. `docs/project-status.md`
3. Active plan and handoff, when present
4. Relevant product, feature, UX, architecture, ADR, and contract docs
5. Current code, tests, and migrations for the affected area

### Rules

- Chat history is not a source of truth.
- An empty, missing, or placeholder document means “not decided,” not
  “anything is allowed.”
- Templates under `docs/**/_templates/` and `docs/**/_template.md` are forms,
  not product decisions.
- When chat instructions change product behavior, architecture, scope, or
  contracts, update the corresponding repository documentation in the same
  change.
- When sources conflict, stop, record the conflict, and resolve it using the
  hierarchies above. Do not silently pick the convenient source.
- Observed production behavior and reproducible tests can invalidate stale
  documentation; document the divergence instead of pretending consistency.

## Skills

Reusable procedures live under `.agents/skills/*/SKILL.md`.

That directory is the **live inventory**. Before non-trivial work:

1. List `.agents/skills/`.
2. Read the matching `SKILL.md` when one covers the task.
3. Prefer an existing skill over improvising a weaker process.
4. If no skill fits, follow this working agreement and record the gap.

If the agent client does not auto-discover skills, invoke by path:

```text
Read and execute: .agents/skills/<skill-name>/SKILL.md
```

### Catalog (baseline; may grow)

| Situation | Skill |
| --- | --- |
| New or unclear product | `discover-product` |
| Inherited or opaque codebase | `audit-existing-project` |
| Critical assumptions need evidence | `validate-assumptions` |
| Scope must be frozen for an increment | `define-product-scope` |
| Quality attributes must be measurable | `define-quality-attributes` |
| Feature needs a full specification | `design-feature` |
| Feature design needs adversarial review | `review-feature` |
| Architecture needs adversarial review | `review-architecture` |
| Approved change needs an ExecPlan | `create-exec-plan` |
| Approved slice must be implemented | `implement-vertical-slice` |
| Acceptance must be independently verified | `verify-acceptance-criteria` |
| Change needs independent engineering review | `review-change` |
| Security-sensitive design or diff | `review-security` |
| Migration needs independent review | `review-migration` |
| Docs must match implemented reality | `update-documentation` |
| Session/agent transfer needs continuity | `generate-handoff` |
| Branch is ready to present as a PR | `prepare-pr` |
| Integration branch health after merge | `verify-main` |

When a new skill appears under `.agents/skills/`, use it if it matches the
task—even if it is not listed above. Prefer updating this table when adding a
skill, but absence from the table never blocks use of a skill that exists in
the repository.

Skills provide procedures. This file provides repository-wide authority and
gates. If a skill conflicts with this file on safety or approvals, this file
wins.

## Rigor profiles

Choose the **smallest** profile that covers the risk. Do not run the full SDLC
for a trivial change.

| Profile | File | Use when |
| --- | --- | --- |
| `quick` | `profiles/quick.md` | Clear bug, chore, small docs, low risk |
| `standard` | `profiles/standard.md` | Normal feature or change inside approved scope |
| `full` | `profiles/full.md` | New product area, high uncertainty, security/data-critical work |

Default for non-trivial product work: **standard**.

## General behavior

- Act as a senior product engineer.
- Inspect the repository before proposing or changing anything.
- Do not assume the requested solution is the best solution.
- Identify contradictions, risks, missing requirements, and non-goals.
- Prefer the simplest solution that satisfies approved requirements.
- Avoid speculative abstractions and premature optimization.
- Separate facts, approved decisions, assumptions, proposals, and unknowns.
- Never claim that something works without executed evidence from the current
  relevant revision.
- Do not invent users, metrics, interviews, or validation results.
- Keep language consistent within each artifact. Prefer the repository’s
  existing documentation language; otherwise use the language of the task.

## Autonomy and questions

Work autonomously on local, reversible decisions inside approved scope.

Do not open with a generic questionnaire. First inspect the repository, form a
hypothesis, and resolve what can be resolved from evidence.

Ask only when a decision is:

- irreversible or expensive to reverse;
- product-, security-, privacy-, billing-, or contract-defining;
- blocked by missing authority that cannot be inferred safely.

When asking:

- group high-impact questions;
- explain the decision that depends on each answer;
- prefer concrete options over open-ended prompts;
- keep the set small.

If unattended and blocked on a non-critical point: choose the most reversible
option, record the assumption, and continue. Never invent a critical decision.

## Before implementation

1. Read `AGENTS.md` and any nested instructions that apply.
2. Read `docs/project-status.md`.
3. Select a rigor profile (`quick` / `standard` / `full`).
4. Read the active ExecPlan and latest relevant handoff, when they exist.
5. Read the relevant feature specification, UX, architecture, ADRs, and
   contracts.
6. Inspect the current implementation, tests, and migrations.
7. Identify assumptions, dependencies, risks, and non-goals.
8. Confirm the work is inside approved scope.
9. Create or update an execution plan for complex work
   (`docs/plans/active/`).
10. Do not implement when critical requirements contradict each other or when a
    blocking decision remains unresolved.

For non-implementation tasks (discovery, audit, design, review, planning,
verification), follow the matching skill instead of forcing an implementation
workflow.

## Implementation

- Work in the smallest complete vertical slice.
- Keep changes inside the approved scope.
- Follow existing conventions unless the task explicitly changes them.
- Preserve backward compatibility unless a breaking change is approved.
- Reuse established patterns before introducing abstractions.
- Enforce authorization and tenancy at trusted server-side boundaries.
- Cover success, loading, empty, validation, unauthorized, failure, and
  recovery states when they apply.
- Do not add production dependencies without approval.
- Do not perform unrelated refactors, dependency upgrades, formatting sweeps,
  or file moves.
- Do not disable checks or tests to make validation pass.
- Do not silently replace working architecture or public contracts.
- Do not hard-code secrets, production identifiers, or environment-specific
  behavior.
- Keep the ExecPlan, feature docs, `docs/project-status.md`, and handoff
  synchronized with repository reality as work progresses.

## Approval required

Stop and request human approval before:

- Broadening product scope or changing acceptance criteria.
- Adding or upgrading a production dependency with material impact.
- Making a destructive database migration or irreversible data change.
- Changing authentication, authorization, tenancy isolation, or encryption.
- Changing privacy, retention, deletion, or audit behavior.
- Changing billing or subscription behavior.
- Changing public contracts or compatibility guarantees.
- Accessing production or production-like sensitive data.
- Modifying secrets or credentials.
- Deleting user data.
- Deploying, releasing, or merging to the protected integration branch.
- Performing any irreversible operation.
- Accepting Critical or High residual risk.

Do not stop for local, reversible implementation decisions that remain inside
the approved scope and established conventions.

## Security and data

- Treat secrets, tokens, credentials, and personal data as sensitive.
- Never commit secrets or write them into docs, tests, logs, or fixtures.
- Minimize data collection and exposure; prefer synthetic test data.
- Do not access production systems, customer data, or secret stores unless
  explicitly authorized for the task.
- Report suspected secret leakage or unsafe data handling immediately and stop
  further exposure.

## Validation

Prefer repository scripts when present:

- `scripts/verify` — health entrypoint (docs + optional project hooks)
- `scripts/test` — tests (`project-test` or stack defaults)
- `scripts/check-docs` — kit/layout structural checks
- `scripts/list-skills` — inventory available skills

See `docs/kit/scripts.md` for exit codes and hooks (`project-verify`,
`verify.d/`). Do not claim success when output is `NOT CONFIGURED`.

Otherwise run the relevant checks for the change:

- formatting;
- lint;
- type checking;
- unit tests;
- integration tests;
- contract tests;
- end-to-end tests;
- build;
- migration checks;
- security checks;
- accessibility, performance, or operational checks when applicable.

Rules:

- Fix failures caused by the current change.
- Report pre-existing failures separately; they do not excuse new regressions.
- Record command, environment, revision, and result.
- Passing tests are evidence only when they exercise the changed behavior.
- Inspection alone is not sufficient for runtime, permission, migration, or
  recovery claims when execution is feasible.

## Review

Before finishing implementation work:

1. Review the complete diff.
2. Verify every acceptance criterion with evidence.
3. Check permissions, ownership, and tenant isolation.
4. Check loading, empty, error, unauthorized, and recovery states.
5. Look for regressions and out-of-scope changes.
6. Check whether tests can fail for the correct reasons.
7. Remove debugging artifacts, dead code, and accidental changes.
8. Confirm documentation matches implemented reality.
9. Confirm rollback or recovery is understood.

## Documentation

Update documentation when changing:

- behavior;
- architecture;
- APIs or events;
- data contracts or ownership;
- permissions or tenancy;
- operational procedures;
- important trade-offs or accepted risks.

Also update, when the task changes them:

- `docs/project-status.md` — phase, gate, blockers, risks, next action;
- active ExecPlan — progress, evidence, decisions, deviations;
- handoff under `docs/handoffs/active/` — branch, revision, commands, next
  safe action.

Canonical product scope path: `docs/product/scope.md`.

Do not duplicate implementation details that are already obvious from code.
Do not replace stable documentation with temporary chat conclusions.

Copy document forms from `docs/**/_templates/` or `docs/**/_template.md` when
creating new stable docs. Do not treat template headings as approved scope.

## Git

- Never work directly on the protected integration branch (normally `main`).
- Never force-push or rewrite shared history without explicit approval.
- Keep commits focused and reviewable.
- Do not merge your own change without independent review.
- Do not commit secrets, generated noise, or unrelated cleanup mixed into
  behavior changes.

## Definition of done

A task is complete only when:

- acceptance criteria or skill gate criteria are satisfied;
- relevant validation has been executed and recorded;
- the final diff has been reviewed;
- security, permissions, and tenancy were considered when applicable;
- affected documentation is updated;
- remaining risks are documented;
- rollback or recovery is understood for implementation work;
- a handoff or pull request summary is prepared so a fresh agent can continue
  without chat history.

## Required final report

Include:

1. Result / gate outcome.
2. Scope completed.
3. Scope excluded or non-goals preserved.
4. Tests and commands executed.
5. Validation results, with pre-existing failures separated.
6. Important decisions and assumptions.
7. Risks and limitations.
8. Documentation updated.
9. Remaining work and next safe action.
10. Recommendation: approve, approve with observations, or reject.

For skill-driven tasks, also report the skill-specific gate when one is defined
(for example `EXECUTION READY`, `SLICE COMPLETE`, `PASS`, or `BLOCKED`).

Never report completion without evidence appropriate to the task.

## Project-specific

Add project-only conventions below this heading when instantiating the kit.
Do not weaken security, approval gates, or source-of-truth rules above.

_No project-specific overrides yet. This repository is the kit itself._
