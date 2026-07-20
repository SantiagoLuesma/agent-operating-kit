---
name: design-feature
description: >
  Designs a feature completely, explicitly, and verifiably before planning
  its implementation. Turns a scoped capability into concrete behavior: actors,
  flows, rules, permissions, states, errors, acceptance criteria, testing, and
  candidate slices. Does not implement code or choose a stack. Use when the
  feature is in approved scope and needs a specification usable by multiple
  agents. Produces docs/features/<feature>/spec.md, test-plan.md, and
  open-questions.md, with gate (READY FOR PLANNING, CONDITIONALLY READY, DESIGN
  REVIEW REQUIRED, REFINEMENT REQUIRED, MORE EVIDENCE REQUIRED, ARCHITECTURE
  INPUT REQUIRED, BLOCKED).
---

# design-feature

## Purpose

Design a feature completely, explicitly, and verifiably before planning its implementation.

This skill turns a capability included in product scope into a functional specification precise enough for different agents to:

* understand the problem;
* evaluate expected behavior;
* detect ambiguities;
* review risks;
* define acceptance criteria;
* later prepare an execution plan;
* split the work into vertical slices.

The specification must describe what should happen, for whom, under which rules, and how it will be verified.

It must not prematurely turn product decisions into irreversible technical decisions.

---

## Compatibility

This skill is agnostic to model, provider, and tool.

It can be used by any coding agent capable of reading and writing repository documentation.

The source of truth is the repository, not chat history or model memory.

---

## When to use it

Use this skill when:

* the feature is part of approved or conditionally approved scope;
* a problem and expected outcome are defined well enough;
* a general capability must be turned into concrete behavior;
* multiple people or agents could interpret the feature differently;
* the feature affects permissions, data, states, integrations, or relevant flows;
* acceptance criteria are needed before creating an `ExecPlan`;
* an existing feature must be redesigned or extended.

Do not use it to:

* discover the full product;
* validate market demand;
* select overall architecture;
* create detailed technical tasks;
* implement code;
* automatically approve a feature that is still ambiguous.

---

## Expected inputs

Review, when they exist:

* `AGENTS.md`;
* `docs/project-status.md`;
* `docs/product/scope.md`;
* discovery documentation;
* validation results;
* information architecture;
* quality attributes;
* related feature documentation;
* recorded decisions;
* existing project audit;
* user evidence;
* legal, operational, or commercial requirements;
* current system behavior.

If the feature changes existing behavior, also inspect:

* current flows;
* public contracts;
* permissions;
* states;
* metrics;
* existing tests;
* known incidents;
* active dependencies.

Do not assume that an isolated request automatically represents correct behavior.

---

## Deliverables

Create or update:

```text
docs/features/<feature-name>/
├── spec.md
├── test-plan.md
└── open-questions.md
```

`spec.md` must contain the stable product and behavior definition.

`test-plan.md` must contain the verification strategy derived from the specification.

`open-questions.md` must contain only doubts, pending decisions, assumptions, and unresolved risks.

If the project uses another documentation structure, respect it without duplicating sources of truth.

Update `docs/project-status.md` when the feature changes gate, introduces blockers, or determines the next recommended skill.

---

## Principles

### Design behavior, not isolated screens

A feature is not only a UI, endpoint, table, or component.

It must be designed as complete behavior that includes, when applicable:

* user intent;
* interaction;
* rules;
* data;
* permissions;
* states;
* errors;
* feedback;
* operations;
* measurement;
* verification.

### Separate facts, decisions, and assumptions

Explicitly classify each relevant statement as:

* evidence;
* confirmed requirement;
* decision;
* assumption;
* constraint;
* preference;
* open question.

Do not hide uncertainty with definitive language.

### Maintain technological neutrality

The specification may describe:

* responsibilities;
* conceptual contracts;
* business events;
* required data;
* expected consistency;
* necessary response times;
* behavior under failure.

It must not prematurely select:

* frameworks;
* libraries;
* databases;
* providers;
* architectural patterns;
* external services;
* definitive internal formats.

Already approved technological constraints may be documented as context, but must not be redesigned within this skill.

### Design the minimum complete behavior

Avoid both:

* vague specifications that force the implementer to invent the product;
* oversized specifications that anticipate unconfirmed needs.

---

## Procedure

## 1. Identify the feature

Define:

* name;
* status;
* product owner;
* scope document that authorizes it;
* increment it belongs to;
* review date or condition;
* related features;
* affected systems or processes.

Assign an initial status:

* `Draft`;
* `In Design`;
* `Ready for Review`;
* `Approved`;
* `Conditionally Approved`;
* `Blocked`;
* `Superseded`.

---

## 2. Define the problem

Explain:

* what problem exists;
* who experiences it;
* in what context;
* how it is currently solved;
* what limitation the current situation has;
* what evidence supports its relevance;
* what happens if it is not solved.

Avoid framing the problem as a solution.

Incorrect:

> The user needs a button to export.

Preferable:

> The operator needs to periodically share information outside the system without manually copying each record.

---

## 3. Define the expected outcome

Describe the observable change the feature must produce.

It must indicate:

* benefited actor;
* capability obtained;
* functional result;
* success signal;
* outcome limits.

Distinguish between:

* output: what the system delivers;
* outcome: what the user achieves;
* impact: later expected change in the product or business.

Do not promise impact that cannot reasonably be attributed or measured.

---

## 4. Identify users and actors

Document all relevant actors:

* primary user;
* secondary users;
* administrators;
* operators;
* support;
* moderators;
* external systems;
* automated processes;
* unauthenticated actors;
* affected third parties.

For each actor indicate:

* goal;
* context;
* knowledge level;
* usage frequency;
* expected permissions;
* risks;
* accessibility needs;
* relationship to the data.

Do not treat “the user” as a single entity when different roles exist.

---

## 5. Define scope

Clearly separate:

### In scope

Behaviors this feature must support.

### Out of scope

Related behaviors that are not part of this delivery.

### Non-goals

Outcomes that are deliberately not pursued.

### Possible future work

Plausible ideas that are not commitments.

### Existing behavior that must not change

Contracts or flows that must be preserved.

Every included item must contribute to the expected outcome or to a necessary constraint.

---

## 6. Define preconditions and postconditions

For each relevant flow indicate:

### Preconditions

* authentication;
* permissions;
* prior data;
* required state;
* configuration;
* available dependencies;
* consent;
* connectivity;
* legal or operational requirements.

### Successful postconditions

* final state;
* data created or modified;
* visible effects;
* side effects;
* notifications;
* traceability;
* recorded metrics.

### Failure postconditions

* what remains unchanged;
* what may be partially processed;
* what must be reverted;
* what can be retried;
* what is reported to the user;
* what must be recorded for support.

---

## 7. Design the flows

Describe the main end-to-end flow.

Each step must indicate:

* actor;
* intent;
* action;
* system response;
* data used;
* decision;
* state transition;
* feedback;
* possible interruption.

Also design:

### Alternative flows

Valid variants of the main behavior.

### Exception flows

Cases where a rule, permission, dependency, or validation prevents continuation.

### Recovery flows

How the user or system can recover from errors, interruptions, or partial states.

### Operational flows

How support, administration, or moderation observe, correct, or intervene.

### Cancellation flows

What happens if the user abandons, cancels, or goes back.

Do not limit the specification to the happy path.

---

## 8. Define business rules

Record each rule with a stable identifier.

Example:

```text
BR-001
```

For each rule indicate:

* description;
* reason;
* affected actors;
* required data;
* evaluation moment;
* exceptions;
* behavior on violation;
* authority that can modify it;
* evidence or decision that supports it.

Distinguish between:

* product rules;
* operational policies;
* legal constraints;
* format validations;
* temporary decisions;
* existing technical limitations.

Do not turn an accidental limitation of the current system into a business rule without justification.

---

## 9. Define roles, permissions, and ownership

Build a matrix that relates:

* actor;
* resource;
* action;
* condition;
* permitted result;
* denied result;
* required traceability.

Cover, when applicable:

* create;
* read;
* list;
* search;
* edit;
* delete;
* restore;
* approve;
* reject;
* publish;
* archive;
* transfer;
* export;
* share;
* administer;
* impersonate;
* perform bulk actions.

Define ownership:

* who owns the resource;
* who can administer it;
* whether it belongs to a person, organization, tenant, store, project, or other entity;
* what happens when the owner changes;
* what happens when a user loses access;
* which permissions are inherited;
* which permissions require explicit assignment.

Apply the principle of least privilege.

A hidden interface does not constitute access control.

---

## 10. Model states and transitions

Identify all entities or processes with a lifecycle.

For each one define:

* possible states;
* initial state;
* terminal states;
* allowed transitions;
* authorized actor;
* condition;
* effects;
* reversibility;
* expiration;
* automatic transition;
* invalid transition;
* concurrency behavior.

Represent the lifecycle with a table or textual diagram.

Conceptual example:

```text
Draft
  → Pending Review
  → Approved
  → Published
  → Archived
```

Do not use a single generic field when independent dimensions exist, for example:

* editorial status;
* payment status;
* moderation status;
* availability;
* visibility.

Identify impossible or contradictory states.

---

## 11. Define validations

Separate:

### Input validations

Format, length, type, required fields, and structure.

### Business validations

Conditions derived from rules, permissions, states, or limits.

### Contextual validations

Dependencies on other resources, dates, location, availability, or configuration.

### Security validations

Access, integrity, ownership, disallowed content, and data exposure.

### Concurrency validations

Simultaneous changes, duplicates, repeated actions, and stale data.

For each validation indicate:

* moment;
* authority;
* expected message;
* possibility of correction;
* partial persistence;
* conceptual error code or category;
* behavior for integrations.

Do not rely only on UI validation.

---

## 12. Design errors and recovery

Classify errors:

* invalid input;
* insufficient permission;
* nonexistent resource;
* conflict;
* incompatible state;
* dependency unavailable;
* timeout;
* limit exceeded;
* duplicate;
* partial operation;
* unexpected error;
* legal or commercial restriction.

For each category define:

* user message;
* possible action;
* retry possibility;
* data preservation;
* logging;
* support correlation;
* severity;
* need for alerting;
* impact on metrics.

Messages must:

* explain what happened;
* avoid blaming the user;
* indicate how to continue;
* not reveal sensitive information;
* be consistent across channels.

---

## 13. Design interface states and feedback

For each affected surface specify:

### Loading

* what is being waited for;
* whether it blocks the whole interface or a section;
* whether known progress exists;
* whether the action can be cancelled;
* prevention of duplicate actions;
* time after which additional information should be shown.

### Empty

Distinguish between:

* new user;
* search with no results;
* filters with no matches;
* deleted content;
* content not yet available;
* lack of permissions;
* error misinterpreted as empty.

Each empty state must offer a relevant action when one exists.

### Error

Indicate:

* what information is retained;
* whether it can be retried;
* how to return to a safe state;
* when to contact support.

### Unauthorized

Distinguish between:

* not authenticated;
* authenticated without permission;
* expired access;
* resource owned by another party;
* insufficient plan;
* suspended account;
* geographic or legal restriction.

Do not reveal the existence of resources when that creates a security risk.

### Success

Indicate:

* confirmation;
* resulting state;
* next action;
* feedback persistence;
* behavior if the operation continues in the background.

### Partial success

Explicitly design operations where only part can complete.

---

## 14. Identify edge cases

Evaluate, when relevant:

* nonexistent data;
* incomplete data;
* minimum and maximum values;
* deadline dates;
* time zones;
* daylight saving changes;
* localization;
* languages;
* special characters;
* very long content;
* large files;
* slow connections;
* connection loss;
* double submit;
* retries;
* refresh;
* back navigation;
* multiple tabs;
* concurrency;
* simultaneous changes;
* resources deleted during the flow;
* revoked permissions;
* expired sessions;
* suspended accounts;
* degraded dependencies;
* partial imports;
* duplicates;
* historical data;
* orphan relationships;
* recovery after failure;
* abuse;
* fraud;
* spam;
* automations;
* high-volume use;
* inexperienced users;
* users of assistive technologies.

It is not necessary to support every case, but each important exclusion must be explicit.

---

## 15. Accessibility

Define functional accessibility requirements without tying them to a library.

Cover, when applicable:

* keyboard navigation;
* focus order;
* visible focus;
* focus return;
* accessible labels;
* names and roles;
* associated error messages;
* announcements of dynamic changes;
* contrast;
* text magnification;
* reduced motion;
* content not dependent on color alone;
* adequate touch targets;
* captions or alternatives;
* clear language;
* sufficient time;
* prevention of data loss;
* compatibility with assistive technologies.

Identify accessibility criteria that are part of acceptance and testing.

Do not treat accessibility as an optional later improvement.

---

## 16. Responsive and usage contexts

Define how the feature must adapt to:

* small viewport;
* medium viewport;
* large viewport;
* portrait and landscape orientation;
* touch interaction;
* keyboard and mouse;
* low connectivity;
* lower-capability devices;
* variable content;
* zoom;
* high data density.

Describe content and behavior priorities, not premature technical dimensions.

Indicate:

* what content is preserved;
* what is reorganized;
* what may collapse;
* what must never be hidden;
* which actions must remain accessible;
* how context loss is avoided.

---

## 17. Metrics and analytics

Define which questions must be answered after launch.

Examples:

* Do users find the feature?
* Do they start the flow?
* Do they complete it?
* Where do they abandon?
* What errors do they encounter?
* Do they repeat the behavior?
* Does the expected outcome occur?
* Does the feature create adverse effects?

Define:

* primary metric;
* secondary metrics;
* guardrails;
* segments;
* funnel;
* observation period;
* baseline;
* success criterion;
* alert criterion.

For each conceptual analytics event indicate:

* semantic name;
* moment;
* actor;
* minimum properties;
* prohibited data;
* purpose;
* deduplication policy;
* relationship to consent and privacy.

Do not capture sensitive data for convenience.

Distinguish product analytics, technical observability, and audit.

---

## 18. Preliminary data

Define the necessary data concepts without yet designing a definitive schema.

For each conceptual entity indicate:

* purpose;
* owner;
* minimum attributes;
* relationships;
* lifecycle;
* origin;
* authority;
* sensitivity;
* retention;
* mutability;
* auditability;
* integrity rules;
* possibility of deletion;
* need for history.

Classify data, when applicable:

* public;
* internal;
* confidential;
* personal;
* sensitive;
* derived;
* operational;
* ephemeral;
* auditable.

Identify:

* source of truth;
* calculated data;
* duplicated data;
* imported data;
* synchronization;
* conflict resolution;
* expected consistency.

Do not define tables, indexes, or specific types unless they are already an approved constraint.

---

## 19. Preliminary contracts

Describe behavioral contracts between:

* user and system;
* frontend and backend;
* modules;
* services;
* external integrations;
* asynchronous processes;
* operators and system.

Each conceptual contract must include:

* intent;
* input;
* output;
* preconditions;
* errors;
* permissions;
* idempotency;
* ordering;
* consistency;
* expected versioning;
* limits;
* privacy.

Do not necessarily select:

* protocol;
* serialization format;
* transport;
* provider;
* library.

If a public contract already exists, document compatibility and evolution strategy.

---

## 20. Dependencies

Identify dependencies:

* product;
* UX;
* data;
* permissions;
* architecture;
* infrastructure;
* third parties;
* legal;
* commercial;
* operational;
* content;
* support;
* other features;
* migrations.

For each dependency indicate:

* owner;
* status;
* criticality;
* alternative;
* impact if it fails;
* possibility of decoupling;
* pending decision;
* available evidence.

Distinguish between mandatory dependency and convenience.

---

## 21. Risks

Create a risk register specific to the feature.

Possible categories:

* value;
* usability;
* accessibility;
* security;
* privacy;
* fraud;
* abuse;
* data integrity;
* concurrency;
* compliance;
* operations;
* support;
* external dependency;
* performance;
* scalability;
* adoption;
* compatibility;
* migration;
* rollout;
* reversibility.

For each risk indicate:

* description;
* probability;
* impact;
* early signal;
* mitigation;
* contingency;
* owner;
* residual risk;
* need for human approval.

Unresolved critical risks must affect the final gate.

---

## 22. Rollout

Design how to introduce the feature in a controlled way.

Evaluate:

* internal launch;
* preview environment;
* pilot users;
* segments;
* allowlist;
* gradual activation;
* coexistence with previous behavior;
* progressive migration;
* communication;
* support;
* documentation;
* training;
* measurement;
* expansion criteria;
* pause criteria.

Define:

* who can enable it;
* for whom;
* in what order;
* what evidence enables progress;
* what signals require stopping;
* which dependency must be operational;
* how to verify state after deployment.

Do not assume every feature must launch globally in a single operation.

---

## 23. Rollback and reversibility

Define what it means to reverse the feature.

Distinguish between:

* disabling exposure;
* returning to previous behavior;
* stopping processing;
* reverting data;
* compensating effects;
* restoring compatibility;
* communicating incidents.

Document:

* triggers;
* authority;
* target time;
* data that may be lost;
* data that must not be reverted;
* irreversible operations;
* backward compatibility;
* strategy for resources created during rollout;
* post-verification.

If full rollback is not possible, declare it explicitly and design contingencies.

---

## 24. Acceptance criteria

Create observable, verifiable, and unambiguous criteria.

Each criterion must:

* have an identifier;
* reference an actor or system;
* indicate a precondition;
* describe an action;
* define a result;
* include constraints;
* be checkable.

Recommended format:

```text
AC-001

Given:
When:
Then:
And:
```

Cover:

* main flow;
* alternative flows;
* permissions;
* ownership;
* states;
* validations;
* errors;
* loading;
* empty;
* unauthorized;
* accessibility;
* responsive;
* analytics;
* concurrency;
* recovery;
* rollout;
* compatibility.

Avoid criteria such as:

* “works correctly”;
* “is intuitive”;
* “is responsive”;
* “handles errors”;
* “has good performance”.

Convert them into checkable behaviors.

---

## 25. Testing strategy

Derive the testing plan directly from risks, rules, and acceptance criteria.

Define:

### Behavior tests

Verify observable user or system results.

### Rule tests

Cover business rules, limits, and exceptions.

### Permission tests

Cover allowed actions, denied actions, and isolation between owners or tenants.

### State tests

Cover valid, invalid, automatic, and concurrent transitions.

### Validation tests

Cover valid values, invalid values, and boundaries.

### Integration tests

Cover contracts between components or systems.

### End-to-end tests

Cover critical end-to-end journeys.

### Accessibility tests

Cover navigation, focus, semantics, errors, and assistive technologies.

### Responsive tests

Cover content and interaction priorities in relevant contexts.

### Resilience tests

Cover failures, timeouts, retries, partial operations, and recovery.

### Security tests

Cover authorization, data exposure, abuse, and input manipulation.

### Migration or compatibility tests

Cover existing data and previous behavior.

### Observability and analytics tests

Verify events, absence of prohibited data, and operational signals.

For each area indicate:

* risk covered;
* recommended level;
* required data;
* environment;
* success criterion;
* expected evidence.

Do not require a universal testing pyramid. Choose levels according to behavior and risk.

---

## 26. Prepare vertical slice decomposition

Do not create the `ExecPlan` yet, but propose a candidate decomposition.

Each vertical slice must:

* deliver verifiable behavior;
* cross the necessary layers;
* include permissions;
* include minimum data;
* include error handling;
* include tests;
* be integrable;
* reduce risk or uncertainty;
* avoid depending on a massive final delivery.

For each candidate slice indicate:

* outcome;
* actor;
* flow covered;
* rules included;
* minimum data;
* dependencies;
* acceptance criteria;
* required tests;
* risks;
* what is explicitly out.

Order the slices considering:

1. uncertainty;
2. value;
3. risk;
4. dependencies;
5. integration capacity;
6. reversibility.

Do not split exclusively by technical layers such as:

* frontend;
* backend;
* database;
* tests.

---

## 27. Review consistency

Before the final gate check:

* Does the problem match the scope?
* Can the outcome be achieved with what is included?
* Do non-goals prevent broad interpretations?
* Do flows cover happy path and exceptions?
* Is every rule reflected in acceptance criteria?
* Do permissions match ownership?
* Do states allow all valid flows?
* Are validations coherent across channels?
* Do errors allow recovery?
* Are loading, empty, error, and unauthorized differentiated?
* Do critical edge cases have a decision?
* Are accessibility and responsive verifiable?
* Do metrics answer real questions?
* Do data have an owner and lifecycle?
* Can contracts evolve?
* Are blocking dependencies identified?
* Do risks have treatment?
* Does rollout have progress and pause signals?
* Is rollback realistic?
* Can criteria become tests?
* Can the feature be split into vertical slices?

---

## 28. Adversarial review

Try to refute the design.

Ask:

* Does the feature solve the problem or only implement a request?
* Is there a simpler solution?
* Are capabilities introduced without evidence?
* Is it being designed for nonexistent users?
* Were several features mixed under a single name?
* Does the flow depend on undocumented manual work?
* Can an actor obtain or modify data that does not belong to them?
* Is there an impossible state?
* Does a repeated operation produce duplicates?
* What happens if the external dependency fails after a partial effect?
* Can the user lose work?
* Can the feature be abused?
* Does analytics violate privacy?
* Can the system support it operationally?
* Can it be launched gradually?
* Can it be stopped without damaging data?
* Do acceptance criteria allow different interpretations?
* Will the implementer have to invent unspecified behavior?

Record findings and resolve them or convert them into open questions.

---

## Gates

Assign one of the following results.

### READY FOR PLANNING

The feature has:

* clear problem and outcome;
* explicit scope and non-goals;
* complete flows;
* coherent rules;
* defined permissions and ownership;
* valid states and transitions;
* critical errors and edge cases resolved;
* verifiable criteria;
* testing strategy;
* known dependencies;
* viable rollout and rollback;
* candidate vertical slice decomposition.

It may continue to `create-exec-plan`.

### CONDITIONALLY READY FOR PLANNING

The feature can be planned, but there are:

* accepted assumptions;
* minor pending decisions;
* non-blocking dependencies;
* explicit residual risks.

Conditions must be recorded with owner and resolution date or condition.

### DESIGN REVIEW REQUIRED

The specification is complete enough to be reviewed, but still needs independent review via `review-feature`.

This gate is appropriate when the authoring agent must not approve its own design.

### REFINEMENT REQUIRED

There are ambiguities, contradictions, incomplete rules, or insufficient criteria.

Implementation planning must not start.

### MORE EVIDENCE REQUIRED

A central decision depends on product, usability, operational, or viability evidence that is still insufficient.

It must return to validation, discovery, or an experiment.

### ARCHITECTURE INPUT REQUIRED

Behavior is clear, but a decision depends on:

* quality attributes;
* systemic constraint;
* spike;
* shared contract;
* architectural capability not yet defined.

Do not select a technology within this skill to artificially close the blocker.

### BLOCKED

Indispensable decisions, authority, information, access, or dependencies are missing.

### NOT READY FOR IMPLEMENTATION

Partial documentation may exist, but there are no conditions for safe implementation.

This gate may accompany any of the states that require additional work.

---

## Minimum criteria for implementation

A feature is not ready for implementation merely because a general description exists.

At minimum it must have:

* approved scope;
* non-goals;
* actors;
* main flow;
* critical alternative flows;
* rules;
* permissions;
* ownership;
* states;
* validations;
* errors;
* acceptance criteria;
* risks;
* testing strategy;
* dependencies;
* rollout;
* rollback or contingency;
* independent review when applicable;
* approved execution plan.

Implementation must begin after `create-exec-plan`, except for trivial changes expressly permitted by `AGENTS.md`.

---

## Human approvals

Request human approval when the feature includes hard-to-reverse decisions, such as:

* authentication;
* authorization;
* billing;
* pricing;
* monetization;
* data deletion;
* destructive migrations;
* handling of sensitive data;
* legal changes;
* contractual integrations;
* public exposure;
* ownership transfers;
* moderation;
* anti-fraud mechanisms;
* irreversible operations;
* material scope changes.

The agent may analyze and propose, but must not assume authority to approve these decisions.

---

## Prohibitions

This skill must not:

* write code;
* modify production;
* create migrations;
* select technologies without approved need;
* invent evidence;
* silently expand scope;
* turn every wish into a requirement;
* design only the happy path;
* omit permissions;
* confuse a hidden interface with authorization;
* ignore operations or support;
* define invasive analytics;
* declare rollback possible without explaining how;
* use vague acceptance criteria;
* create tasks exclusively by technical layer;
* automatically approve its own design;
* replace stable documentation with a temporary handoff.

---

## Recommended format for `spec.md`

```markdown
# <Feature Name>

## Metadata
## Status
## Source of Scope
## Problem
## Evidence
## Expected Outcome
## Users and Actors
## Scope
## Non-Goals
## Existing Behavior to Preserve
## Preconditions
## Postconditions
## Main Flow
## Alternative Flows
## Exception Flows
## Recovery Flows
## Operational Flows
## Business Rules
## Roles and Permissions
## Ownership
## States
## Transitions
## Validations
## Errors
## Loading States
## Empty States
## Unauthorized States
## Success and Partial Success
## Edge Cases
## Accessibility
## Responsive Behavior
## Metrics
## Analytics Events
## Preliminary Data
## Preliminary Contracts
## Dependencies
## Risks
## Rollout
## Rollback
## Acceptance Criteria
## Candidate Vertical Slices
## Open Questions
## Decisions
## Final Gate
```

---

## Recommended format for `test-plan.md`

```markdown
# Test Plan — <Feature Name>

## Scope
## Risks Covered
## Acceptance Criteria Traceability
## Behavior Tests
## Business Rule Tests
## Permission and Ownership Tests
## State Transition Tests
## Validation Tests
## Integration Tests
## End-to-End Tests
## Accessibility Tests
## Responsive Tests
## Resilience Tests
## Security Tests
## Compatibility and Migration Tests
## Analytics and Observability Tests
## Test Data
## Environments
## Evidence Required
## Known Gaps
## Exit Criteria
```

---

## Final report

On completion, report:

* feature designed;
* gate obtained;
* expected outcome;
* main scope;
* most relevant non-goals;
* number of rules;
* number of acceptance criteria;
* critical risks;
* blocking dependencies;
* open questions;
* human approval required;
* next recommended skill.

The next skill will normally be:

* `review-feature`, for independent review;
* `validate-assumptions`, if evidence is missing;
* `define-quality-attributes`, if a systemic constraint is missing;
* `review-architecture`, if there is relevant architectural impact;
* `create-exec-plan`, if the feature was approved and is ready for planning.
