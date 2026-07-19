---
name: design-architecture
description: >
  Propose a software architecture for an approved product increment based on
  scope and quality attributes: system context, containers/components,
  data ownership, trust boundaries, integration patterns, and evolution
  constraints. Produces docs under docs/architecture/ for later adversarial
  review. Does not implement code, select trendy stacks without drivers, or
  approve itself—follow with review-architecture.
---

# Design Architecture

## Purpose

Create an explicit, proportionate architecture proposal that satisfies
approved product scope and quality-attribute scenarios, so implementation can
proceed through a walking skeleton and vertical slices without reinventing
boundaries in every PR.

This skill **proposes**. Independent review is `review-architecture`.

## When to use

Use when:

* scope is ready or conditionally ready;
* quality attributes exist or are being defined in parallel with enough drivers;
* a new system, major subsystem, or cross-cutting change needs structure;
* multiple features will share contracts, data, or trust boundaries.

Do not use when:

* the change is a local bugfix with no structural impact (`quick` profile);
* product problem/scope is still undefined;
* you only want to introduce a fashionable technology.

## Expected inputs

* `AGENTS.md`, `docs/project-status.md`, `docs/product/scope.md`;
* `docs/architecture/quality-attributes.md` (required for non-trivial systems);
* feature outlines or specs that drive shared behavior;
* existing architecture, ADRs, contracts, runtime topology for brownfield;
* constraints: team size, budget, compliance, existing vendors.

## Deliverables

Create or update as applicable:

```text
docs/architecture/system-context.md
docs/architecture/containers.md          # or components overview
docs/architecture/tenancy.md             # if multi-tenant
docs/architecture/data-classification.md # if sensitive data
docs/architecture/deployment.md          # target runtime shape
docs/architecture/observability.md
docs/decisions/adr/                      # only for decisions that need ADRs
docs/project-status.md
```

Keep a short index in `docs/architecture/` or update existing files rather than
sprawling duplicates.

## Design principles

1. **Drivers first** — every non-trivial choice traces to scope or QA scenarios.
2. **Simplest structure that works** — complexity needs a written driver.
3. **Clear ownership** — data and rules have one authority.
4. **Trust boundaries explicit** — authn/z enforced server-side.
5. **Evolve** — prefer change paths that do not require rewrites.
6. **Brownfield honesty** — document as-is vs to-be when migrating.

## Procedure

### 1. Restate architecture drivers

List architecture-driving requirements from scope and quality attributes:

* critical flows;
* constraints;
* QA scenarios that force structure (e.g. isolation, latency, audit);
* non-goals that prevent over-design.

### 2. System context

Describe:

* users and external systems;
* trust boundaries;
* major data exchanges;
* what is inside vs outside the system.

### 3. Container / component view

Propose deployable or logical containers (apps, services, jobs, data stores)
with responsibilities—not class diagrams.

For each container:

* responsibility;
* data owned;
* interfaces provided/required;
* scaling/failure notes;
* why it exists (driver).

Challenge every extra container: could this be a module instead?

### 4. Data ownership and flows

For important data domains:

* source of truth;
* writers/readers;
* consistency expectations;
* retention/deletion;
* tenant or ownership boundaries;
* migration implications.

### 5. Identity, authorization, tenancy

Define at architecture level:

* how identity enters the system;
* where authorization is enforced;
* tenant resolution and isolation strategy;
* admin/impersonation boundaries if any.

Flag human-approval areas (auth models, tenancy, billing).

### 6. Integration style

For each external or internal integration:

* sync vs async;
* contract ownership;
* idempotency/retry expectations;
* failure isolation;
* observability needs.

### 7. Cross-cutting concerns

Address only with drivers present:

* observability (logs/metrics/traces/audit);
* configuration and feature flags;
* secret handling (no secret values in docs);
* multi-region or HA only if required;
* caching only with invalidation story.

### 8. Deployment and environments

Outline:

* runtime topology;
* environment differences;
* migration approach at a high level;
* rollback posture.

Detailed migration review remains `review-migration` when concrete.

### 9. Evolution and alternatives

Document 1–2 serious alternatives considered and why rejected.

Identify decisions that need ADRs vs reversible implementation details.

### 10. Walking skeleton plan (outline)

Propose the thinnest end-to-end path that proves the architecture (inputs →
processing → persistence → output) for later `build-walking-skeleton`.

### 11. Self-check before review

* Every container maps to a driver  
* No speculative microservices  
* Permissions and tenancy not “UI only”  
* Data ownership unambiguous  
* Failure modes acknowledged  
* Ready for adversarial `review-architecture`  

## Gates

### ARCHITECTURE PROPOSAL READY

Proposal is coherent and complete enough for independent review.

### CONDITIONALLY READY

Gaps listed with owners; review may proceed with constraints.

### DRIVERS INSUFFICIENT

Return to `define-quality-attributes` or product scope skills.

### BLOCKED

Missing authority, constraints, or brownfield access prevents a responsible
proposal.

## Prohibitions

Do not:

* implement production code or schemas as the primary output;
* select technologies without linking to drivers;
* hide trade-offs;
* treat diagrams as proof of runtime behavior;
* approve your own architecture (require `review-architecture`);
* expand product scope silently.

## Final report

* Gate  
* Drivers used  
* Containers and ownership summary  
* Highest risks and trade-offs  
* ADRs needed  
* Docs updated  
* Next skill: **`review-architecture`** (required for non-trivial systems)  

## Recommended outline

```markdown
# Architecture proposal

## Drivers and constraints
## System context
## Containers and responsibilities
## Data ownership and flows
## Identity, authorization, tenancy
## Integrations
## Cross-cutting concerns
## Deployment and environments
## Alternatives considered
## Walking skeleton outline
## Risks and open questions
## Gate
```
