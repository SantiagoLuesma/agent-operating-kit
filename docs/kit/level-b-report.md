# Level B dry-run report

| Field | Value |
| --- | --- |
| Kit version | 0.3.2 |
| Kit root | `(local kit checkout — redacted for public repo)` |
| Smoke parent | `(temp dir — redacted)` |
| App path | `(temp app — redacted)` |
| Started (UTC) | 2026-07-19T09:14:06Z |

Regenerate anytime with `./scripts/smoke-level-b` (local absolute paths are not committed).

## 1. Bootstrap

- bootstrap-project completed

## 2. Structural checks (fresh instance)

- check-docs passed
- verify passed
- list-skills count = 22
- test NOT CONFIGURED (expected for kit-only instance)

## 3. Instance project-status

- project-status is instance template (not kit status)

## 4. Profile quick (chore + hooks + handoff)

- quick path: hello script + hooks + STRICT verify/test + commit
- handoff: docs/handoffs/active/quick-hello.md

## 5. Profile standard (scope + feature pack + plan + handoff)

- standard path: scope + feature pack + exec plan + handoff + STRICT verify
- feature: docs/features/greeting/
- plan: docs/plans/active/greeting-smoke.md

## 6. Result

- **LEVEL B SMOKE PASSED**
- Finished (UTC): 2026-07-19T09:14:12Z
