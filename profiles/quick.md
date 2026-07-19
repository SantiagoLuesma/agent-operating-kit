# Profile: quick

Use for **low-risk, well-understood** work: clear bugs, chores, copy fixes,
small doc updates, and narrowly scoped refactors that do not change product
behavior, contracts, auth, tenancy, billing, or data lifecycle.

## Default path

1. Read `AGENTS.md` and `docs/project-status.md`.
2. Confirm scope and non-goals in one short note (handoff or plan optional).
3. Implement the smallest fix (`implement-vertical-slice` only if the change
   still spans multiple layers; otherwise keep it minimal).
4. Run `scripts/verify` / relevant tests.
5. Light review: self-diff + `review-change` only if risk is non-obvious.
6. `update-documentation` if behavior or ops docs changed.
7. `prepare-pr` when ready for human review.

## Skip unless needed

- `discover-product`, `audit-existing-project`
- `validate-assumptions`, `define-product-scope`
- `design-feature`, `review-feature`
- `define-quality-attributes`, `review-architecture`
- Full security/migration reviews (unless the bug touches those areas)

## Stop and escalate to `standard` or `full` when

- behavior is ambiguous;
- more than one interpretation of “correct” exists;
- auth, tenancy, payments, privacy, or public contracts are involved;
- a migration or irreversible operation appears;
- the fix keeps growing past a small vertical change.
