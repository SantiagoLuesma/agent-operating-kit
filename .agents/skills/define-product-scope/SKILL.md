---
name: define-product-scope
description: >
  Define an explicit, coherent, prioritized, and verifiable product scope
  before designing or implementing. Convert discovery, audit, and assumption
  validation into a concrete decision about what is built, for whom, for what
  outcome, what is out of scope, what ships first, and under which conditions
  scope may expand. Temporarily freeze the next increment (not the entire
  product) to avoid ambiguity, overbuilding, and scope creep. Use when the
  problem and actors are sufficiently discovered, a v1 or increment must be
  bounded, priorities reordered, or requirement contradictions resolved.
  Produces docs/product/scope.md with objective outcome, actors, core loop,
  MUST/SHOULD/COULD/WON'T capabilities, non-goals, increments, metrics,
  change control, and a gate (SCOPE READY / CONDITIONAL READY / REFINEMENT
  REQUIRED / MORE EVIDENCE REQUIRED / BLOCKED). Does not implement code,
  design detailed architecture or UI, invent evidence, or treat every request
  as mandatory.
---

# define-product-scope

## Purpose

Define an explicit, coherent, prioritized, and verifiable product scope before designing or implementing.

This skill converts discovery, audit, and validation outcomes into a concrete decision about:

* what will be built;
* for whom;
* for what outcome;
* what will not be built;
* what will be delivered first;
* which conditions will allow expanding the scope.

It does not attempt to freeze the product permanently. It temporarily freezes the scope of the next increment to avoid ambiguity, overbuilding, and scope creep.

---

## When to use it

Use this skill when:

* there is a sufficiently discovered product idea;
* users, problems, and expected outcomes have been identified;
* assumptions have been validated, refuted, or accepted as risk;
* a first version or next increment must be defined;
* an existing project needs priority reorganization;
* different documents present contradictory requirements;
* the team cannot clearly explain what is in and out of scope.

Do not use it to design detailed interfaces, choose architecture, model definitive tables, or create a technical implementation plan.

---

## Expected inputs

Review, when they exist:

* `AGENTS.md`;
* `docs/project-status.md`;
* discovery documentation;
* assumption register;
* experiment results;
* audit of the existing project;
* requirements provided by stakeholders;
* commercial, legal, technical, or operational constraints;
* metrics or usage evidence;
* relevant prior decisions.

Do not assume that every requested requirement automatically belongs in scope.

---

## Procedure

### 1. Establish the decision context

Identify:

* product or affected area;
* planning horizon;
* increment to be defined;
* people responsible for approving it;
* review date or condition;
* known constraints.

Distinguish between:

* general product scope;
* version scope;
* next-increment scope;
* single-feature scope.

### 2. Consolidate the evidence

Summarize only what is backed by available evidence:

* priority users or actors;
* relevant problems;
* expected outcomes;
* observed behaviors;
* supported assumptions;
* refuted assumptions;
* uncertainties still open;
* accepted risks.

Clearly separate:

* facts;
* indirect evidence;
* decisions;
* hypotheses;
* preferences;
* unvalidated requests.

Do not present opinions as facts.

### 3. Define the objective outcome

Write a concrete outcome that the increment must enable.

It must indicate:

* who receives value;
* what they will be able to achieve;
* what observable change is expected;
* why that outcome is a priority.

Avoid objectives such as:

* “create the module”;
* “implement the platform”;
* “add features”;
* “improve the experience”.

Prefer observable outcomes, for example:

> Enable a merchant to publish and keep their first profile up to date without manual assistance.

### 4. Define priority actors

Classify actors as:

* primary: receive the central value;
* secondary: participate or receive indirect value;
* operators: administer, moderate, or provide support;
* external systems: required integrations.

Indicate which actors will not be served in this increment.

Do not try to satisfy every segment at once.

### 5. Identify the core loop

Describe the minimum sequence of actions that generates repeatable value.

For each step indicate:

* actor;
* action;
* precondition;
* outcome;
* possible failure.

The main scope must protect this loop before adding peripheral capabilities.

### 6. Define in-scope capabilities

Include only capabilities needed to complete the objective outcome.

Each capability must contain:

* name;
* benefiting actor;
* problem it solves;
* expected behavior;
* evidence or reason for inclusion;
* priority;
* dependencies;
* general acceptance criteria.

Classify each capability as:

* `MUST`: necessary for the increment to make sense;
* `SHOULD`: valuable, but can be deferred without invalidating it;
* `COULD`: optional if capacity is available;
* `WON'T NOW`: explicitly excluded.

Do not use `MUST` as a synonym for “important”. An item is `MUST` only when its absence prevents achieving the defined outcome.

### 7. Define functional boundaries

For each included capability, specify:

* start and end of the flow;
* minimum required data;
* authorized roles;
* supported states;
* essential rules;
* errors that must be handled;
* channels or platforms covered;
* expected volume or scale;
* allowed manual behavior.

This must prevent silently broader interpretations.

### 8. Define non-goals

Create an explicit `Non-Goals` section.

Include:

* deferred features;
* uncovered actors;
* automations that will remain manual;
* excluded integrations;
* unsupported edge cases;
* premature optimizations;
* desirable features without sufficient evidence.

Each non-goal must briefly explain why it is out of scope:

* low priority;
* lack of evidence;
* high risk;
* pending dependency;
* disproportionate cost;
* not needed for the current outcome.

### 9. Split into increments

Organize scope as a sequence of vertical increments.

Each increment must:

* produce demonstrable value;
* be integrable;
* be reviewable;
* include the behavior, data, permissions, interface, and verification needed;
* reduce a relevant uncertainty;
* avoid depending on one large final delivery.

For each increment define:

* outcome;
* included capabilities;
* excluded capabilities;
* dependencies;
* risks;
* success signal;
* completion condition.

### 10. Review dependencies and order

Identify dependencies:

* product;
* data;
* technical;
* legal;
* commercial;
* operational;
* third-party;
* knowledge.

Distinguish real dependencies from implementation preferences.

Do not advance complex infrastructure solely because it might be useful later.

### 11. Define constraints

Document confirmed constraints, for example:

* budget;
* external dates;
* regulations;
* privacy;
* accessibility;
* compatibility;
* mandatory vendors;
* existing systems;
* operational capacity;
* support limits.

Do not invent constraints to justify decisions.

### 12. Establish metrics and signals

Define how the increment will be evaluated.

Include:

* expected outcome;
* primary indicator;
* secondary indicators;
* qualitative signals;
* guardrails;
* measurement method;
* evaluation period.

Avoid decorative metrics that do not change decisions.

### 13. Establish change control

Every later change must record:

* description;
* reason;
* new evidence;
* impact;
* cost;
* risk;
* displaced items;
* decision;
* approver.

Do not expand scope silently during design or implementation.

Defects required to meet the agreed behavior are not scope creep. New capabilities are.

### 14. Run adversarial review

Challenge:

* Does the scope solve a real problem, or only reproduce a wish list?
* Is there any `MUST` that is not truly indispensable?
* Does the core loop work end to end?
* Is the scope trying to cover too many users?
* Are there capabilities included only “for the future”?
* Were operations, support, permissions, or error states omitted?
* Can the increment demonstrate value without completing the entire product?
* Are non-goals sufficiently explicit?
* Can success be measured?
* Do critical uncertainties have a treatment?

---

## Deliverables

Create or update `docs/product/scope.md` with:

1. context;
2. evidence used;
3. objective outcome;
4. priority actors;
5. core loop;
6. prioritized capabilities;
7. functional boundaries;
8. non-goals;
9. increments;
10. dependencies;
11. constraints;
12. metrics;
13. risks and unknowns;
14. change policy;
15. final gate.

Update `docs/project-status.md` with status, blockers, and the next recommended skill.

---

## Final gate

Assign one of these outcomes:

### SCOPE READY

The outcome, boundaries, non-goals, and next increment are clear enough to continue.

### CONDITIONAL READY

Work may continue under explicit conditions, accepted risks, or non-blocking pending decisions.

### REFINEMENT REQUIRED

Ambiguities, contradictions, or excess scope must be resolved before design.

### MORE EVIDENCE REQUIRED

A critical scope decision depends on assumptions that are still unvalidated.

### BLOCKED

Authority, information, constraints, or indispensable decisions are missing.

---

## Rules

This skill must not:

* implement code;
* design definitive architecture;
* produce detailed wireframes;
* invent evidence;
* treat every request as mandatory;
* convert future possibilities into current requirements;
* hide contradictions;
* expand scope without recording it;
* declare ready a scope that cannot be verified.

The final report must indicate:

* gate obtained;
* objective outcome;
* recommended increment;
* main exclusions;
* accepted risks;
* blocking questions;
* suggested next skill.
