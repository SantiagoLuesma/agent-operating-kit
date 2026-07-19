# Project status

## Identity

| Field | Value |
| --- | --- |
| Project | Agent operating kit (`starter-project`) |
| Kind | Portable kit (process + skills + doc skeleton), not an application |
| Kit version | `0.1.0` (see `VERSION`) |
| Branch policy | Work on feature branches (e.g. `grok`); archive snapshot on `version-original` / tag `original-baseline` |

## Current phase

**Kit packaging — Phase 1**

Making the repository usable as a multi-project base: canonical rules, complete
skill inventory, rigor profiles, adapters, templates, and onboarding docs.

## Gate

`KIT PACKAGING IN PROGRESS`

## Objective

Produce a cloneable, agent-agnostic kit that can be copied into new or existing
software projects without depending on a specific model or vendor workflow.

## Completed

- Baseline skills under `.agents/skills/`
- Canonical `AGENTS.md` with authority hierarchy
- Git archive: `main`, `version-original`, tag `original-baseline`
- Work branch: `grok`
- Phase 1 kit packaging (README, profiles, adapters, templates, scripts)
- All skills normalized to **English** (previously mixed ES/EN)

## In progress

- None

## Next

- Phase 2: stronger script contracts and validation helpers
- Dry-run the kit on a tiny real or sample product later

## Authoritative documents

| Concern | Path |
| --- | --- |
| Agent rules | `AGENTS.md` |
| Tooling baseline | `TOOLING.md` |
| Profiles | `profiles/` |
| Skills | `.agents/skills/` |
| Templates | `docs/**/_templates/`, `docs/decisions/adr/_template.md` |

## Blockers

None.

## Risks

- Skill catalog is deeper than onboarding; profiles must prevent over-process.
- Some skills still vary in depth/language; normalize gradually.
- No application stack yet by design; `scripts/verify` may report not configured
  until a project instance adds a stack.

## Next recommended action

Continue kit packaging on branch `grok`; do not invent product scope for a
fictional app inside this repository.

## Next recommended skill

None for product work. For kit maintenance, follow `AGENTS.md` and update docs
with `update-documentation` when packaging changes behavior of the kit itself.
