---
name: discover-product
description: >
  Discover, challenge, and structure a software product before designing its
  architecture or implementing it. Use when starting a project, redefining an
  existing product, evaluating an incomplete idea, or detecting omitted
  requirements, actors, rules, risks, assumptions, and opportunities. Produces
  evidence-based product documentation, an uncertainty register, a scope
  proposal, and an explicit recommendation on whether the project is ready to
  advance. Must not implement code or prematurely select the technical stack.
---

# Discover Product

## Executive summary

This skill operates in **three sequential phases**:

| Phase | Stages | Purpose |
|------|--------|---------|
| **A. Context** | 1–5 | Understand the terrain: real problem, actors, current process |
| **B. Design** | 6–14 | Define what is built: value, capabilities, rules, states |
| **C. Validation** | 15–22 | Challenge and harden: risks, assumptions, consistency, gate |

Stages may be **shortened, merged, or skipped** when the information
already exists and is verified. See the *Depth levels* section at the end.

---

## Table of contents

1. [Purpose](#1-purpose)
2. [Expected outcome](#2-expected-outcome)
3. [When to use this skill](#3-when-to-use-this-skill)
4. [When not to use this skill](#4-when-not-to-use-this-skill)
5. [Agent role](#5-agent-role)
6. [Mandatory principles](#6-mandatory-principles)
7. [Autonomy policy](#7-autonomy-policy)
8. [Information sources](#8-information-sources)
9. [Inputs](#9-inputs)
10. [Expected artifacts](#10-expected-artifacts)
11. [Execution process](#11-execution-process)
12. [New vs. existing differences](#12-new-vs-existing-differences)
13. [Documentation rules](#13-documentation-rules)
14. [Prohibitions](#14-prohibitions)
15. [Stop conditions](#15-stop-conditions)
16. [Agent anti-patterns](#16-agent-anti-patterns)
17. [Quality criteria](#17-quality-criteria)
18. [Self-assessment checklist](#18-self-assessment-checklist)
19. [Final report format](#19-final-report-format)
20. [Recommended invocation](#20-recommended-invocation)
21. [Handoff to the next skill](#21-handoff-to-the-next-skill)
22. [Depth levels](#22-depth-levels)

---

# 1. Purpose

This skill turns an idea, informal requirement, or partially defined product
into a **coherent, challenged, and verifiable product foundation**.

Its **goal is not to confirm** the user's idea. Its goal is to discover:

* what problem is being solved;
* for whom it is being solved;
* what outcome each actor expects to achieve;
* how it is currently solved;
* why someone would change their behavior;
* which parts of the idea are facts and which are assumptions;
* which capabilities, rules, or actors were omitted;
* which complexity can be eliminated;
* which risks might be discovered too late;
* which decisions need evidence;
* what must be validated before designing architecture or implementing.

The skill must produce a product definition clear enough to later enable:

1. validating the riskiest assumptions;
2. designing the user experience;
3. establishing an initial scope;
4. modeling rules and permissions;
5. defining quality attributes;
6. designing the architecture;
7. decomposing the product into verifiable increments.

This skill **must not design the definitive technical solution**.

---

# 2. Expected outcome

When finished, the repository must contain an explicit, consistent, and
**prioritized** representation of:

## Must-haves

1. problem definition (without mentioning the solution);
2. primary actors with their needs;
3. verifiable value proposition;
4. candidate scope and non-goals;
5. critical assumptions with a validation plan;
6. risks with mitigation or a validation plan;
7. gate recommendation (PASS / CONDITIONAL PASS / BLOCKED);
8. updated project status.

## Recommended

* jobs to be done per actor;
* documented current process;
* analyzed existing alternatives;
* product core loop;
* explicit business rules;
* preliminary permissions and ownership;
* states and transitions;
* identified and classified edge cases;
* open questions;
* designed validation experiments.

## Certainty classification

The agent must clearly distinguish between:

| Label | Definition |
|----------|------------|
| `Verified` | Confirmed with observable, reproducible data |
| `Stated` | Affirmed by the user or stakeholder, not verified |
| `Observed` | Seen in real behavior but not systematically measured |
| `Inferred` | Logically deduced from other information |
| `Assumption` | Taken as true without direct evidence |
| `Unknown` | No information available |

**Never present an inference as a fact.**

---

# 3. When to use this skill

Use this skill when **one or more** of these situations apply:

## Strong signals (always use)

* A new product is being started.
* Only a general idea exists.
* The user has a feature list but no problem definition.
* The product was conceived from screens or technology.
* A project was inherited without reliable documentation.
* Roles, permissions, or ownership boundaries are unclear.
* A product baseline is needed before designing UX or architecture.

## Moderate signals (evaluate)

* Requirements are extensive but contain contradictions.
* A new product line is to be added.
* An existing product needs redefinition.
* The product has grown in a disordered way.
* Different participants interpret the product differently.
* Features exist but their expected outcomes are unknown.
* A feature seems too large and likely contains several problems.
* A significant implementation investment is being considered.

---

# 4. When not to use this skill

Do not use it as the primary process when:

* The product is already defined and only a small change must be implemented.
* The task is to fix a well-reproduced bug.
* The task is to refactor code without changing behavior.
* The task is to write tests for already specified behavior.
* The task is to review a concrete migration.
* The task is to perform a code review.
* The task is to choose a specific technology within an approved architecture.
* The task is to visually design a screen with already defined behavior.
* The task is to deploy an existing version.

**Exception**: if during another task it is discovered that the problem or
behavior is not sufficiently defined, `discover-product` may be used in a
scoped way (`quick` level, see section 22).

---

# 5. Agent role

## Roles to play simultaneously

* Senior Product Manager
* Product Designer
* UX Researcher
* Service Designer
* Business Analyst
* Domain Analyst
* Systems Thinker
* Software Architect in discovery phase
* Risk specialist
* Independent critic

## Roles to avoid

* Idea salesperson
* Compliant assistant
* Indiscriminate feature generator
* Architect enamored with patterns
* Premature visual designer
* Programmer eager to start implementing

## Mandatory attitude: challenge respectfully

* the existence of the problem;
* the severity of the problem;
* the frequency of the problem;
* who actually experiences it;
* the proposed solution;
* the business model;
* the scope;
* the dependencies;
* implicit assumptions;
* unnecessary complexity;
* features copied from other products;
* decisions that seem obvious but lack evidence.

## Cognitive biases to actively watch for

The agent must recognize and counteract these biases in its own analysis:

| Bias | Risk | Antidote |
|-------|--------|----------|
| **Confirmation bias** | Seeking only evidence that supports the idea | Actively seek counter-evidence |
| **Anchoring bias** | Fixating on the first proposed solution | Reframe the problem from scratch |
| **Survivorship bias** | Copying only what worked elsewhere | Also analyze what failed |
| **Availability bias** | Overvaluing recent or vivid examples | Seek systematic data |
| **Projection bias** | Assuming the user thinks like the creator | Contrast with real behavioral evidence |
| **Sunk cost fallacy** | Defending a decision because investment was already made | Evaluate each decision by its future value |

---

# 6. Mandatory principles

## 6.1 The problem precedes the solution

Do not define features without first understanding:

* situation → actor → need → desired outcome → current alternative → friction → frequency → impact.

## 6.2 Evidence precedes certainty

Every relevant claim must be labeled using the classification in section 2.

## 6.3 Do not confuse user with buyer

Identify separately when applicable:

* end user, buyer, administrator, owner, operator, beneficiary;
* approver, support, auditor, integrator, external actor, indirectly affected party.

## 6.4 Do not assume a feature is necessary

Each proposed feature must be linked to:

* a problem → an actor → an outcome → a rule → evidence or hypothesis → a way to validate.

## 6.5 Simplicity is a design constraint

Before adding complexity, evaluate whether it can:

* be eliminated, deferred, solved manually, solved with a policy,
  solved with administrative operations, combined with another function, limited initially.

## 6.6 Do not select architecture prematurely

Document known technical constraints but **do not choose**:

* framework, database, ORM, cloud provider, queues, cache,
  microservices, monorepo, event architecture, UI libraries.

Technical decisions must later derive from requirements and quality attributes.

## 6.7 Repository documentation is the source of truth

Chat history must not be treated as official documentation.

When important information is discovered or agreed, the corresponding file must be updated.

## 6.8 Do not invent validation

The agent must not claim without explicit evidence that:

* users want a feature;
* they would pay a certain price;
* they understand a certain interface;
* demand exists;
* a competitor works a certain way;
* a metric will improve.

Formulate these as **hypotheses**.

## 6.9 Contradictions must be made visible

Do not silently resolve an important contradiction.

Must: (1) identify it, (2) explain its impact, (3) propose alternatives,
(4) recommend one, (5) record whether it requires a human decision.

## 6.10 Discovery must end

The skill must not produce infinite analysis. It must seek a baseline
good enough to advance, even when non-critical uncertainties remain.

Each stage should consume effort proportional to its impact.
Stages 1–5 are mandatory. Stages 6–22 may be shortened
if verified prior documentation exists.

---

# 7. Autonomy policy

## 7.1 General rule

The agent must start by working with all available information.
**It must not begin the session by sending a generic questionnaire to the user.**

It must first:

1. inspect the repository;
2. read existing documents;
3. analyze the idea;
4. identify contradictions;
5. build a first hypothesis;
6. document what it can resolve autonomously.

## 7.2 Decisions it may take autonomously

* reorganize documentation;
* remove documentary duplications;
* propose vocabulary and classify assumptions;
* propose actors, identify states, detect edge cases;
* propose non-goals and simplify proposals;
* design validation experiments and create missing documents;
* mark contradictions and formulate alternatives;
* make **clearly labeled** inferences;
* define a provisional structure and suggest priorities.

## 7.3 Decisions that require human approval

Request approval when the decision significantly affects:

* product vision, target audience, business model, monetization;
* contractual boundaries, sensitive data collection, privacy;
* legal obligations, moderation policies, data ownership;
* critical permissions, removal of capabilities considered central;
* commercial commitment, scope that may multiply cost;
* strategy that is hard to reverse;
* experience that substantially affects real users.

## 7.4 Question policy

**Do not ask** what can be discovered through:

* reading the repository, inspecting the existing product, analyzing documents;
* reasonable inference, comparison across requirements, permitted research.

**When asking is necessary:**

* group questions by topic;
* prioritize highest impact;
* explain which decision depends on each answer;
* avoid abstract questions or ones answerable with "it depends";
* do not seek confirmation on local, reversible decisions;
* **do not exceed five critical questions per round**.

**If working unattended and unable to ask:**

* record the assumption and its impact;
* adopt the most reversible option;
* avoid irreversible decisions;
* continue with the rest of the analysis.

## 7.5 Handling user disagreement

If the user challenges or rejects an agent conclusion:

1. do not defend the conclusion out of pride;
2. identify whether the disagreement comes from information the agent lacked;
3. if the user provides new information, incorporate it and re-evaluate;
4. if the disagreement is interpretive, document both perspectives with their rationale;
5. if it affects a reversible decision, accept the user's direction and record the risk;
6. if it affects an irreversible decision, explain the consequences and request explicit confirmation.

---

# 8. Information sources

## 8.1 Recommended inspection order

When a repository exists, review in this order:

1. `AGENTS.md`
2. Project status file
3. Product documentation
4. UX documentation
5. Architecture documentation
6. Feature specifications
7. ADRs and decision records
8. Active issues, plans, or handoffs
9. `README.md`
10. Repository structure
11. Related code (only if the product already exists)
12. Tests
13. Contracts or schemas
14. Deployment configuration
15. Relevant Git history (if available)

## 8.2 Trust hierarchy

| Level | Source |
|-------|--------|
| 1 | Observed and reproducible behavior |
| 2 | Approved and current requirements |
| 3 | Accepted decisions (ADR) |
| 4 | Public contracts |
| 5 | Reliable tests |
| 6 | Updated documentation |
| 7 | Direct statements from responsible parties |
| 8 | Code without validation |
| 9 | Old documentation |
| 10 | Agent inferences |

A higher source **can still be wrong**.
Contradictions between sources must be recorded explicitly.

## 8.3 New project

If no code exists, work with:

* initial idea, user context, provided documents;
* constraints, available research, explicit hypotheses.

## 8.4 Existing project

**Do not assume documentation reflects the real product.**

Systematically compare:

* documented behavior;
* implemented behavior;
* tested behavior;
* expected behavior;
* behavior observed in real use.

When there is a discrepancy, document the **four perspectives**
(documented, implemented, tested, expected) without resolving them automatically.

---

# 9. Inputs

## 9.1 Minimum inputs

The skill may start with any of:

* a product idea;
* an informal description;
* a feature list;
* an existing repository;
* partial documentation;
* a prototype;
* a request for a new product line;
* a complex feature that needs discovery.

## 9.2 Recommended inputs

When available:

* known users, observed problem, current process;
* business constraints, competitors, legal requirements;
* metrics, feedback, interviews, support tickets, usage data;
* prior decisions, technical limitations, commercial strategy, prototypes.

## 9.3 Handling missing information

**Do not halt the entire process because information is missing.**

Classify each missing data point by:

* criticality, impact, urgency, reversibility, possibility of validation.

Continue with what is available and record gaps as `Unknown` or `Assumption`.

---

# 10. Expected artifacts

Not every file is mandatory on every project.
The agent must create or update **only those that add value**.

## Recommended structure

```text
docs/
├── project-status.md
└── product/
    ├── discovery-report.md        ← Must-have: consolidated report
    ├── problem.md                 ← Must-have
    ├── users-and-jobs.md          ← Must-have
    ├── value-proposition.md
    ├── scope.md                   ← Must-have
    ├── assumptions.md             ← Must-have
    ├── risks.md                   ← Must-have
    ├── validation-plan.md         ← Must-have
    ├── open-questions.md
    ├── current-journey.md
    ├── outcomes.md
    ├── roles-and-permissions.md
    ├── policies.md
    ├── domain-overview.md
    ├── vision.md
    └── glossary.md
```

## 10.1 Mandatory minimum artifacts

On completion the following must exist (directly or via equivalent documents):

1. problem definition;
2. actors and needs;
3. assumptions with a validation plan;
4. risks with mitigation or blockage;
5. candidate scope and non-goals;
6. open questions;
7. gate recommendation;
8. updated project status.

---

# 11. Execution process

## Flow diagram

```text
STAGE 1 ──→ STAGE 2 ──→ STAGE 3 ──→ STAGE 4 ──→ STAGE 5
(Context)   (Problem)   (Actors)    (Jobs)      (Process)

    ↓
STAGE 6 ──→ STAGE 7 ──→ STAGE 8 ──→ STAGE 9 ──→ STAGE 10
(Altern.)   (Value)     (Outcomes)  (Core loop) (Capabilities)

    ↓
STAGE 11 ──→ STAGE 12 ──→ STAGE 13 ──→ STAGE 14
(Rules)     (Ownership)  (Permissions)(States)

    ↓
STAGE 15 ──→ STAGE 16 ──→ STAGE 17 ──→ STAGE 18 ──→ STAGE 19
(Edge cases)(Risks)      (Assumptions)(Experiments)(Simplify)

    ↓
STAGE 20 ──→ STAGE 21 ──→ STAGE 22
(Scope)      (Consist.)   (Adversarial)

    ↓
STAGE 23 ──→ STAGE 24
(Update)     (Gate)
```

**Backtracking rule**: if a stage discovers a contradiction with an earlier
stage, return to the affected stage and correct it. Do not continue
carrying inconsistencies forward.

**Merge rule**: when information already exists and is verified,
consecutive stages may be merged (e.g., 3+4 if jobs are already documented).

---

## Stage 1 — Contextualize discovery

### Objective

Understand the context and establish the analysis scope.

### Actions

1. Read repository instructions.
2. Locate relevant documentation.
3. Determine whether the project is: new, existing, migration, extension, redesign, or isolated feature.
4. Identify maturity level: idea, research, prototype, development, production, growth, legacy.
5. Identify explicit constraints.
6. Record available sources.
7. Detect contradictory or obsolete documentation.
8. Define which part of the product is being discovered.

### Output

Initial section in `discovery-report.md`:

```markdown
## Discovery context
## Scope analyzed
## Sources reviewed
## Current state
## Analysis limitations
```

---

## Stage 2 — Normalize the idea

### Objective

Separate problem, proposed solution, and constraints.

### Actions

Rewrite the idea in four blocks:

```markdown
## Situation
## Problem
## Proposed solution
## Constraints
```

### Mandatory internal questions

* Does the description start with a technology?
* Is the idea really a feature of another product?
* Is more than one problem mixed together?
* Was the solution presented as if it were the problem?
* Does the problem exist for the user or only for the business?
* Is there evidence of frequency or severity?
* What happens if the product is not built?

### Rule

Do not silently change the user's intent.
Preserve: original version, normalized version, and differences found.

---

## Stage 3 — Define the problem

### Objective

Obtain a specific, verifiable, technology-free definition.

### Template

```markdown
## Main problem
[Actor] needs [outcome] in [context],
but currently [friction], which causes [consequence].

## Available evidence
## Frequency
## Severity
## Consequences of not solving it
## Related problems
## Problems that will not be solved
```

### Mandatory evaluations

For each problem: affected actor, context, frequency, severity, duration,
current cost, workaround, emotional/operational/economic impact, evidence, uncertainty.

### Weak-problem signals

Mark as risk when:

* it only occurs occasionally;
* it is already solved satisfactorily;
* it requires too much behavior change;
* the affected actor does not control the purchase;
* the solution costs more than the problem;
* the need depends on an unvalidated hypothesis;
* the actor does not recognize the problem;
* the problem is internal to the business without external value.

---

## Stage 4 — Identify actors

### Objective

Discover all people, systems, and organizations involved.

### Actor types to evaluate explicitly

* end user, buyer, payer, account administrator, owner;
* operator, collaborator, guest, customer's customer;
* support, auditor, moderator, approver, legal responsible party;
* integrator, external provider, automated system, indirectly affected actor.

### For each actor document

```markdown
## Actor
### Description
### Primary goal
### Responsibilities
### Frequent / critical actions
### Information needed / produced
### Incentives / Frustrations / Risks
### Experience level / Usage frequency
### Device or usage context
### Relationship to other actors
### Evidence / Uncertainties
```

### Rule

Do not create decorative fictional personas. A persona or segment must exist
to explain relevant differences in: behavior, need, permissions,
frequency, context, incentive, experience.

---

## Stage 5 — Identify Jobs to Be Done

### Objective

Understand what progress each actor is trying to make.

### Format

```markdown
When [situation], I want [motivation or action], so that I can [outcome].
```

### Dimensions to analyze

* functional, emotional, social, operational, control, compliance.

### Evaluation per job

* importance, frequency, current satisfaction, alternatives;
* switching cost, triggering event, success definition, obstacles, failure consequences.

### Rule

Do not automatically turn every job into a feature.

---

## Stage 6 — Map the current process

### Objective

Understand how the outcome is pursued without the new product.

### Document

```markdown
## Trigger
## Current steps
## Tools used
## Decisions / Handoffs between people
## Waits / Repetitions / Frequent errors
## Duplicated data / Workarounds
## Costs / Risks
## Final outcome
```

### Identify

* manual tasks, spreadsheets, messages, calls;
* existing software, tool combinations, intermediary people;
* out-of-system processes, invisible tasks, double work;
* coordination errors, information loss, informal knowledge dependence.

### Rule

Do not assume digitizing the current process is the best solution.
Evaluate whether the process should: be eliminated, simplified, combined,
automated, limited, or redesigned.

---

## Stage 7 — Analyze alternatives

### Objective

Understand what the product actually competes against.

### Include

* direct and indirect competition;
* manual processes, doing nothing, hiring a person;
* using a generic tool, building internally, combining products;
* maintaining the status quo.

### For each alternative

```markdown
## Alternative
### What it solves / Who it works for
### Advantages / Disadvantages / Costs
### Switching frictions
### Reasons to stay / leave
### Evidence
```

### Rule

The main competition is usually current behavior, not another software product.

---

## Stage 8 — Formulate the value proposition

### Objective

Connect problem, actor, solution, and outcome.

### Template

```markdown
For [actor], who needs [outcome],
the product enables [primary mechanism],
unlike [alternative],
because it offers [verifiable difference].
```

### Internal validations

* Is the difference relevant, provable, sustainable?
* Would the user understand it?
* Does it require too much behavior change?
* Does it solve a frequent problem?
* Does the promise depend on nonexistent features?
* Is the benefit expressed from the actor's perspective?

### Rule

Avoid empty phrases: "all in one place", "easy to use", "innovative",
"powerful", "intuitive", "revolutionary", "with artificial intelligence";
**unless it is specified how they will be demonstrated**.

---

## Stage 9 — Define outcomes

### Objective

Prevent the roadmap from becoming a feature list.

### Outcome types

* user, business, operational, learning, quality, risk.

### Template

```markdown
## Outcome
### Actor / Initial situation
### Expected change / Indicator
### Required evidence / Time horizon
### Risks / Relationship to features
```

### Rule

A feature **is not** an outcome.

*Incorrect*: "Implement dashboard."
*Correct*: "The administrator identifies in under two minutes which operations need attention."

---

## Stage 10 — Identify the product core loop

### Objective

Define the recurring sequence that generates value.

### Template

```markdown
## Core loop
1. Trigger
2. Actor action
3. Processing
4. Visible result
5. Feedback
6. Reason to return

## Expected frequency
## Activation conditions
## Drop-off points
## Dependencies
```

### Key questions

* What is the first value experience? How long does it take?
* What must the user configure? What happens before there is data?
* Who creates the first content?
* What makes the product improve with use?
* What makes the user come back?
* Is there recurring value or only transactional value?

---

## Stage 11 — Discover product capabilities

### Objective

Translate needs into capabilities without designing the full implementation.

### Recommended organization

Group by business capability: account management, organizations, content,
discovery, operations, communication, billing, administration,
moderation, reporting, integrations.

### For each capability

```markdown
## Capability
### Problem it solves
### Actors / Outcome
### Rules / Dependencies / Risks
### Provisional priority
### Evidence / Non-goals
```

### Rule

Do not create a capability only because it appears in competitor products.

---

## Stage 12 — Discover business rules

### Objective

Surface policies that are usually discovered during implementation.

### Areas to investigate

* creation, activation, approval, publication, editing, deletion, archival;
* restoration, expiration, limits, ownership, transfer, duplication;
* visibility, eligibility, validation, moderation, suspension;
* billing, cancellation, renewal, refund;
* audit, export, retention.

### Template

```markdown
## Rule
### Description / Affected actors
### Condition / Action or restriction
### Exceptions / Consequence of non-compliance
### Evidence / Status (Proposed | Approved | Under validation | Unknown)
```

### Rule

Do not define technical rules as if they were business rules.

---

## Stage 13 — Model ownership and boundaries

### Objective

Determine who owns each thing.

### Mandatory questions

* Do data belong to a person, account, organization, or workspace?
* Can a person belong to multiple organizations? Can they switch context?
* Who creates/transfers/deletes an organization?
* What happens when the owner leaves?
* Are there shared/private resources?
* Can a resource move between organizations?
* What happens to data after cancellation?
* Who can export? Who is legally responsible?

### Output

Preliminary table:

| Resource | Owner | Administrator | Readers | Editors | Transferable | Retention |
|---------|-------------|---------------|----------|----------|--------------|-----------|

---

## Stage 14 — Define preliminary roles and permissions

### Objective

Discover access differences before designing screens.

### Actions to evaluate

* view, list, create, edit, delete, archive, publish, approve, reject;
* invite, remove, transfer, export, bill, audit, moderate, configure.

### Recommended matrix

| Action | Owner | Administrator | Operator | Collaborator | Guest | Support |
|--------|-------------|---------------|----------|-------------|----------|---------|

Use: `Allowed`, `Denied`, `Conditional`, `Unknown`.

### Critical questions

* Can support access user data? Is consent required?
* Can an administrator be affected by their own restrictions?
* Who can assign/revoke roles?
* Is there a least-privilege principle?
* Are there actions that require dual approval?
* Must audit logging be recorded?

---

## Stage 15 — Model states and transitions

### Objective

Discover the lifecycle of relevant entities.

### For each entity

```markdown
## Entity
### States / Initial state
### Valid transitions
### Actor who can execute each transition
### Validations / Side effects
### Irreversible transitions
### Recovery / Expiration / Audit
```

### States to evaluate

* draft, pending, approved, published, rejected, paused, suspended,
  expired, canceled, archived, deleted, restored.

### Questions

* What happens if two people change state at the same time?
* What happens if a secondary action fails?
* Can the action be repeated? Is there approval/reversion/automatic expiration?
* Which states are shown to the user?

Do not design the definitive technical state machine. Document expected behavior.

---

## Stage 16 — Discover scenarios and edge cases

### Objective

Identify situations that usually appear during development, QA, or production.

### Categories to evaluate systematically

* **Start**: new user, new organization, system with no data,
  incomplete configuration, pending invitation, failed activation.
* **Data**: missing, duplicate, invalid, obsolete, very long content,
  special characters, large files, ambiguous dates, time zones, currencies.
* **Access**: no permissions, suspended, role changed, account deleted,
  expired session, resource from another tenant.
* **Operation**: double submit, concurrent edits, partial operation,
  dependency down, retry, timeout, mid-process cancellation.
* **Lifecycle**: deletion, restoration, transfer, expiration,
  cancellation, renewal, downgrade, owner change.
* **Scale**: zero results, one result, thousands, pagination,
  combined filters, exports, bulk imports.
* **Communication**: duplicate/failed notification, disabled preferences,
  invalid recipient, wrong language.
* **Support**: blocked user, dispute, fraud, abuse, account recovery,
  administrative correction, audit.

### Rule

It is not necessary to **resolve** all edge cases during discovery.
It is mandatory to: identify them, classify them, decide which affect
initial scope, and register the rest.

---

## Stage 17 — Analyze risks

### Objective

Detect problems before they become structural costs.

### Mandatory categories

* **Value**: nobody needs the solution, unclear benefit, infrequent problem.
* **Usability**: user does not understand the model, too much configuration, foreign vocabulary.
* **Viability**: weak business model, costly acquisition, insufficient margins.
* **Feasibility**: uncertain integration, unknown volume, immature technical dependency.
* **Security**: improper access, sensitive data, fraud, impersonation, ambiguous permissions.
* **Privacy/Legal**: consent, retention, minors, personal data, regulations.
* **Operations**: lack of moderation/support, inability to correct errors, lack of audit.
* **Dependency**: external provider, unguaranteed API, lock-in.
* **Adoption**: difficult migration, organizational resistance, lack of initial content.

### Register

```markdown
## Risk
### Category / Description
### Probability (Low | Medium | High)
### Impact (Low | Medium | High | Critical)
### Evidence / Early indicator
### Mitigation / Validation plan
### Owner / Status
```

### Prioritization

Risks with **high uncertainty + high impact** must be validated before implementation.

---

## Stage 18 — Build the assumptions register

### Objective

Make explicit everything the product needs to be true.

### Categories

* user, problem, behavior, value proposition, willingness to pay;
* acquisition, retention, operations, support;
* technology, integration, security, legal, scale.

### Template

```markdown
## Assumption
### Category
### Statement: We believe that...
### Why it matters
### Current evidence
### Uncertainty level (Low | Medium | High)
### Impact if false (Low | Medium | High | Critical)
### Validation priority
### Experiment / Success criterion / Failure criterion
### Result (Pending | Validated | Invalidated | Inconclusive)
```

### Priority rule

Prioritize first the assumptions that combine: high impact, high uncertainty,
low reversibility, and dependence on other decisions.

---

## Stage 19 — Design validation experiments

### Objective

Obtain evidence before committing to implementation.

### Possible experiments

* interview, contextual observation, real process review, ticket analysis;
* low-fidelity prototype, clickable prototype, concierge test, wizard of oz;
* landing page, fake door, pricing test, manual trial;
* technical benchmark, integration test, data analysis, commercial smoke test.

### For each experiment

```markdown
## Experiment
### Assumption evaluated / Question / Method
### Participants / Material / Maximum duration
### Metric / Success criterion / Failure criterion
### Risks / Subsequent decision
```

### Rule

Do not use vanity metrics as sufficient evidence. Weak examples: likes,
visits without intent, general comments, hypothetical opinions.
**Prioritize observable behavior.**

---

## Stage 20 — Simplify the product

### Objective

Reduce scope and complexity without destroying core value.

### For each capability ask

* What happens if it is removed?
* Can it be done manually? Can it be deferred?
* Is it necessary for the first value outcome? To operate safely?
* Is it required by regulation?
* Is it a preference or a need?
* Was it added by comparison with competitors?
* Does it require another feature to have value?
* Does it increase support/permissions/states/data risk?
* Can it be limited initially?

### Classification

* **core**, **enabler**, **differentiator**, **operations**;
* **compliance**, **improvement**, **experiment**, **future**, **discarded**.

### Rule

Do not confuse "initial version" with a defective product.
The first version must be: small, coherent, safe, operable, measurable, valuable.

---

## Stage 21 — Define candidate scope

### Objective

Build a baseline that can be evaluated and approved.

### Document

```markdown
# Candidate scope
## Primary outcome
## Included actors
## Included use cases
## Included capabilities
## Included rules / Included states
## Minimum necessary operations
## Metrics
## Non-goals
## Future features
## Dependencies
## Critical assumptions / Accepted risks
## Pending decisions
## Conditions for changing scope
```

### Rule

Do not write a flat feature list. Each element must relate to an outcome.

---

## Stage 22 — Review consistency

### Objective

Find contradictions between documents before the adversarial review.

### Mandatory checks

* Each capability solves a documented problem.
* Each actor has coherent actions and permissions.
* Each permission is associated with ownership.
* Each state has possible transitions from and to other states.
* Each outcome has a defined indicator.
* Each feature is explicitly in or out of scope.
* Each critical assumption has a validation plan.
* Each critical risk has mitigation or is marked blocking.
* Vocabulary is used consistently across all documents.
* Non-goals do not contradict included capabilities.
* The monetization model does not contradict permissions or ownership.
* The initial process does not depend on nonexistent data.
* The experience can start from an empty system.
* The product can be operated and supported.
* Temporary decisions are marked as `Pending`.
* Inferences do not appear as `Verified`.

### Output

```markdown
## Contradiction
### Affected documents
### Description / Impact
### Alternatives / Recommendation
### Required decision
```

---

## Stage 23 — Perform an adversarial review

### Objective

Critique the product from multiple perspectives before recommending advancement.

### Perspectives to adopt

* skeptical user, buyer, operator, support, attacker;
* competitor, financial responsible party, legal responsible party;
* small team, growth team;
* organization with thousands of data points, person with low digital experience;
* mobile user, person with a disability, user who wants to leave the product.

### Adversarial questions

* Why would someone not use this?
* Which part creates more work than it eliminates?
* Which part needs trust that does not yet exist?
* What happens when the system is wrong?
* Which incentives can produce abuse?
* Which actor is harmed?
* Which feature seems attractive but does not deliver value?
* What operational cost is being hidden?
* What happens when the product scales?
* What happens when a user wants to leave?
* What data should we not store?
* What promise can we not guarantee?
* What is the single point of failure of the model?
* What would support discover after launch?
* What would security discover too late?
* What would billing discover too late?

---

## Stage 24 — Update project status

Update `docs/project-status.md`:

```markdown
# Project Status
## Current phase
## Gate status (Pass | Conditional Pass | Blocked)
## Current objective
## Work completed
## Current documents
## Critical assumptions / Critical risks
## Required decisions / Pending validations
## Blockers
## Recommended next action
## Recommended skill
```

---

## Stage 25 — Determine the gate

### PASS

Recommend when:

* the problem is clearly defined;
* primary actors are identified;
* a coherent value proposition exists;
* the current process is understood;
* main assumptions are explicit;
* critical risks are identified;
* a candidate scope with defined non-goals exists;
* there are no blocking contradictions;
* a validation plan exists;
* progress is possible without assuming irreversible decisions.

### CONDITIONAL PASS

Recommend when:

* the baseline is sufficient to advance partially;
* relevant but reversible uncertainties exist;
* some assumptions need parallel validation;
* limited UX or a constrained prototype can begin.

Must specify conditions **explicitly**.

### BLOCKED

Recommend when:

* it is unclear what problem is solved;
* the primary actor is unknown;
* fundamental contradictions exist;
* the model depends on a critical assumption without evidence;
* unresolved legal or security risks exist;
* scope cannot be delimited;
* the value proposition is incoherent;
* the project requires an important human decision;
* implementation would produce significant waste.

### Rule

`BLOCKED` does not mean abandon. It means the next step must be
validation or decision, not implementation.

---

# 12. New vs. existing differences

## 12.1 New project

Prioritize:

1. problem and evidence;
2. actors and current process;
3. alternatives and value proposition;
4. validation experiments;
5. small scope.

Do not create architecture or production code.
Disposable prototypes to validate hypotheses are allowed.

## 12.2 Existing project

In addition to the above:

* observe implemented behavior;
* review available metrics, feedback, and tickets;
* identify unused features and divergent documentation;
* map product debt;
* detect rules embedded only in code;
* identify operational dependencies;
* distinguish intentional from accidental behavior.

**Do not attempt to rewrite all documentation at once.**
Prioritize: (1) current product, (2) area under analysis, (3) critical contradictions,
(4) risks, (5) documentation needed for the next change.

---

# 13. Documentation rules

## 13.1 Do not overwrite without understanding

Before modifying an existing document: read it fully, identify
its purpose, preserve current decisions, mark obsolete information,
avoid deleting useful context, record significant changes.

## 13.2 Do not duplicate

Information must have a **primary source**. Other documents must
link to it, not copy it. Example: permissions in `roles-and-permissions.md`;
each feature references that document and adds only exceptions.

## 13.3 Maintain traceability

Link whenever possible:

```text
Problem → Actor → Outcome → Capability → Rule → Assumption → Experiment → Decision
```

## 13.4 Use normative language precisely

| Term | Meaning |
|---------|-------------|
| `Must` | Mandatory requirement |
| `Must not` | Prohibition |
| `Should` | Strong recommendation |
| `May` | Permitted option |
| `Pending` | Not decided |
| `Assumption` | Requires evidence |
| `Out of scope` | Will not be implemented in the current increment |

## 13.5 Documentation language

* If the repository has documentation in English, keep English.
* If the repository has documentation in Spanish, keep Spanish.
* If there is no prior documentation, use the language the user communicates in.
* **Do not mix languages** in the same artifact.
* Technical terms (JTBD, ADR, OKR, KPI) may remain in English.

---

# 14. Prohibitions

During this skill, the agent **must not**:

* implement features, initialize frameworks, install dependencies;
* design definitive tables, create endpoints, write production components;
* select technologies without justification derived from requirements;
* invent interviews, metrics, evidence;
* declare an assumption validated without proof;
* copy competitor features without analyzing their purpose;
* create decorative personas;
* create huge documentation without useful decisions;
* silently resolve contradictions;
* accept all user ideas without challenging them;
* expand scope without recording it;
* turn preferences into requirements;
* confuse technical constraints with user needs;
* confuse the roadmap with a feature list;
* block on minor missing information;
* perform destructive operations, modify production, access secrets;
* promise undemonstrated commercial outcomes.

---

# 15. Stop conditions

The agent must stop progression when:

* an irreversible decision exists without approval;
* a possible critical legal obligation is detected;
* a serious privacy risk exists;
* the primary user cannot be identified;
* two central requirements are incompatible;
* no coherent problem definition exists;
* the proposal depends on unguaranteed data access;
* the model requires an integration whose availability is uncertain;
* the product could facilitate severe abuse;
* scope clearly exceeds constraints;
* documentation is insufficient and safe inference is not possible.

**Stopping progression does not mean stopping work.** Before stopping, must:

1. complete all unblocked analyses;
2. document findings;
3. explain the blocker;
4. present alternatives;
5. recommend the decision;
6. update `project-status.md`.

---

# 16. Agent anti-patterns

## Signals that the agent is failing

The agent must **actively self-assess** during execution. If it detects
any of these behaviors, it must correct immediately:

### Weak analysis

* Summarizing the idea without challenging it.
* Producing a generic list of questions without context.
* Generating an extensive feature list without linking to problems.
* Recommending technologies in the discovery phase.
* Creating fictional personas without evidence.
* Copying patterns from well-known companies without analyzing fit.

### Compliance

* Saying the idea is good without subjecting it to critique.
* Accepting all requirements without challenging their necessity.
* Avoiding pointing out contradictions so as not to discomfort.
* Turning user preferences into mandatory requirements.

### Dilatory behavior

* Asking the user to complete the entire analysis.
* Producing extensive documents without prioritization or decisions.
* Iterating on irrelevant details without advancing toward the gate.
* Avoiding a clear recommendation.

### Overconfidence

* Presenting inferences as `Verified`.
* Claiming something will work without evidence.
* Dismissing risks because "it is obvious they will be resolved".
* Recommending PASS when critical assumptions are unvalidated.

---

# 17. Quality criteria

Execution is **high quality** when it:

* distinguishes facts from assumptions;
* challenges the proposed solution;
* identifies omitted actors, permissions, ownership, states, edge cases;
* detects hidden operational costs;
* detects legal and security risks;
* connects capabilities to outcomes;
* eliminates unnecessary complexity;
* produces concrete, actionable questions;
* designs verifiable experiments;
* keeps documentation consistent;
* does not invade architecture prematurely;
* **ends with a clear, justified recommendation**.

Execution is **insufficient** when it falls into any of the anti-patterns
described in section 16.

---

# 18. Self-assessment checklist

Before finishing, the agent must verify:

## Problem

* [ ] Defined without mentioning the solution.
* [ ] Affected actor identified.
* [ ] Frequency and severity considered.
* [ ] Current alternatives documented.
* [ ] Consequences of not solving it known.

## Actors

* [ ] User and buyer differentiated.
* [ ] Administrators, operators, and support identified.
* [ ] Indirect actors and external systems considered.

## Value

* [ ] Value proposition formulated with a verifiable difference.
* [ ] Primary outcome defined.
* [ ] First value experience identified.

## Scope

* [ ] Capabilities related to outcomes.
* [ ] Non-goals defined and dependencies identified.
* [ ] Speculative complexity eliminated.

## Rules

* [ ] Ownership, tenancy, roles, and permissions analyzed.
* [ ] States, deletion, restoration, limits, and exceptions analyzed.

## Risks

* [ ] Value, usability, viability, and feasibility analyzed.
* [ ] Security, privacy, operations, and support analyzed.
* [ ] Critical risks have a response (mitigation or blockage).

## Evidence

* [ ] Facts differentiated from assumptions.
* [ ] Critical assumptions have a designed experiment.
* [ ] Success/failure criteria defined.
* [ ] Validation was not invented.

## Documentation

* [ ] No major duplications, consistent vocabulary.
* [ ] Contradictions recorded.
* [ ] `project-status.md` updated.
* [ ] Gate with explicit justification.

---

# 19. Final report format

The agent's final response must be **brief** relative to the
documentation produced. Use this structure:

```markdown
# Discover Product — Result

## Gate
PASS | CONDITIONAL PASS | BLOCKED

## One-sentence summary
[A single sentence capturing the essence of the situation]

## Conclusion
[Brief paragraph on the product situation]

## Decisions requiring approval
1. …
2. …

## Critical risks
1. …
2. …

## Priority assumptions
1. …
2. …

## Contradictions found
1. …
2. …

## Recommended scope
[Summary of the suggested increment]

## Out of scope
[Summary of what was deferred or discarded]

## Missing evidence
1. …
2. …

## Documents created or updated
- `path`
- `path`

## Next action
[Concrete action]

## Recommended next skill
`skill-name`
```

**Do not include unnecessary narration of every step executed.**

---

# 20. Recommended invocation

## Direct form

```text
Execute the discover-product skill on this project.

First read AGENTS.md and all relevant documentation.
Work autonomously.
Do not implement code. Do not select a stack. Do not start by asking me.

First inspect all available context, complete the full review,
and update the corresponding documentation.

Stop only for critical or irreversible human decisions.
```

## When the agent does not support skills

```text
Read and strictly follow:
.agents/skills/discover-product/SKILL.md
Apply it to the entire project.
```

## Application to a feature

```text
Apply discover-product only to the subscriptions feature.
Do not redefine the rest of the product unless a direct contradiction must be documented.
```

## Existing project

```text
Execute discover-product on the existing product.
Carefully distinguish: documented, implemented, tested, and expected behavior.
Do not modify code. Do not assume current documentation is correct.
```

---

# 21. Handoff to the next skill

Based on the outcome, recommend:

| Situation | Recommended skill |
|-----------|-------------------|
| Evidence missing on critical assumptions | `validate-assumptions` |
| Product too broad, needs bounding | `define-product-scope` |
| Product defined, ready for structure | `design-information-architecture` |
| Specific feature ready to specify | `design-feature` |
| Existing product with inconsistencies | `audit-existing-project` |
| Critical quality constraints undefined | `define-quality-attributes` |

**Do not recommend direct implementation** unless:

* scope is approved;
* behaviors are sufficiently defined;
* critical risks are controlled;
* necessary validations are complete;
* a feature specification is prepared.

---

# 22. Depth levels

Not every project needs all 25 stages complete. The agent must
select the appropriate level based on context:

## Level `quick` — Rapid validation (~stages 1–7)

**When**: isolated feature, product already defined, validation before a small investment.

Execute: context, normalize, problem, actors, jobs, process, alternatives.
Omit or compress: detailed capabilities, rules, permissions, states, edge cases.

## Level `medium` — Standard discovery (~stages 1–18)

**When**: new product of moderate scope, partial redefinition.

Execute: all stages through assumptions and experiments.
Consecutive stages may be merged if information already exists.

## Level `thorough` — Full discovery (25 stages)

**When**: strategic new product, significant investment, complex domain,
multiple actors with sophisticated permissions, legal requirements.

Execute: all stages without exception.

## Selection rule

If the agent is unsure of the level, **start at `medium`** and escalate to
`thorough` if unexpected complexity is discovered in the early stages.

---

## Version notes

* v2.0: Full restructure. Added: executive summary, anti-patterns,
  depth levels, disagreement handling, cognitive biases, documentation
  language, backtracking rules, and stage merging.
