# Project status

## Identity

| Field | Value |
| --- | --- |
| Project | Agent operating kit (`starter-project`) |
| Kind | Portable kit (process + skills + doc skeleton), not an application |
| Kit version | `0.3.2` (see `VERSION`) |
| Branch policy | Work on feature branches (e.g. `grok`); archive on `version-original` / `original-baseline` |

## Current phase

**Level B complete — dry-run trusted packaging**

## Gate

`KIT LEVEL B COMPLETE`

## Objective

Prove the kit bootstraps cleanly and supports quick + standard smoke paths with
STRICT verification hooks before merge/tag.

## Completed

- Level A packaging (skeletons, SECURITY, templates, bootstrap parity)
- Level B dry-run via `scripts/smoke-level-b`
- Fix: bootstrap installs instance `project-status` template (not kit status)
- Evidence: `docs/kit/level-b-report.md`

## In progress

- None

## Next

- Human review → merge `grok` → `main`
- Tag `v0.3.2` (optional but recommended)
- Use kit on a real product project when ready
- Level C optional skills later

## Authoritative documents

| Concern | Path |
| --- | --- |
| Completeness | `docs/kit/completeness.md` |
| Level B report | `docs/kit/level-b-report.md` |
| Script contracts | `docs/kit/scripts.md` |
| Agent rules | `AGENTS.md` |

## Blockers

None for Level B.

## Risks

- Smoke does not replace a full multi-day product discovery or production release.
- CI must have `git` available for smoke commits (standard on GitHub-hosted runners).

## Next recommended action

Merge to `main` and tag when satisfied; or bootstrap into a real repo.

## Next recommended skill

For a real product: `discover-product` or `audit-existing-project`.
