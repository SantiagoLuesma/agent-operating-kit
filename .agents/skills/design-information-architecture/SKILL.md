---
name: design-information-architecture
description: >
  Design the product information architecture after scope is clear enough:
  objects, navigation, labeling, user journeys at the structural level, and
  content hierarchy. Produces docs under docs/ux/ without visual polish or
  implementation. Use between define-product-scope and design-feature when
  users must find, understand, and move between capabilities. Does not write
  production UI code or choose a design system library.
---

# Design Information Architecture

## Purpose

Translate approved product scope into a coherent **information structure**:
what things exist, how they are named, how users navigate among them, and how
primary journeys traverse the structure.

This skill designs structure and meaning, not pixels. It enables consistent
feature design and reduces contradictory navigation later.

## When to use

Use when:

* product scope for an increment exists (`docs/product/scope.md`);
* multiple objects, roles, or areas must be organized;
* users will search, browse, or switch context (tenants, projects, resources);
* feature specs would otherwise invent competing navigation models;
* an existing product’s IA is confusing and a bounded redesign is approved.

Do not use to:

* invent product scope;
* produce high-fidelity mockups as the primary output;
* implement frontend routes without an approved feature plan;
* pick CSS frameworks or component libraries.

## Expected inputs

* `AGENTS.md`, `docs/project-status.md`;
* `docs/product/scope.md`, problem/users docs;
* roles and permissions overview when present;
* existing `docs/ux/*` and live product IA (for redesigns);
* accessibility and content constraints.

## Deliverables

Create or update:

```text
docs/ux/information-architecture.md
docs/ux/user-flows.md                 # structural journeys, not full UI specs
docs/ux/content-guidelines.md         # labels, tone rules for IA terms (if needed)
docs/project-status.md
```

Optional: `docs/ux/navigation-map.md` if the project prefers a split file.

## Procedure

### 1. Anchor to scope

Restate:

* primary actors;
* core loop;
* MUST capabilities in this increment;
* explicit non-goals.

Refuse to structure capabilities that are out of scope.

### 2. Inventory domain objects

List conceptual objects users encounter (e.g. Project, Invoice, Member).

For each object:

* definition in user language;
* owner;
* key attributes users need to recognize it;
* relationships to other objects;
* lifecycle states visible to users;
* which roles can see/act on it.

### 3. Define grouping and hierarchy

Propose areas/sections that group capabilities (not engineering modules).

Rules:

* prefer user goals over internal org charts;
* limit top-level items to what this increment truly needs;
* mark future areas as out of scope rather than building empty shells.

### 4. Define navigation model

Specify:

* primary navigation;
* secondary/contextual navigation;
* cross-links that prevent dead ends;
* empty-state entry points for new users;
* multi-tenant or multi-account switching if applicable.

Call out authorization: hidden nav ≠ authorization.

### 5. Labeling and language

For each nav item and object:

* user-facing label;
* forbidden synonyms (to prevent drift);
* glossary link when needed.

Prefer existing product glossary terms.

### 6. Map structural user flows

For each critical journey in scope:

* entry point;
* steps across IA nodes;
* success landing;
* failure/recovery returns;
* required permissions.

Keep flows structural; leave detailed interaction to `design-feature`.

### 7. Define findability

Describe how users find things:

* browse hierarchy;
* search expectations (if in scope);
* filters/sorting concepts;
* deep links / shared URLs if relevant.

### 8. Accessibility and inclusion structure

Ensure structure supports:

* logical heading/landmarks plan (conceptual);
* keyboard traversal order expectations;
* non-color-only differentiation of states;
* clear names for assistive tech (labels).

### 9. Consistency with permissions

Verify every navigable destination has a permission story. Remove IA entries
that imply unauthorized power.

### 10. Adversarial pass

Challenge:

* Could a new user reach the first value without tribal knowledge?
* Are two labels used for the same object?
* Does navigation reflect org politics instead of user tasks?
* Are MUST journeys longer than necessary?
* Did future scope leak into top-level nav?

## Quality criteria

IA is ready when:

* objects and labels are consistent;
* MUST journeys are mapped end to end;
* non-goals are not represented as empty product areas;
* permissions align with navigable destinations;
* feature designers can place screens without inventing a competing map.

## Gates

### IA READY

Structure is coherent enough for feature design to proceed.

### CONDITIONALLY READY

Proceed with listed open questions and temporary labels.

### REFINEMENT REQUIRED

Contradictions or missing object definitions block feature design.

### MORE PRODUCT INPUT REQUIRED

Scope/actors/outcomes are insufficient; return to product skills.

### BLOCKED

Missing authority to change navigation or resolve naming conflicts.

## Prohibitions

Do not:

* invent capabilities outside scope;
* treat wireframe polish as completion;
* encode engineering service boundaries as user navigation without reason;
* hide security-sensitive destinations only in UI structure;
* write production frontend code.

## Final report

* Gate  
* Primary objects and nav model  
* Critical journeys covered  
* Open naming/permission issues  
* Docs updated  
* Next skill: usually `design-feature` or `define-quality-attributes`  

## Recommended output skeleton

```markdown
# Information Architecture

## Scope anchor
## Actors
## Domain objects
## Hierarchy and areas
## Navigation model
## Labeling and glossary
## Structural flows
## Findability
## Permissions alignment
## Non-goals / deferred areas
## Open questions
## Gate
```
