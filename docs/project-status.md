# Project status

## Identity

| Field | Value |
| --- | --- |
| Project | Agent operating kit (`starter-project`) |
| Kind | Portable kit (process + skills + doc skeleton), not an application |
| Kit version | `0.3.0` (see `VERSION`) |
| Branch policy | Work on feature branches (e.g. `grok`); archive snapshot on `version-original` / tag `original-baseline` |

## Current phase

**Kit packaging — Phase 3 complete (pipeline skills)**

## Gate

`KIT PHASE 3 READY`

## Objective

Produce a cloneable, agent-agnostic kit covering product → design → build →
verify → release preparation without depending on a specific model or vendor.

## Completed

- Phase 1: packaging (AGENTS, profiles, adapters, templates, README)
- Phase 2: script contracts, bootstrap, CI, VERSION 0.2.x
- All skills in English
- Phase 3 pipeline skills:
  - expanded `validate-assumptions`
  - `design-information-architecture`
  - `design-architecture`
  - `build-walking-skeleton`
  - `prepare-release`
- Catalog and profiles updated for full lifecycle

## In progress

- None

## Next

- Dry-run: bootstrap kit into a sample/real mini-project
- Optional: merge `grok` → `main` and tag `v0.3.0`
- Optional later: design-ux visual skill, incident/postmortem skill

## Authoritative documents

| Concern | Path |
| --- | --- |
| Agent rules | `AGENTS.md` |
| Tooling baseline | `TOOLING.md` |
| Script contracts | `docs/kit/scripts.md` |
| Profiles | `profiles/` |
| Skills | `.agents/skills/` |

## Blockers

None.

## Risks

- Full profile is long by design; agents must still pick the smallest profile
  that matches risk (`quick` / `standard` / `full`).
- New skills are procedural templates—not a substitute for project-specific
  architecture decisions.

## Next recommended action

Use the kit on a real or sample product (`bootstrap-project`), or merge/tag
0.3.0 when satisfied.

## Next recommended skill

None for kit maintenance. For a new product instance: `discover-product` or
`audit-existing-project`.
