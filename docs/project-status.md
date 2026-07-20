# Project status

## Identity

| Field | Value |
| --- | --- |
| Project | Agent operating kit (`starter-project`) |
| Kind | Portable kit (process + skills + doc skeleton), not an application |
| Kit version | `0.3.5` (see `VERSION`) |
| Branch | `main` (merged from `grok`) |
| Archive | `version-original` / tag `original-baseline` |

## Current phase

**Released on main — Level A + Level B complete**

## Gate

`KIT ON MAIN`

## Objective

Maintain a cloneable, agent-agnostic kit for multi-project use.

## Completed

- Level A packaging (skeletons, SECURITY, templates, bootstrap parity)
- Level B dry-run (`scripts/smoke-level-b`, `docs/kit/level-b-report.md`)
- Merge `grok` → `main` (fast-forward)
- Tag `v0.3.2`

## In progress

- None

## Next

- Bootstrap into a real product repository when ready
- Optional Level C (UX visual skill, incident skill, richer sample, …)
- Push remote + enable GitHub Actions when a remote exists

## Authoritative documents

| Concern | Path |
| --- | --- |
| Completeness | `docs/kit/completeness.md` |
| Level B report | `docs/kit/level-b-report.md` |
| Changelog | `CHANGELOG.md` |
| Agent rules | `AGENTS.md` |

## Blockers

None.

## Next recommended action

Use `./scripts/bootstrap-project <path>` on a real project, or push `main` + tag to a remote.

## Next recommended skill

For a product instance: `discover-product` or `audit-existing-project`.
