# Agent operating kit

Portable **process + skills + documentation skeleton** for building software
with AI agents — independent of model vendor and agent client.

License: [MIT](./LICENSE). Safe for public use: no application secrets, API keys,
or production credentials are part of this repository.

This repository is **not** an application starter (no app stack). It is the
shared operating system you copy into your projects so every agent follows the
same rules, evidence standards, and delivery workflow.

| Piece | Role |
| --- | --- |
| `AGENTS.md` | Canonical rules for every agent |
| `.agents/skills/` | Reusable procedures (`SKILL.md`) |
| `profiles/` | Rigor: `quick` / `standard` / `full` |
| `docs/` | Product, UX, architecture, plans, handoffs |
| `scripts/` | Deterministic verification entrypoints |
| `CLAUDE.md` / `adapters/` | Thin client adapters |
| `VERSION` | Kit version to record in project instances |

Current kit version: **0.3.3** — see [`VERSION`](./VERSION) and [`CHANGELOG.md`](./CHANGELOG.md).

Kit completeness: [`docs/kit/completeness.md`](./docs/kit/completeness.md)  
Level A = packaging · Level B = dry-run (`./scripts/smoke-level-b`, report in
[`docs/kit/level-b-report.md`](./docs/kit/level-b-report.md)).

## Principles

1. **Repository > chat.** Docs and code outrank conversation history.
2. **One workflow.** Do not fork process per model (GPT/Claude/Grok/…).
3. **Thin adapters.** Client-specific files only point at `AGENTS.md` + skills.
4. **Skills by path.** If auto-discovery is missing, invoke  
   `.agents/skills/<name>/SKILL.md` explicitly.
5. **Evidence.** Never claim success without executed checks on the right revision.
6. **Human gates.** Scope, irreversible ops, merge, and production stay human.

## Quick start for agents

```text
1. Read AGENTS.md
2. Read docs/project-status.md
3. Choose profiles/quick.md | standard.md | full.md
4. List .agents/skills/ and execute the matching skill
5. Update docs as decisions and evidence change
```

Generic paste-in prompt: [`adapters/generic-prompt.md`](./adapters/generic-prompt.md).

## Bootstrap a new software project

```bash
# From this kit repository:
./scripts/bootstrap-project /path/to/project

# Or with overwrite of kit-managed files:
./scripts/bootstrap-project /path/to/project --force
```

The bootstrap copies the full kit surface: `AGENTS.md`, `SECURITY.md`, skills,
profiles, adapters, scripts, **all doc skeletons/templates**, contracts, PR
template, kit CI workflow, and `docs/kit-version.md`. Kit guide is saved as
`README.kit.md`; a short project `README.md` stub is created when missing.

Then:

1. Edit `docs/project-status.md` for the product.
2. Run `./scripts/check-docs` in the target.
3. Wire stack checks: `cp scripts/project-verify.example scripts/project-verify`.
4. Run `discover-product` or `audit-existing-project` as appropriate.

Recommended first skill:

| Situation | Skill |
| --- | --- |
| Greenfield idea | `discover-product` |
| Existing codebase | `audit-existing-project` |

Then freeze increment scope with `define-product-scope` before heavy design.

## Bootstrap an existing repo

1. Copy `AGENTS.md`, `.agents/skills`, `profiles`, `scripts`, templates.
2. Do **not** overwrite existing product docs blindly.
3. Run `audit-existing-project`.
4. Fill `docs/project-status.md` with **verifiable** facts only.
5. Document legacy modules when you touch them — not everything at once.

## Updating the kit in a live project

| Safe to refresh often | Merge carefully |
| --- | --- |
| `.agents/skills/**` | `AGENTS.md` if you customized it |
| `profiles/**`, `adapters/**` | Project `docs/product|features|…` |
| `scripts/*` entrypoints | App-specific CI |

Project-only conventions go under the `## Project-specific` section at the
bottom of `AGENTS.md`. Keep kit core rules intact.

## Rigor profiles

| Profile | When |
| --- | --- |
| [`profiles/quick.md`](./profiles/quick.md) | Clear bug/chore, low risk |
| [`profiles/standard.md`](./profiles/standard.md) | Default feature work |
| [`profiles/full.md`](./profiles/full.md) | New domain, high uncertainty, security/data-critical |

Default for non-trivial product work: **standard**.

## Skill catalog

Live inventory: `.agents/skills/*/SKILL.md`.

| Situation | Skill |
| --- | --- |
| New or unclear product | `discover-product` |
| Inherited codebase | `audit-existing-project` |
| Validate critical assumptions | `validate-assumptions` |
| Freeze increment scope | `define-product-scope` |
| Information architecture | `design-information-architecture` |
| Quality attributes | `define-quality-attributes` |
| Design architecture | `design-architecture` |
| Review architecture | `review-architecture` |
| Walking skeleton | `build-walking-skeleton` |
| Design a feature | `design-feature` |
| Review feature design | `review-feature` |
| Execution plan | `create-exec-plan` |
| Implement a slice | `implement-vertical-slice` |
| Verify acceptance | `verify-acceptance-criteria` |
| Review the change | `review-change` |
| Security review | `review-security` |
| Migration review | `review-migration` |
| Sync documentation | `update-documentation` |
| Session handoff | `generate-handoff` |
| Prepare pull request | `prepare-pr` |
| Verify integration branch | `verify-main` |
| Prepare release | `prepare-release` |

## Layout

```text
AGENTS.md                 # constitution
CLAUDE.md                 # Claude adapter
TOOLING.md                # baseline vs enhancers
VERSION
profiles/                 # quick | standard | full
adapters/                 # generic prompts
.agents/skills/           # canonical skill inventory
docs/
  project-status.md
  product/scope.md        # canonical scope path
  features/_templates/
  plans/_templates/
  handoffs/_templates/
  decisions/adr/_template.md
scripts/
  check-docs
  verify
  test
  list-skills
  bootstrap-project
  project-verify.example
docs/kit/scripts.md       # script contracts
```

## Validation

```bash
./scripts/check-docs
./scripts/verify
./scripts/test            # NOT CONFIGURED until a stack exists
./scripts/list-skills
./scripts/smoke-level-b   # Level B dry-run (bootstrap + quick + standard)

# After an app stack exists, enforce hooks in CI:
STRICT=1 ./scripts/verify
STRICT=1 ./scripts/test
```

Script contracts: [`docs/kit/scripts.md`](./docs/kit/scripts.md).

CI for this kit repo: [`.github/workflows/kit-ci.yml`](./.github/workflows/kit-ci.yml).

## Git workflow for this kit repo

| Branch / ref | Purpose |
| --- | --- |
| `version-original` / tag `original-baseline` | Frozen pre-packaging snapshot |
| `grok` (or feature branches) | Active kit development |
| `main` | Integration branch for the kit |

## Human approval gates

1. Scope and behavior  
2. Irreversible decisions (auth, tenancy, billing, data, secrets, prod)  
3. Pull request merge  
4. Production / destructive migration  

## License / ownership

Released under the [MIT License](./LICENSE). Copyright (c) 2026 Santiago Luesma.
