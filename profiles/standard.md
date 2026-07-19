# Profile: standard

Default for **normal product work** inside an already approved scope: a
feature slice, a meaningful behavior change, or a bounded improvement with
clear acceptance criteria.

## Default path

1. Read `AGENTS.md`, `docs/project-status.md`, active plan/handoff.
2. Confirm the change is in approved scope (`docs/product/scope.md` and
   feature docs). If scope is missing or contradictory, stop and fix scope
   first (`define-product-scope` or product decision).
3. If behavior is not specified well enough:
   - `design-feature` → `review-feature`
4. If cross-cutting quality or architecture is affected:
   - `define-quality-attributes` and/or `design-architecture` →
     `review-architecture` as needed
5. `create-exec-plan` for non-trivial implementation.
6. `implement-vertical-slice` for one milestone at a time
   (use `build-walking-skeleton` only when introducing a new architectural path).
7. `verify-acceptance-criteria` (independent session when possible).
8. `review-change`; add `review-security` / `review-migration` when relevant.
9. `update-documentation` + `generate-handoff` at interruptions.
10. `prepare-pr` → human PR approval.
11. After merge: `verify-main` when integration health matters;
    `prepare-release` when shipping a versioned release.

## Skills often in play

| Phase | Skills |
| --- | --- |
| Specify | `design-feature`, `review-feature` |
| Structure | `design-architecture`, `review-architecture` (when needed) |
| Plan | `create-exec-plan` |
| Build | `implement-vertical-slice` |
| Prove | `verify-acceptance-criteria`, `review-change` |
| Ship | `update-documentation`, `prepare-pr`, `verify-main`, `prepare-release` |

## Do not skip

- Explicit non-goals
- Acceptance criteria with evidence
- Permission/tenancy checks when data or multi-actor flows exist
- Independent review for non-trivial merges
