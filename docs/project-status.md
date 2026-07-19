# Project status

## Identity

| Field | Value |
| --- | --- |
| Project | Agent operating kit (`starter-project`) |
| Kind | Portable kit (process + skills + doc skeleton), not an application |
| Kit version | `0.3.1` (see `VERSION`) |
| Branch policy | Work on feature branches (e.g. `grok`); archive on `version-original` / `original-baseline` |

## Current phase

**Block A complete — Level A packaging (merge-ready kit surface)**

## Gate

`KIT LEVEL A COMPLETE`

## Objective

Ship a cloneable, agent-agnostic kit with non-empty skeletons, security baseline,
aligned templates, bootstrap parity, and an explicit completeness definition.

## Completed

- Phases 1–3 (packaging, scripts, pipeline skills, English skills)
- Block A:
  - skeletons for product / ux / architecture / runbooks
  - `SECURITY.md`
  - skill-aligned templates (feature/architecture review, experiments, validation)
  - bootstrap parity with full `docs/` + CI + security
  - `docs/kit/completeness.md` + `CHANGELOG.md`
  - removed `example-feature-1` and `.commandcode`
  - stricter `check-docs` (non-empty skeletons)

## In progress

- None (Level A)

## Next (Level B — not part of Block A)

- Dry-run bootstrap + quick/standard path on a sample repo
- Merge `grok` → `main` and tag `v0.3.1` when approved
- Optional Level C skills later

## Authoritative documents

| Concern | Path |
| --- | --- |
| Completeness | `docs/kit/completeness.md` |
| Script contracts | `docs/kit/scripts.md` |
| Agent rules | `AGENTS.md` |
| Security | `SECURITY.md` |
| Changelog | `CHANGELOG.md` |

## Blockers

None for Level A.

## Risks

- Level A does not prove the kit on a real product (that is Level B).
- Skeleton sections remain empty by design until a product fills them.

## Next recommended action

Human review of Block A → dry-run (Level B) → merge/tag.

## Next recommended skill

None for kit maintenance. For a product instance: `discover-product` or
`audit-existing-project`.
