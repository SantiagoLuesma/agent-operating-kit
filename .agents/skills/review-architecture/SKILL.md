---
name: review-architecture
description: >
  Perform an independent, adversarial review of a proposed or existing software
  architecture before implementation, expansion, or major modification. Checks
  product alignment, quality attributes, boundaries, data ownership, security,
  failure handling, operability, and accidental complexity. Does not implement
  changes or silently redesign the system. Use when architecture is proposed or
  about to drive a walking skeleton or major change. Produces
  docs/architecture/review.md and a gate (APPROVED, CONDITIONALLY APPROVED,
  CHANGES REQUIRED, SPIKES REQUIRED, SECURITY REVIEW REQUIRED, MORE PRODUCT OR
  QUALITY INPUT REQUIRED, BLOCKED, REJECTED).
---

# review-architecture

## Purpose

Perform an independent, adversarial review of a proposed or existing software architecture before implementation, expansion, or major modification.

This skill determines whether the architecture:

* supports approved product goals and scope;
* satisfies the defined quality attributes;
* assigns responsibilities and data ownership coherently;
* handles failures, security, operations, and evolution;
* introduces justified complexity;
* can be implemented, tested, deployed, and reversed responsibly.

The reviewer must identify evidence, contradictions, risks, unknowns, and missing decisions.

This skill does not implement changes or silently replace the architecture with the reviewer’s preferred design.

---

## Compatibility

This skill is model-agnostic and compatible with Codex, OpenCode, Claude Code, Grok, Kimi, DeepSeek, and any coding agent capable of inspecting repositories and documentation.

The repository is the source of truth. Chat history is supporting context only.

Whenever possible, the review should be performed by an agent or session independent from the architecture author.

---

## When to use

Use this skill when:

* a new architecture has been proposed;
* an existing system is preparing for significant growth or change;
* quality attributes have been defined;
* a feature introduces cross-cutting architectural impact;
* module boundaries, data ownership, integrations, or deployment are changing;
* recurring incidents suggest structural problems;
* a walking skeleton or implementation plan is about to begin.

Do not use it to:

* design the product;
* implement refactors;
* select technologies without architectural need;
* rewrite the proposal during review;
* approve undocumented assumptions.

---

## Expected inputs

Review, when available:

* `AGENTS.md`;
* `docs/project-status.md`;
* `docs/product/scope.md`;
* feature specifications and reviews;
* `docs/architecture/quality-attributes.md`;
* architecture diagrams and descriptions;
* ADRs;
* repository structure;
* runtime and deployment configuration;
* schemas, contracts, migrations, and integration documentation;
* operational metrics, incidents, and cost information;
* existing tests and CI workflows.

For an existing architecture, inspect implementation evidence where access permits.

Record missing or stale inputs as review limitations.

---

## Deliverables

Create or update:

```text
docs/architecture/review.md
```

Recommend new ADRs or spikes where necessary, but do not create architectural decisions silently.

Update `docs/project-status.md` when the gate, blockers, risks, or next recommended skill change.

---

## Review evidence

Distinguish:

* documented intention;
* repository evidence;
* automated verification;
* runtime observation;
* stakeholder statement;
* assumption;
* unknown.

Do not treat diagrams or documents as proof that the implementation behaves accordingly.

---

## Finding format

Every finding must include:

* identifier;
* title;
* category;
* location or affected area;
* evidence;
* expected behavior or requirement;
* observed or proposed behavior;
* impact;
* severity;
* confidence;
* recommended correction;
* owner;
* closing condition.

### Severity

* `CRITICAL`: likely severe security, compliance, availability, integrity, or irreversible business impact.
* `HIGH`: architecture cannot be implemented or operated reliably without resolution.
* `MEDIUM`: meaningful risk or maintainability problem that requires an explicit decision.
* `LOW`: limited impact improvement.
* `NOTE`: observation without required correction.

### Confidence

* `HIGH`: supported by direct and consistent evidence.
* `MEDIUM`: supported by partial evidence or strong inference.
* `LOW`: plausible concern requiring validation.

A style preference is not an architectural finding unless it creates measurable impact against scope, quality attributes, or operational constraints.

---

## Procedure

## 1. Establish review context

Define:

* architecture under review;
* system boundary;
* review horizon;
* approved scope;
* critical business flows;
* quality-attribute drivers;
* constraints;
* proposed changes;
* reviewer independence;
* unavailable evidence.

Identify which requirements are truly architecture-driving.

---

## 2. Verify product alignment

Check whether the architecture supports:

* approved users and actors;
* core product loops;
* required capabilities;
* explicit non-goals;
* planned increments;
* expected business outcomes.

Identify:

* components supporting unapproved future scope;
* missing support for critical flows;
* infrastructure justified only by speculative growth;
* architecture that makes likely product changes disproportionately difficult.

Architecture should serve product decisions, not dictate them without evidence.

---

## 3. Review drivers and constraints

Verify that architectural choices trace to:

* quality-attribute scenarios;
* legal or contractual requirements;
* existing system constraints;
* operational capacity;
* cost limits;
* integration requirements;
* migration constraints.

Challenge drivers based on:

* assumed scale;
* hypothetical global deployment;
* unvalidated real-time needs;
* speculative extensibility;
* personal technology preference.

Missing measurable drivers must be recorded.

---

## 4. Review boundaries and responsibilities

Evaluate modules, services, packages, layers, or bounded areas for:

* clear responsibility;
* cohesive behavior;
* explicit ownership;
* stable interfaces;
* minimal knowledge of internal details;
* appropriate dependency direction;
* independent testability;
* feasible evolution.

Look for:

* shared mutable state;
* duplicated business rules;
* cyclic dependencies;
* cross-module database access;
* orchestration scattered across modules;
* generic “common” modules with unrelated responsibilities;
* boundaries based only on technical layers;
* distributed components that must always change together.

Do not require a particular architectural style.

---

## 5. Review dependencies, coupling, and cohesion

Map critical dependencies and classify them as:

* compile-time;
* runtime;
* data;
* deployment;
* organizational;
* external provider;
* operational.

Evaluate:

* failure propagation;
* release coordination;
* version compatibility;
* replaceability;
* ownership;
* fan-in and fan-out;
* hidden coupling through schemas, events, configuration, or shared libraries.

Distinguish necessary coupling from accidental coupling.

---

## 6. Review data flows and ownership

For each important data domain determine:

* source of truth;
* owner;
* writers;
* readers;
* lifecycle;
* sensitivity;
* retention;
* deletion;
* history;
* derived copies;
* synchronization;
* reconciliation.

Trace critical flows from input to persistence, processing, external effects, and output.

Identify:

* multiple uncoordinated writers;
* unclear authority;
* duplicated data without synchronization rules;
* sensitive data crossing unnecessary boundaries;
* orphaned data;
* impossible deletion guarantees;
* undocumented manual intervention.

---

## 7. Review identity, authorization, and multitenancy

Evaluate:

* authentication boundaries;
* session and identity propagation;
* authorization enforcement;
* ownership checks;
* privileged operations;
* service-to-service identity;
* tenant resolution;
* tenant isolation;
* administration and impersonation;
* revocation;
* audit requirements.

Look for:

* authorization enforced only in UI;
* implicit trust between modules;
* tenant identifiers supplied without verification;
* shared caches or queries leaking data;
* background jobs lacking tenant context;
* overly broad administrative access.

Authentication, authorization, and billing changes require explicit human approval.

---

## 8. Review security, privacy, and abuse

Perform a lightweight threat review covering:

* assets;
* actors;
* trust boundaries;
* entry points;
* privileged operations;
* likely abuse cases;
* data exposure;
* secret handling;
* supply-chain exposure;
* logs and analytics;
* destructive actions.

Evaluate threats such as:

* spoofing;
* tampering;
* repudiation;
* information disclosure;
* denial of service;
* privilege escalation;
* enumeration;
* replay;
* fraud;
* spam;
* malicious uploads.

Critical concerns must trigger `review-security`.

---

## 9. Review consistency and concurrency

Evaluate:

* transactional boundaries;
* invariants;
* consistency requirements;
* concurrent updates;
* duplicate processing;
* ordering;
* idempotency;
* retries;
* compensating actions;
* conflict resolution;
* eventual consistency windows.

Check whether transaction boundaries align with business invariants.

Identify workflows that can leave contradictory, partial, or unrecoverable state.

---

## 10. Review contracts and integrations

Inspect APIs, events, queues, webhooks, files, and third-party integrations for:

* contract ownership;
* input and output definitions;
* authentication and authorization;
* versioning;
* compatibility;
* idempotency;
* ordering;
* delivery guarantees;
* error semantics;
* rate limits;
* timeouts;
* retries;
* dead-letter or recovery behavior;
* observability;
* data privacy.

Do not assume queues or events automatically create decoupling.

Determine whether consumers can evolve independently and whether external failures are contained.

---

## 11. Review failures and recovery

For each critical dependency and workflow evaluate:

* timeout policy;
* retry policy;
* backoff;
* duplicate effects;
* circuit breaking or degradation needs;
* partial completion;
* compensation;
* operator intervention;
* user feedback;
* recovery evidence.

Challenge retries that can amplify outages or duplicate side effects.

“No failure expected” is not an acceptable recovery strategy.

---

## 12. Review performance, capacity, and scalability

Compare the architecture against approved quality scenarios:

* latency percentiles;
* throughput;
* concurrency;
* data volume;
* peak behavior;
* background workload;
* resource limits;
* growth horizon.

Identify likely bottlenecks, fan-out, unbounded queries, synchronous chains, contention, or expensive duplication.

Distinguish:

* current requirements;
* credible growth;
* speculative scale.

Recommend benchmarks or spikes where evidence is insufficient.

---

## 13. Review availability and disaster recovery

Evaluate:

* critical failure domains;
* single points of failure;
* degradation behavior;
* dependency outages;
* backup scope;
* backup frequency;
* restore verification;
* RTO;
* RPO;
* disaster ownership;
* regional or provider failure where required.

Backups without tested restoration are insufficient evidence.

Do not demand redundancy beyond the justified availability and cost budget.

---

## 14. Review observability and support

Verify that operators can determine:

* whether the system is healthy;
* which flow is failing;
* who or what is affected;
* what changed;
* how to correlate requests or jobs;
* how to recover safely.

Evaluate:

* logs;
* metrics;
* traces;
* audit trails;
* alerts;
* dashboards;
* runbooks;
* support tooling;
* privacy controls;
* retention.

Avoid observability that exposes sensitive data or creates excessive cost without value.

---

## 15. Review deployment, migrations, and rollback

Evaluate:

* deployment units;
* release ordering;
* environment differences;
* configuration;
* secret rotation;
* schema changes;
* data migrations;
* backward compatibility;
* rolling or staged deployment;
* feature activation;
* rollback;
* irreversible operations.

Check compatibility among:

* old code and new schema;
* new code and old schema;
* producers and consumers at different versions;
* partially migrated data.

“Revert the deployment” is not sufficient when data or external effects have changed.

---

## 16. Review sustainability

Evaluate:

* testability;
* maintainability;
* modifiability;
* documentation;
* local reproducibility;
* CI feedback;
* debugging;
* operational burden;
* team knowledge;
* provider costs;
* infrastructure costs;
* cost growth;
* developer experience.

Identify architecture that requires expertise, staffing, or operational maturity the project does not possess.

---

## 17. Detect accidental complexity

Challenge:

* microservices without independent scaling or ownership needs;
* queues without asynchronous business requirements;
* caches without measured bottlenecks;
* event sourcing without audit or reconstruction requirements;
* generic abstraction layers without multiple real consumers;
* multiple deployable units that always change together;
* premature multi-region design;
* extensibility for hypothetical use cases;
* duplicated infrastructure.

Also detect underengineering where real critical requirements are ignored.

Complexity is justified only when it addresses a documented driver better than simpler alternatives.

---

## 18. Review alternatives and trade-offs

Verify that meaningful alternatives were considered.

For each major decision record:

* options;
* drivers;
* advantages;
* disadvantages;
* costs;
* risks;
* reversibility;
* rejected reasons;
* missing evidence.

Identify decisions requiring ADRs.

Do not require an ADR for trivial or easily reversible implementation details.

---

## 19. Recommend spikes

Recommend a technical spike only when uncertainty cannot be resolved through existing evidence.

Each spike must define:

* question;
* hypothesis;
* minimal experiment;
* representative load or failure;
* success and failure criteria;
* time or scope boundary;
* expected evidence;
* decision enabled;
* disposable outputs.

A spike must not become hidden production implementation.

---

## Adversarial questions

Ask:

* Which quality attribute does each major component support?
* What fails when this dependency is unavailable?
* Where can data cross tenant boundaries?
* Which invariant spans multiple systems?
* What happens after a partial write?
* Can a retry duplicate money, messages, or state?
* Which changes require coordinated deployment?
* Can the system be restored within the stated RTO and RPO?
* Which assumptions lack measurements?
* What complexity could be removed?
* What is difficult or impossible to reverse?
* Which decision lacks an owner or ADR?
* Could a simpler architecture satisfy the same drivers?

---

## Gates

### APPROVED

No critical or high findings remain open.

The architecture is aligned, sufficiently evidenced, operable, testable, and proportionate to current drivers.

It may continue to `build-walking-skeleton` or `create-exec-plan`.

### CONDITIONALLY APPROVED

The architecture may proceed under explicit conditions.

Every condition must include:

* owner;
* deadline or triggering event;
* closing evidence;
* impact if unresolved.

No critical finding may remain open.

### CHANGES REQUIRED

High-impact architectural problems or contradictions must be corrected and reviewed again.

### SPIKES REQUIRED

Important decisions depend on unresolved technical evidence.

Architecture work may continue only outside the uncertain area.

### SECURITY REVIEW REQUIRED

Security, privacy, multitenancy, or abuse risks require specialized review.

### MORE PRODUCT OR QUALITY INPUT REQUIRED

Architectural drivers are unclear, conflicting, or unmeasurable.

Return to scope, feature design, or quality-attribute definition.

### BLOCKED

Critical risks, missing authority, unacceptable irreversibility, or unresolved constraints prevent responsible progress.

### REJECTED

The architecture is fundamentally misaligned, unjustifiably complex, or unable to satisfy critical requirements in its current form.

---

## Human approvals

Require human approval for:

* authentication and authorization models;
* multitenancy boundaries;
* billing or payment architecture;
* destructive migrations;
* sensitive-data handling;
* irreversible provider commitments;
* material cost commitments;
* compliance decisions;
* accepted critical risks;
* disaster-recovery trade-offs;
* architecture that significantly changes approved scope.

---

## Final checklist

* [ ] Product scope and architecture drivers are traced.
* [ ] Quality attributes are evaluated with evidence.
* [ ] Boundaries and ownership are coherent.
* [ ] Dependencies and failure propagation are understood.
* [ ] Data flows and invariants are explicit.
* [ ] Authentication, authorization, and tenant isolation are reviewed.
* [ ] Threats, abuse, and privacy risks are assessed.
* [ ] Transactions, concurrency, and idempotency are addressed.
* [ ] Contracts and integrations define failure behavior.
* [ ] Performance and scale claims are evidence-based.
* [ ] Recovery, backups, and rollback are credible.
* [ ] Observability and support responsibilities exist.
* [ ] Deployment and migration compatibility are covered.
* [ ] Costs and operational maturity are proportionate.
* [ ] Accidental complexity has been challenged.
* [ ] Alternatives, trade-offs, ADRs, and spikes are recorded.
* [ ] Every finding has evidence, impact, severity, confidence, and correction.
* [ ] The gate matches unresolved risk.

---

## Prohibitions

This skill must not:

* implement changes;
* silently redesign the architecture;
* modify production;
* select technology based on preference;
* invent evidence;
* treat style disagreements as defects;
* require complexity without a documented driver;
* accept diagrams as implementation proof;
* approve critical unknowns;
* hide trade-offs;
* create ADR decisions without authority;
* perform destructive tests;
* access sensitive production data without approval;
* approve its own architecture when independent review is required.

---

## Recommended output format

```markdown
# Architecture Review

## Metadata
## Reviewer Independence
## Scope and Sources
## Executive Summary
## Product and Quality Alignment
## Context, Drivers, and Constraints
## Boundaries and Responsibilities
## Dependencies, Coupling, and Cohesion
## Data Flows and Ownership
## Authentication, Authorization, and Multitenancy
## Security, Privacy, and Threats
## Consistency, Transactions, and Concurrency
## APIs, Events, Queues, and Integrations
## Failure Handling and Recovery
## Performance, Capacity, and Scalability
## Availability and Disaster Recovery
## Observability, Auditability, and Support
## Deployment, Migrations, Compatibility, and Rollback
## Testability, Maintainability, Costs, and DX
## Accidental Complexity
## Alternatives and Trade-offs
## Required ADRs
## Recommended Spikes
## Findings
## Unknowns and Missing Decisions
## Human Approvals
## Final Gate
```

---

## Final report

Report:

* architecture reviewed;
* final gate;
* findings by severity;
* highest-risk contradictions;
* critical unknowns;
* required corrections;
* required ADRs;
* recommended spikes;
* human approvals;
* next recommended skill.

The next skill will normally be:

* `build-walking-skeleton`, when approved;
* `create-exec-plan`, for an approved bounded change;
* `define-quality-attributes`, when drivers are insufficient;
* `review-security`, for specialized security concerns;
* another architecture review after required corrections;
* no implementation when the gate is `BLOCKED` or `REJECTED`.
