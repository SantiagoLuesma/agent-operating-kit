---
name: validate-assumptions
description: >
  Identify, classify, prioritize, and validate critical assumptions for a
  product, feature, or architecture. Turn uncertainty into evidence-based
  decisions by designing falsifiable experiments, evaluating behavioral
  signals, and recommending proceed, pivot, or stop. Use after discovery or
  when a design depends on unproven claims. Produces an assumption register,
  experiment plans, and a validation summary with an explicit gate. Does not
  implement product code, contact users without approval, or invent evidence.
---

# Validate Assumptions

## Purpose

Discover what must be true for a product, feature, or architecture decision to
succeed; prioritize the most lethal assumptions; and design the cheapest
ethical experiments that can refute or support them with behavior-based
evidence—not opinions.

**Core formula:**

`Plausibility ≠ Evidence ≠ Validation ≠ Absolute guarantee`

Success is reducing uncertainty enough for a responsible decision: proceed,
pivot, or stop.

This skill validates. It does not implement production features, silently
expand scope, or treat stakeholder confidence as proof.

## When to use

Use when:

* discovery produced critical unknowns;
* a feature or architecture decision depends on unproven user, market, or
  technical claims;
* stakeholders disagree on what “must be true”;
* the cost of being wrong is high (security, billing, multi-tenant data,
  irreversible UX);
* experiments are needed before freezing scope or building a large slice.

Do not use as a substitute for:

* full product discovery (`discover-product`);
* feature specification (`design-feature`);
* implementation or production experiments without approval.

## Compatibility

Model- and client-agnostic. Repository documentation is the source of truth.
Chat history is supporting context only.

## Expected inputs

Review when available:

* `AGENTS.md` and `docs/project-status.md`;
* product docs (`docs/product/`), discovery outputs, scope;
* feature specs and open questions;
* architecture and quality-attribute docs when technical assumptions matter;
* prior research, analytics, support tickets, sales notes (as labeled evidence);
* legal/compliance constraints that bound experiments.

Do not invent interviews, metrics, or market demand.

## Guardrails

1. **Falsifiability:** experiments must be able to fail. If every outcome can
   be spun as success, redesign the experiment.
2. **Predefined criteria:** set success, failure, and inconclusive thresholds
   before analyzing results.
3. **Behavior over opinion:** prefer observed action and commitment (time,
   money, migration effort) over “Would you use this?”
4. **No invented evidence:** missing data is an explicit gap.
5. **Human approval required before:** contacting real users, charging money,
   collecting PII, running production-affecting or harmful fake doors, or
   accessing customer data.
6. **Autonomy:** extract and prioritize assumptions from the repository first;
   do not open with a generic questionnaire.

## Evidence levels

| Level | Meaning |
| ---: | --- |
| 0 | Opinion / preference |
| 1 | Stakeholder assertion without observation |
| 2 | Analogy or competitor claim |
| 3 | Lightweight behavioral signal (prototype, waitlist with friction) |
| 4 | Structured research (interviews with observed tasks, usability tests) |
| 5 | Analytics / commitment metrics in a controlled setting |
| 6 | Production behavior under real incentives |

Higher levels can still be wrong. Record limitations.

## Assumption statuses

`Unexamined` | `Planned` | `Testing` | `Supported` | `Partially Supported` |
`Refuted` | `Inconclusive` | `Accepted Risk`

## Procedure

### 1. Establish validation context

Record:

* decision this validation unblocks;
* product area or feature;
* planning horizon;
* what happens if we proceed wrongly;
* constraints (legal, ethics, budget, time);
* available evidence sources.

### 2. Extract and normalize assumptions

From docs and stakeholder claims, extract implicit and explicit statements.

Watch for soft language: “obviously,” “intuitive,” “users want,” “scalable,”
“everyone needs.”

Decompose compound claims into independent, testable statements:

> Bad: “SMBs will pay for automatic reporting because it saves time.”  
> Better: (a) SMBs spend material time on reporting; (b) they trust automation
> enough to adopt; (c) they will pay price P within period T.

Classify each assumption:

* Problem
* User / segment
* Value / willingness to pay
* Usability
* Adoption / activation
* Retention
* Monetization
* Technical feasibility
* Data availability / quality
* Legal / compliance / privacy
* Operational / support

### 3. Score and prioritize

For each assumption score:

| Dimension | Scale |
| --- | --- |
| Impact if false | Low / Medium / High / Critical |
| Uncertainty | Low / Medium / High |
| Reversibility of dependent decision | Easy / Moderate / Difficult / Irreversible |

**Lethal assumptions** = high/critical impact + high uncertainty + difficult or
irreversible decision dependency.

Prioritize lethal assumptions first. Do not run expensive experiments on
cosmetic unknowns.

### 4. Assess existing evidence

For each priority assumption:

* list available evidence with level 0–6;
* note sample bias and recency;
* assign status;
* decide: enough to decide, needs experiment, or accept risk with owner.

### 5. Design experiments

For each lethal assumption lacking sufficient evidence, design the cheapest
ethical test that can refute it.

Methods (examples):

* task-based interview / observation;
* usability test on prototype;
* concierge / wizard-of-oz;
* ethical fake door with clear follow-up;
* pricing or commitment smoke test (with approval);
* technical spike with pass/fail metrics;
* analysis of existing support/usage data.

Each experiment must include:

* target assumption IDs;
* hypothesis in behavioral form;
* method and participants/data source;
* success criteria (pre-registered);
* failure criteria;
* inconclusive criteria;
* duration and cost bound;
* ethics / privacy guardrails;
* decision enabled by the result.

Hypothesis template:

> For [segment], when [context], we expect [measurable behavior] within
> [time], because [mechanism].

### 6. Execute or plan execution

* If evidence already exists in the repository or provided artifacts, analyze
  it now against pre-registered criteria.
* If new fieldwork is required, produce experiment plans and stop for human
  approval before contacting users or spending budget.
* Never fabricate results to close the gate.

### 7. Analyze and recommend a gate

Compare results to predefined thresholds. Do not move goalposts.

Separate:

* supported assumptions;
* refuted assumptions;
* inconclusive items;
* accepted residual risks (owner + monitoring).

Recommend product consequences: freeze scope, narrow segment, change solution,
defer build, or stop.

### 8. Synchronize repository state

Update:

* `docs/product/assumptions.md` (or `docs/product/assumption-register.md`);
* experiment plans under `docs/product/` or `docs/plans/active/` as fits;
* validation summary;
* `docs/project-status.md` (gate, blockers, next skill).

## Deliverables

Create or update:

```text
docs/product/assumptions.md          # register (canonical preferred path)
docs/product/experiments.md          # optional experiment plans
docs/product/validation-summary.md   # gate and decisions
docs/project-status.md
```

If the project already uses other paths from discovery, update those canonical
files instead of duplicating.

### Assumption register entry

```markdown
## ASM-001: <short title>
- **Statement:**
- **Category:**
- **Impact if false:**
- **Uncertainty:**
- **Reversibility of dependent decision:**
- **Priority:** P0 | P1 | P2
- **Evidence (levels):**
- **Status:**
- **If false:**
- **Experiment:** EXP-00N | none
- **Owner:**
```

### Experiment entry

```markdown
## EXP-001: <title>
- **Target assumptions:** ASM-001
- **Method:**
- **Hypothesis:**
- **Success criteria:**
- **Failure criteria:**
- **Inconclusive criteria:**
- **Guardrails / ethics:**
- **Status:** Planned | Running | Complete
- **Result:**
- **Decision enabled:**
```

## Gates

### VALIDATED TO PROCEED

Lethal assumptions are supported or safely bounded; dependent decisions may
continue (usually to `define-product-scope` or design skills).

### CONDITIONAL PROCEED

Proceed only under explicit guardrails, limited rollout, or time-boxed
accepted risk with owners.

### MORE EVIDENCE REQUIRED

Critical uncertainty remains; experiments are designed or in progress.

### PIVOT RECOMMENDED

Problem may remain valid, but solution, segment, or model is refuted or weakly
supported; recommend a concrete pivot direction.

### STOP RECOMMENDED

Core assumptions refuted or residual risk unacceptable; do not invest in the
current direction without a new discovery cycle.

### BLOCKED

Cannot validate safely without authority, data access, or ethics approval.

## Prohibitions

Do not:

* invent users, quotes, metrics, or interview results;
* contact users or collect PII without approval;
* run production-impacting experiments without approval;
* treat opinions as Level 5–6 evidence;
* bury refuted assumptions;
* expand product scope under the guise of “learning”;
* implement production features as a “quick test” without an experiment frame;
* declare VALIDATED TO PROCEED while lethal assumptions remain Unexamined.

## Final report

Include:

1. Gate outcome  
2. Decision this validation was meant to unlock  
3. Lethal assumptions and statuses  
4. Experiments designed / evidence analyzed  
5. Refuted or pivoted claims  
6. Accepted residual risks and owners  
7. Documentation updated  
8. Next recommended skill  
9. Human approvals still required  

Typical next skills:

* `define-product-scope` when validation supports an increment;
* `discover-product` when the problem framing itself failed;
* `design-feature` / `design-architecture` when assumptions are local to a design;
* `audit-existing-project` when the unknown is the current system, not the market.
