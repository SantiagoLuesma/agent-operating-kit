---
name: review-feature
description: >
  Adversarially reviews a feature that has already been designed before planning
  or implementation. Looks for contradictions, ambiguities, scope creep,
  incorrect permissions, incomplete flows, non-verifiable criteria, and
  unaddressed risks. Does not implement or silently redesign. Use after
  design-feature or before create-exec-plan. Produces
  docs/features/<feature>/review.md and a gate (APPROVED FOR PLANNING,
  APPROVED WITH CONDITIONS, CHANGES REQUIRED, MORE EVIDENCE REQUIRED,
  SECURITY REVIEW REQUIRED, ARCHITECTURE REVIEW REQUIRED, BLOCKED, REJECTED).
---

# review-feature

## Purpose

Adversarially review a feature that has already been designed before planning or implementing.

This skill evaluates whether the specification is coherent, valuable, complete, secure, verifiable, and sufficiently bounded. Its goal is not to confirm prior work, but to try to find:

* contradictions;
* ambiguities;
* hidden assumptions;
* unaddressed risks;
* incorrect permissions;
* incomplete flows;
* scope creep;
* criteria that cannot be verified;
* missing decisions;
* difficulties implementing the feature as vertical slices.

The review must produce evidence and explicit decisions, not a general opinion.

---

## Compatibility

This skill is agnostic to model, provider, language, and technology stack.

It is client-agnostic and works with any agent capable of inspecting documentation and repositories.

The source of truth is the repository. Chat history may provide context, but must not replace stable documentation.

Ideally, the review should be performed by an agent or session different from the one that designed the feature.

---

## When to use it

Use this skill when:

* a specification created via `design-feature` exists;
* a feature is about to move into planning;
* its scope, behavior, permissions, or data model changes;
* multiple interpretations are possible;
* it affects authentication, billing, sensitive data, ownership, or integrations;
* an existing feature must be extended;
* an independent review is needed before approving it.

Do not use it to:

* implement;
* fix code;
* select technologies;
* replace discovery or validation;
* silently redesign the feature;
* automatically approve the previous design.

---

## Expected inputs

Review, when they exist:

* `AGENTS.md`;
* `docs/project-status.md`;
* `docs/product/scope.md`;
* `docs/features/<feature-name>/spec.md`;
* `docs/features/<feature-name>/test-plan.md`;
* `docs/features/<feature-name>/open-questions.md`;
* assumption validations;
* information architecture;
* quality attributes;
* recorded decisions;
* related features;
* existing contracts;
* current system behavior;
* legal, commercial, and operational requirements.

If a relevant input is missing, record it as a limitation of the review.

---

## Deliverables

Create:

```text
docs/features/<feature-name>/review.md
```

The file must contain:

1. review scope;
2. sources examined;
3. executive summary;
4. findings;
5. contradictions;
6. ambiguities;
7. risks;
8. missing decisions;
9. approval conditions;
10. final gate.

Do not silently modify `spec.md`.

Proposed corrections must be recorded as recommendations. The specification should only be changed when authorization exists to do so.

Update `docs/project-status.md` if the gate changes, blockers appear, or the recommended next action is modified.

---

## Finding classification

Assign to each finding:

### Severity

* `CRITICAL`: may cause serious harm, security violation, data loss, non-compliance, or fundamentally incorrect behavior.
* `HIGH`: prevents planning or implementing reliably.
* `MEDIUM`: creates ambiguity, debt, or material risk, but can be resolved during planning under an explicit condition.
* `LOW`: recommended improvement without significant immediate impact.
* `NOTE`: informational observation.

### Type

* contradiction;
* omission;
* ambiguity;
* scope creep;
* risk;
* missing decision;
* insufficient evidence;
* non-verifiable criterion;
* dependency;
* documentation inconsistency.

### Status

* open;
* accepted as risk;
* resolved;
* deferred;
* not applicable.

Each finding must include:

* identifier;
* location;
* description;
* evidence;
* impact;
* recommendation;
* owner;
* closure condition.

---

## Procedure

## 1. Verify traceability

Confirm that the feature can be linked to:

* an identified problem;
* a concrete user or actor;
* an expected outcome;
* a capability included in scope;
* evidence, decision, or explicit assumption;
* a product increment.

Ask:

* Does the feature solve the stated problem?
* Does the outcome truly depend on this feature?
* Is a requested solution being implemented without understanding the need?
* Is there a simpler solution?
* Does the feature contradict the current scope?

Block when the feature has no verifiable reason to exist.

---

## 2. Review value

Evaluate:

* value for the primary user;
* value for secondary actors;
* expected impact for the product or business;
* frequency and context of use;
* operational cost introduced;
* current alternative behavior;
* available evidence;
* proportionality between complexity and value.

Distinguish:

* demonstrated value;
* inferred value;
* hypothetical value;
* internal convenience;
* stakeholder preference.

A feature must not be approved only because it is technically possible.

---

## 3. Review scope

Check that the following exist:

* in-scope behaviors;
* non-goals;
* covered actors;
* excluded actors;
* future cases not committed;
* existing behavior that must be preserved.

Look for scope creep such as:

* support for non-prioritized segments;
* unnecessary automation;
* “just in case” integrations;
* excessive configuration;
* unjustified administrative capabilities;
* premature optimizations;
* generalizations without evidence.

Ask whether each included element contributes to the expected outcome.

Do not redesign the scope. Record any recommended reduction, expansion, or split for approval.

---

## 4. Review flows

Examine:

* primary flow;
* alternative flows;
* cancellation;
* abandonment;
* recovery;
* partial operations;
* support;
* moderation;
* administration;
* external dependency;
* asynchronous behavior.

For each flow verify:

* preconditions;
* actor;
* action;
* response;
* transition;
* feedback;
* postcondition;
* recovery.

Look for steps where the implementer would still have to invent behavior.

---

## 5. Review actors, ownership, and permissions

Confirm:

* who initiates each action;
* who owns each resource;
* who can view or modify it;
* which organization, tenant, or account it belongs to;
* what happens when ownership changes;
* what happens when access is revoked;
* how inherited permissions are applied;
* which actions require special privileges.

Review operations for:

* create;
* read;
* list;
* edit;
* delete;
* publish;
* approve;
* transfer;
* export;
* restore;
* bulk administration.

Look for:

* cross-tenant access;
* privilege escalation;
* implicit permissions;
* visual-only controls;
* ambiguous owners;
* overly powerful administrators;
* orphaned resources.

---

## 6. Review rules, states, and transitions

For each business rule check:

* clarity;
* rationale;
* authority;
* exceptions;
* evaluation timing;
* relationship to acceptance criteria;
* consistency with other rules.

For each lifecycle verify:

* initial state;
* terminal states;
* valid transitions;
* invalid transitions;
* authorized actor;
* side effects;
* reversibility;
* concurrency;
* expiration;
* automations.

Look for:

* impossible states;
* mixed dimensions;
* transitions without an owner;
* actions that are improperly repeatable;
* contradictory rules;
* circular dependencies.

---

## 7. Review validations, errors, and edge cases

Check validations for:

* format;
* business;
* permissions;
* context;
* security;
* concurrency;
* limits.

Review errors for:

* invalid input;
* missing resource;
* access denied;
* conflict;
* dependency down;
* timeout;
* duplicate;
* incompatible state;
* partial operation;
* limit exceeded.

Verify that each error defines:

* message;
* recovery;
* retry;
* data preservation;
* logging;
* impact on state.

Evaluate relevant edge cases:

* double submit;
* multiple tabs;
* interrupted connection;
* expired session;
* concurrent changes;
* historical data;
* time zones;
* large files;
* deleted resources;
* retries;
* partial failures;
* extreme content;
* revoked permissions.

Do not require support for all of them, but do require explicit decisions on the critical ones.

---

## 8. Review security, privacy, and abuse

Evaluate:

* authentication;
* authorization;
* isolation;
* data exposure;
* sensitive data;
* retention;
* deletion;
* consent;
* audit;
* impersonation;
* exports;
* user-generated content;
* fraud;
* spam;
* abusive automation;
* resource enumeration;
* input manipulation.

Ask:

* Can a user access someone else’s data?
* Can they infer that a private resource exists?
* Can they repeat an action to gain benefit?
* Can they evade limits?
* Is unnecessary data being collected?
* Do logs or analytics expose sensitive information?
* Is there a moderation or response path?

Critical risks require specialized review via `review-security`.

---

## 9. Review UX, accessibility, and responsive design

Check that the following are defined:

* loading;
* empty;
* error;
* unauthorized;
* success;
* partial success;
* disabled;
* processing;
* offline, when applicable.

Correctly distinguish:

* unauthenticated;
* no permission;
* no content;
* no results;
* error;
* insufficient plan.

Review accessibility:

* keyboard;
* focus;
* semantics;
* messages;
* contrast;
* assistive technologies;
* reduced motion;
* data preservation;
* touch targets.

Review responsive design:

* content priorities;
* available actions;
* reorganization;
* zoom;
* touch interaction;
* small screens;
* long content;
* limited connectivity.

Flag vague requirements such as “responsive” or “accessible” when they are not verifiable.

---

## 10. Review data and contracts

Evaluate data concepts:

* owner;
* source of truth;
* minimum attributes;
* sensitivity;
* relationships;
* lifecycle;
* history;
* retention;
* deletion;
* integrity;
* synchronization.

Review preliminary contracts:

* inputs;
* outputs;
* errors;
* permissions;
* idempotency;
* consistency;
* versioning;
* compatibility;
* limits;
* privacy.

Look for:

* duplication without clear authority;
* data without an owner;
* ambiguous contracts;
* incompatibility with existing consumers;
* non-idempotent operations;
* undefined synchronization;
* impossible deletion;
* hidden side effects.

Do not define definitive tables, APIs, or technologies during this review.

---

## 11. Review integrations and dependencies

For each dependency check:

* necessity;
* owner;
* status;
* criticality;
* availability;
* limits;
* failures;
* alternative;
* decoupling;
* operational impact;
* contractual risk.

Evaluate what happens when:

* the integration is down;
* it responds late;
* it returns inconsistent data;
* it processes twice;
* it processes partially;
* it changes its contract;
* it revokes access.

Unconfirmed dependencies must be recorded as risk or blocker.

---

## 12. Review metrics, operations, and support

Check that metrics can answer:

* adoption;
* start;
* completion;
* abandonment;
* errors;
* repetition;
* outcome;
* adverse effects.

Verify:

* primary metric;
* guardrails;
* baseline;
* segments;
* success criterion;
* alert criterion;
* privacy.

Evaluate operations:

* observability;
* audit;
* support;
* moderation;
* manual corrections;
* documentation;
* training;
* incident escalation.

Ask who will detect and resolve problems after launch.

---

## 13. Review rollout and rollback

Check that rollout defines:

* initial users;
* activation order;
* controls;
* go signals;
* pause signals;
* communication;
* support;
* post-verification.

Check that rollback indicates:

* triggers;
* authority;
* target time;
* deactivation;
* compatibility;
* handling of created data;
* irreversible effects;
* post-verification.

Do not accept “revert the deploy” as a sufficient strategy when data, contracts, or external effects exist.

---

## 14. Review acceptance and testing

Each acceptance criterion must be:

* observable;
* unambiguous;
* traceable;
* verifiable;
* consistent with rules and flows.

Confirm coverage of:

* happy path;
* alternatives;
* permissions;
* states;
* errors;
* critical edge cases;
* accessibility;
* responsive design;
* analytics;
* recovery;
* compatibility.

The testing strategy must derive from risks and criteria.

Look for:

* subjective criteria;
* tests tied to internal implementation;
* absence of negative tests;
* permissions without coverage;
* contracts without integration;
* critical journeys without end-to-end coverage;
* risks without a test or alternative verification.

---

## 15. Review vertical slices

Evaluate whether the feature can be split into increments that:

* produce value;
* cross the necessary layers;
* include permissions, data, and tests;
* are integrable;
* reduce risk;
* are reviewable;
* do not depend on one large final delivery.

Reject decompositions based solely on:

* frontend;
* backend;
* database;
* integration;
* tests.

Detect whether the feature contains several independent capabilities that should be separated before planning.

---

## Contradiction review

Explicitly compare:

* problem versus solution;
* scope versus flows;
* rules versus criteria;
* ownership versus permissions;
* states versus actions;
* errors versus recovery;
* data versus privacy;
* contracts versus integrations;
* metrics versus outcome;
* rollout versus rollback;
* acceptance versus testing;
* feature versus product scope.

Every contradiction must cite both incompatible elements.

---

## Gates

### APPROVED FOR PLANNING

There are no open critical or high findings.

The feature is coherent, verifiable, bounded, and may proceed to `create-exec-plan`.

### APPROVED WITH CONDITIONS

It may be planned under explicit conditions.

Each condition must have:

* owner;
* deadline date or event;
* resolution criterion;
* impact if not met.

Do not use this gate to hide fundamental problems.

### CHANGES REQUIRED

There are high findings, contradictions, or ambiguities that must be corrected before planning.

The feature must return to `design-feature`.

### MORE EVIDENCE REQUIRED

Value, behavior, or scope depends on assumptions that are still insufficiently validated.

It must return to `validate-assumptions` or run an experiment.

### SECURITY REVIEW REQUIRED

There are security, privacy, fraud, or abuse risks that need specialized review.

### ARCHITECTURE REVIEW REQUIRED

The feature poses systemic impacts or dependencies that need `define-quality-attributes` or `review-architecture`.

### BLOCKED

There are decisions, dependencies, authorities, or critical risks without a viable resolution.

### REJECTED

The feature is not coherent with the problem, the product, or the expected value and should not continue in its current form.

---

## Human approvals

Require human approval for:

* scope changes;
* residual critical risk;
* billing or pricing;
* authentication or authorization;
* sensitive data;
* irreversible deletion;
* ownership transfers;
* legal compliance;
* public exposure;
* contractual integrations;
* decisions that are hard to reverse;
* acceptance of a rejected or blocked feature.

---

## Prohibitions

This skill must not:

* write code;
* implement fixes;
* modify production;
* choose technologies;
* silently redesign;
* expand or reduce scope without approval;
* invent evidence;
* approve due to lack of time;
* treat preferences as requirements;
* omit uncomfortable risks;
* replace a specialized security review;
* approve its own design without independent review when the process requires it.

---

## Recommended `review.md` format

```markdown
# Feature Review — <Feature Name>

## Metadata
## Reviewer Independence
## Sources Reviewed
## Review Scope
## Executive Summary
## Traceability
## Value Assessment
## Scope Assessment
## Flow Assessment
## Roles, Permissions and Ownership
## Business Rules
## States and Transitions
## Validations, Errors and Edge Cases
## Security, Privacy and Abuse
## Accessibility, Responsive and UI States
## Data and Contracts
## Integrations and Dependencies
## Metrics, Operations and Support
## Rollout and Rollback
## Acceptance Criteria
## Testing Strategy
## Vertical Slice Feasibility
## Contradictions
## Ambiguities
## Missing Decisions
## Findings
## Conditions
## Required Human Approvals
## Final Gate
```

---

## Final report

On completion, report:

* feature reviewed;
* gate obtained;
* finding count by severity;
* main contradictions;
* critical risks;
* missing decisions;
* approval conditions;
* required human approvals;
* affected documents;
* recommended next skill.

The next skill will normally be:

* `create-exec-plan`, if approved;
* `design-feature`, if changes are required;
* `validate-assumptions`, if evidence is missing;
* `review-security`, if specialized risks exist;
* `review-architecture`, if there is systemic impact;
* no implementation, if the gate is `BLOCKED` or `REJECTED`.
