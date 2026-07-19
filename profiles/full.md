# Profile: full

Use for **high uncertainty or high consequence** work: new products, major
new domains, security-sensitive systems, multi-tenant boundaries, billing,
large migrations, or inherited codebases with weak documentation.

## Default path

### New product / major new area

1. `discover-product`
2. `validate-assumptions` for lethal unknowns
3. `define-product-scope`
4. UX / information architecture work as needed (skill if present; otherwise
   document under `docs/ux/` with explicit open questions)
5. `define-quality-attributes`
6. Architecture design (document under `docs/architecture/`) → `review-architecture`
7. `design-feature` → `review-feature` per capability
8. `create-exec-plan`
9. Walking skeleton / first vertical slices via `implement-vertical-slice`
10. `verify-acceptance-criteria` → `review-change` → specialist reviews
11. `update-documentation`, `generate-handoff`, `prepare-pr`, `verify-main`

### Existing / opaque codebase

1. `audit-existing-project`
2. Fill `docs/project-status.md` with only verifiable facts
3. Document modules **when touched**, not everything at once
4. Then continue with `standard` or the product path above for new work

## Required discipline

- Separate facts, decisions, assumptions, and unknowns
- Independent review before merge for material changes
- Human gates: scope, irreversible decisions, PR, production
- Prefer evidence over confidence
- Do not implement while critical requirements contradict each other

## Skills often in play

All catalog skills may apply. Prefer sequencing from `AGENTS.md` and this
profile over running every skill by default on every task.
