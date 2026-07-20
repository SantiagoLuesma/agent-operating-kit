---
name: define-quality-attributes
description: >
  Transform product, business, user, and operational needs into explicit,
  measurable, prioritized, and verifiable quality attributes before designing
  the architecture. Define scenarios with metrics and thresholds for security,
  availability, performance, consistency, operability, and other attributes,
  without selecting a stack or designing definitive components. Use it when
  increment scope is defined and architectural drivers or non-functional
  trade-offs are needed. Produces docs/architecture/quality-attributes.md and
  a gate (QUALITY ATTRIBUTES READY, CONDITIONALLY READY, MEASUREMENT REQUIRED,
  REFINEMENT REQUIRED, SPECIALIST REVIEW REQUIRED, BLOCKED).
---

# define-quality-attributes

## Purpose

Transform product, business, user, and operational needs into explicit, measurable, prioritized, and verifiable quality attributes before designing the architecture.

This skill defines how secure, available, fast, consistent, maintainable, observable, accessible, interoperable, operable, and efficient the system must be, under concrete conditions.

Its output must enable later architectural decisions to respond to demonstrable needs rather than preferences, trends, or speculative optimizations.

---

## Compatibility

This skill is agnostic to model, provider, language, framework, and platform.

It is client-agnostic and works with any agent capable of inspecting documentation and repositories.

The source of truth is the repository.

---

## When to use it

Use this skill when:

* the product scope or next increment is defined;
* features are sufficiently designed;
* criteria are needed to evaluate architecture;
* the system has security, availability, performance, compliance, or scale requirements;
* an existing project must review its non-functional needs;
* there are conflicts among speed, cost, resilience, consistency, or maintainability;
* an architectural spike or review is about to be performed.

Do not use it to:

* select technologies;
* design definitive components;
* decide on microservices, queues, caches, or providers;
* invent objectives without evidence;
* turn every desirable quality into a critical requirement.

---

## Expected inputs

Review, when they exist:

* `AGENTS.md`;
* `docs/project-status.md`;
* `docs/product/scope.md`;
* discovery and validation documentation;
* feature specifications;
* existing project audit;
* current architecture;
* production metrics;
* incidents;
* commercial agreements;
* legal constraints;
* operational needs;
* user profiles;
* growth forecasts;
* budget limits;
* external dependencies.

Classify each input as:

* observed evidence;
* contractual requirement;
* constraint;
* decision;
* assumption;
* estimate;
* preference;
* unknown.

---

## Deliverables

Create or update:

```text
docs/architecture/quality-attributes.md
```

Optionally:

```text
docs/architecture/quality-budget.md
docs/architecture/quality-risks.md
```

Update `docs/project-status.md` with:

* gate;
* critical attributes;
* risks;
* blockers;
* next recommended skill.

Do not duplicate existing documentation. Link to canonical sources.

---

## Principles

### Use scenarios, not adjectives

Avoid requirements such as:

* “the system must be fast”;
* “it must be secure”;
* “it must scale”;
* “it must have high availability”.

Each attribute must be expressed through conditions, load, response, metrics, and verifiable thresholds.

### Prioritize

Not all attributes can be maximized simultaneously.

Classify each requirement as:

* `CRITICAL`;
* `HIGH`;
* `MEDIUM`;
* `LOW`;
* `DEFERRED`;
* `NOT REQUIRED`.

An attribute is not critical merely because it is desirable.

### Avoid speculative optimization

Every threshold must derive from:

* user behavior;
* business impact;
* regulation;
* contract;
* operational evidence;
* external dependency;
* explicitly accepted risk.

When there is insufficient evidence, record a hypothesis, provisional range, or measurement need.

---

## Quality-Attribute Scenario

Record each scenario with a stable identifier:

```text
QA-SEC-001
```

Each scenario must include:

* attribute;
* stimulus source;
* stimulus;
* context or condition;
* affected component or capability;
* expected response;
* metric;
* target threshold;
* minimum acceptable threshold;
* load or volume;
* criticality;
* evidence;
* verification method;
* owner;
* risk if not met;
* status;
* review date or condition.

Conceptual format:

```text
Given:
When:
Then:
Measured by:
Target:
Minimum acceptable:
Verification:
```

---

## Procedure

## 1. Establish context

Define:

* product or system under analysis;
* time horizon;
* relevant increment;
* users;
* critical processes;
* priority business flows;
* sensitive data;
* essential dependencies;
* current volume;
* expected growth;
* constraints;
* failure consequences.

Distinguish between:

* needs of the whole system;
* needs of a feature;
* future needs that are not yet committed.

---

## 2. Security and privacy

Evaluate:

* authentication;
* authorization;
* least privilege;
* isolation between accounts or tenants;
* data protection;
* secrets management;
* traceability;
* abuse;
* fraud;
* impersonation;
* export;
* deletion;
* retention;
* consent;
* exposure in logs and analytics.

Define scenarios about:

* unauthorized access;
* privilege escalation;
* resource enumeration;
* data leakage;
* compromised credentials;
* sensitive actions;
* malicious content;
* incident response.

Record:

* protected data;
* authorized actors;
* detection time;
* containment time;
* required evidence;
* residual risk.

Critical requirements must later be referred to `review-security`.

---

## 3. Availability, resilience, and recovery

Identify critical functions and dependencies.

Define:

* service hours;
* target availability;
* acceptable degradation;
* fault tolerance;
* maximum interruption time;
* maximum data loss;
* recovery;
* retries;
* idempotency;
* partial operation;
* manual continuity.

When applicable, establish:

* `RTO`: recovery time objective;
* `RPO`: maximum acceptable data loss;
* error budget;
* backup frequency;
* restore verification.

Differentiate between:

* total outage;
* degradation;
* failed external dependency;
* delayed processing;
* temporarily stale data.

Do not require high availability without justifying impact and cost.

---

## 4. Performance, latency, and capacity

Identify time-sensitive journeys and operations.

For each scenario define:

* operation;
* concurrent load;
* data volume;
* relevant percentile;
* target latency;
* timeout;
* throughput;
* maximum process duration;
* behavior under saturation.

Prefer percentiles such as `p95` or `p99` when relevant, not averages alone.

Distinguish:

* human interaction;
* background processes;
* searches;
* imports;
* exports;
* bulk operations;
* integrations.

Define how measurement will be done and with what representative data.

---

## 5. Scalability

Determine which dimension may grow:

* users;
* tenants;
* data;
* traffic;
* files;
* events;
* integrations;
* regions;
* asynchronous tasks;
* administrative operations.

Record:

* baseline;
* expected volume;
* horizon;
* peak;
* growth pattern;
* acceptable limit;
* saturation signal;
* verification strategy.

Do not design for a hypothetical scale without significant probability or impact.

Separate:

* capacity needed now;
* anticipated capacity;
* capacity that only requires not closing future options.

---

## 6. Data consistency and integrity

Define for each critical data set or process:

* source of truth;
* invariants;
* uniqueness;
* required atomicity;
* expected consistency;
* tolerance for stale data;
* event order;
* duplicates;
* concurrency;
* reconciliation;
* history;
* auditability;
* deletion.

Distinguish when the following is required:

* immediate consistency;
* eventual consistency;
* reading potentially stale data;
* compensation;
* manual review.

Document consequences of:

* partial write;
* duplicate processing;
* concurrent update;
* loss of order;
* failure across systems.

Do not turn a technical preference into a consistency rule.

---

## 7. Maintainability and modifiability

Identify foreseeable changes:

* new rules;
* new roles;
* new channels;
* new integrations;
* regulatory changes;
* new plans;
* expansion of states;
* provider substitution.

For each relevant change define:

* likely frequency;
* expected scope;
* acceptable time or effort;
* risk;
* areas that should remain decoupled;
* evidence that the change is likely.

Evaluate:

* clarity;
* cohesion;
* coupling;
* documentation;
* ownership;
* ease of evolution;
* backward compatibility.

Do not require generic extensibility for unidentified scenarios.

---

## 8. Testability

Define which behaviors must be verifiable in a:

* deterministic;
* isolated;
* automated;
* reproducible;
* observable manner.

Evaluate needs for:

* test data;
* environments;
* time control;
* dependency simulation;
* failure testing;
* contracts;
* permissions;
* concurrency;
* migrations;
* rollback.

Record:

* acceptable feedback time;
* expected stability;
* required evidence;
* flows that need end-to-end tests;
* risks that need manual or specialized verification.

---

## 9. Observability and auditability

Define which operational questions must be answerable:

* Is the system working?
* Where does it fail?
* Whom does it affect?
* What changed?
* What action did an actor perform?
* Can an incident be reconstructed?

Cover:

* logs;
* metrics;
* traces;
* alerts;
* business events;
* correlation;
* audit;
* retention;
* privacy;
* access to evidence.

For each scenario indicate:

* signal;
* threshold;
* recipient;
* detection time;
* expected action;
* prohibited information.

Distinguish technical observability, analytics, and audit.

---

## 10. Accessibility and compatibility

Define verifiable requirements for:

* keyboard navigation;
* focus;
* semantics;
* screen readers;
* contrast;
* zoom;
* reduced motion;
* error messages;
* touch targets;
* alternative content;
* responsive design.

Define compatibility with:

* browsers;
* devices;
* screen sizes;
* operating systems;
* languages;
* time zones;
* assistive technologies;
* public contract versions.

Do not use “compatible with everything”. Bound support and acceptable degradation.

---

## 11. Interoperability and portability

Identify:

* external systems;
* exchange formats;
* consumers;
* contracts;
* imports;
* exports;
* substitutable providers;
* hosting or region constraints.

Define:

* compatibility;
* versioning;
* change tolerance;
* idempotency;
* limits;
* data portability;
* exit procedure;
* acceptable provider dependency.

Do not require full provider independence without justifying cost and risk.

---

## 12. Operability and support

Define needs for:

* deployment;
* configuration;
* diagnosis;
* manual correction;
* retries;
* moderation;
* support;
* restoration;
* rollback;
* administration;
* incidents.

For critical operations establish:

* owner;
* permissions;
* procedure;
* target time;
* evidence;
* risk;
* escalation.

Identify processes that may remain manual and their maximum acceptable capacity.

---

## 13. Costs and efficiency

Define budgets or limits for:

* infrastructure;
* external services;
* storage;
* transfer;
* observability;
* support;
* processing;
* cost per user, tenant, or operation.

Relate each limit to:

* business model;
* volume;
* margin;
* criticality;
* uncertainty.

Distinguish:

* fixed cost;
* variable cost;
* peak cost;
* operational cost;
* complexity cost.

Do not optimize costs by sacrificing critical attributes without an explicit decision.

---

## 14. Compliance

Identify obligations:

* legal;
* regulatory;
* contractual;
* fiscal;
* privacy;
* accessibility;
* retention;
* data residency;
* audit.

For each obligation record:

* source;
* jurisdiction;
* scope;
* owner;
* required evidence;
* frequency;
* consequence of non-compliance;
* need for professional review.

The agent must not invent a definitive legal interpretation.

---

## 15. Developer experience

Define needs for:

* reproducible setup;
* documentation;
* local feedback;
* deterministic commands;
* environments;
* test data;
* debugging;
* CI;
* contract updates;
* onboarding;
* error recovery.

Establish metrics when relevant:

* setup time;
* feedback time;
* failure frequency;
* reproducibility;
* operational complexity.

Developer experience must not be prioritized over security or integrity, but should be considered as a sustainability attribute.

---

## 16. Trade-offs and conflicts

Create a conflict matrix, for example:

* security versus ease of use;
* consistency versus availability;
* latency versus cost;
* resilience versus complexity;
* portability versus provider leverage;
* observability versus privacy;
* delivery speed versus modifiability;
* accessibility versus visual constraints.

For each conflict indicate:

* opposing attributes;
* scenario;
* recommended decision;
* evidence;
* consequences;
* residual risk;
* required authority.

Do not hide trade-offs under claims that “everything is a priority”.

---

## Quality budgets

When applicable, create explicit budgets:

* latency budget;
* availability/error budget;
* recovery budget;
* capacity budget;
* cost budget;
* data-loss budget;
* operational workload budget;
* complexity budget.

Each budget must have:

* scope;
* unit;
* limit;
* period;
* owner;
* measurement method;
* response when exhausted.

---

## Prioritization

Evaluate each scenario according to:

* impact;
* probability;
* frequency;
* flow criticality;
* regulation;
* cost of non-compliance;
* evidence;
* reversibility;
* implementation cost.

Separate:

* architecture-driving requirements;
* local requirements of a feature;
* preferences;
* future optimizations;
* unknowns.

Only requirements that significantly condition the system structure should drive global architectural decisions.

---

## Adversarial review

Ask:

* Does the threshold have evidence?
* Is the load realistic?
* Can the metric be measured?
* Is the verification method reproducible?
* Is optimization targeting an improbable future?
* Is a critical flow being ignored?
* Do two attributes contradict each other?
* Is the cost proportional to the risk?
* Is there an owner?
* Is the failure condition defined?
* Is a local requirement forcing global architecture?
* Can it be deferred without closing options?
* Is human approval missing?

Record contradictions, unknowns, and pending decisions.

---

## Gates

### QUALITY ATTRIBUTES READY

Critical attributes are prioritized, measured, traceable, and verifiable.

Work may continue to `review-architecture` or the corresponding architectural design.

### CONDITIONALLY READY

Progress may continue with:

* provisional thresholds;
* explicit assumptions;
* accepted risks;
* non-blocking pending measurements.

Each condition must have an owner and resolution criterion.

### MEASUREMENT REQUIRED

A baseline or evidence needed to define reliable thresholds is missing.

Measurement, benchmark, test, or spike must be performed.

### REFINEMENT REQUIRED

There are vague, contradictory, non-verifiable, or unprioritized requirements.

### SPECIALIST REVIEW REQUIRED

Specialized legal, security, privacy, accessibility, compliance, or other discipline review is required.

### BLOCKED

Indispensable decisions, constraints, evidence, or authority for responsible architecture design are missing.

---

## Final checklist

Before closing, verify:

* [ ] Every critical attribute has concrete scenarios.
* [ ] Metrics and thresholds exist.
* [ ] Load and conditions were documented.
* [ ] Each scenario has criticality and evidence.
* [ ] A verification method exists.
* [ ] An owner exists.
* [ ] Risks were identified.
* [ ] Requirements were distinguished from speculation.
* [ ] Applicable quality budgets were defined.
* [ ] Trade-offs were analyzed.
* [ ] Architecture drivers were identified.
* [ ] Human approvals were recorded.
* [ ] The gate is consistent with the unknowns.

---

## Prohibitions

This skill must not:

* select technologies;
* design definitive architecture;
* prescribe microservices, cache, queues, or replication;
* invent metrics;
* demand maximum quality on all attributes;
* hide uncertainty;
* confuse future optimization with current requirement;
* ignore costs;
* accept non-verifiable requirements;
* replace legal or specialized review;
* approve irreversible decisions without human authority.

---

## Recommended format

```markdown
# Quality Attributes

## Context
## Sources and Evidence
## Critical Business Flows
## Assumptions and Unknowns
## Architecture-Driving Requirements
## Quality-Attribute Scenarios
### Security and Privacy
### Availability, Resilience and Recovery
### Performance and Capacity
### Scalability
### Data Consistency and Integrity
### Maintainability and Modifiability
### Testability
### Observability and Auditability
### Accessibility and Compatibility
### Interoperability and Portability
### Operability and Support
### Costs and Efficiency
### Compliance
### Developer Experience
## Quality Budgets
## Trade-offs
## Risks
## Required Measurements or Spikes
## Human Approvals
## Final Gate
```

---

## Final report

Report:

* gate obtained;
* critical attributes;
* architecture drivers;
* scenarios defined;
* budgets established;
* main trade-offs;
* critical risks;
* pending measurements;
* human approvals;
* next recommended skill.

The next skill will normally be:

* `review-architecture`;
* a technical spike or benchmark;
* `review-security`;
* specialized review;
* product or feature refinement if needs remain ambiguous.
