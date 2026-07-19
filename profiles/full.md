# Profile: full

Use for **high uncertainty or high consequence** work: new products, major
new domains, security-sensitive systems, multi-tenant boundaries, billing,
large migrations, or inherited codebases with weak documentation.

## Default path

### New product / major new area

1. `discover-product`
2. `validate-assumptions` for lethal unknowns
3. `define-product-scope`
4. `design-information-architecture` when navigation/objects need structure
5. `define-quality-attributes`
6. `design-architecture` → `review-architecture`
7. `build-walking-skeleton` (thin end-to-end proof)
8. `design-feature` → `review-feature` per capability
9. `create-exec-plan` for remaining MUST slices
10. `implement-vertical-slice` (repeat)
11. `verify-acceptance-criteria` → `review-change` (+ security/migration as needed)
12. `update-documentation`, `generate-handoff`, `prepare-pr`
13. After merge: `verify-main` → `prepare-release` (human still approves deploy)

### Existing / opaque codebase

1. `audit-existing-project`
2. Fill `docs/project-status.md` with only verifiable facts
3. Document modules **when touched**, not everything at once
4. Then continue with `standard` or the product path above for new work

## Required discipline

- Separate facts, decisions, assumptions, and unknowns
- Independent review before merge for material changes
- Human gates: scope, irreversible decisions, PR, production/release
- Prefer evidence over confidence
- Do not implement while critical requirements contradict each other
- Do not skip `review-architecture` after designing non-trivial structure

## Skills often in play

All catalog skills may apply. Prefer sequencing from `AGENTS.md` and this
profile over running every skill by default on every task.
