# Kit completeness

What “done” means for this **agent operating kit** (not for a product built
with it).

## Kit language

English is the canonical language for kit rules, skills, templates, and
scripts. Project instances may use another language for product docs; keep
each artifact internally consistent.

## Level A — Ready for internal merge / tag

| Requirement | Status source |
| --- | --- |
| Canonical `AGENTS.md` with skill catalog and profiles | `AGENTS.md` |
| Skills under `.agents/skills/*/SKILL.md` with `name` + `description` | `scripts/check-docs` |
| Profiles `quick` / `standard` / `full` | `profiles/` |
| Thin adapters (`CLAUDE.md`, generic prompt) | `adapters/`, `CLAUDE.md` |
| Script contracts + executable entrypoints | `docs/kit/scripts.md`, `scripts/` |
| Doc skeletons (not zero-byte) for product/ux/architecture/runbooks | `docs/**` |
| Skill-aligned templates (feature, plan, handoff, reviews, release, …) | `docs/**/_templates/` |
| `SECURITY.md` present | root |
| `CHANGELOG.md` + `VERSION` (semver) | root |
| Bootstrap produces a `check-docs`-capable project | `scripts/bootstrap-project` |
| CI workflow for kit checks | `.github/workflows/kit-ci.yml` |
| No tool-specific noise required to use the kit | e.g. no required `.commandcode` |

Verify:

```bash
./scripts/check-docs
./scripts/verify
./scripts/list-skills
```

## Level B — Ready to trust on real work

Level A, plus:

1. Automated dry-run: `./scripts/smoke-level-b`
2. Report: `docs/kit/level-b-report.md` shows **LEVEL B SMOKE PASSED**
3. Covers: bootstrap, instance status template, profile **quick**, profile **standard**,
   `STRICT=1` verify/test with project hooks
4. Friction fixes from the dry-run are merged (e.g. bootstrap must not copy kit
   `project-status` into instances)

Re-run anytime:

```bash
./scripts/smoke-level-b
# optional: ./scripts/smoke-level-b /tmp/my-smoke-parent
```

## Level C — Optional long-term

- Visual UX skill, incident/postmortem skill
- Extra IDE adapters
- Rich fictional sample product
- Automated upgrade tooling between kit versions

## What must stay empty until a product exists

Skeletons intentionally have empty sections. That is **not** incompleteness of
the kit. It means *not decided* for the product instance.

Do not fill kit skeletons with a fake SaaS to look complete.

## Bootstrap parity

`scripts/bootstrap-project` should copy:

- root kit files (`AGENTS.md`, adapters, `SECURITY.md`, `VERSION`, …);
- `.agents/skills`, `profiles`, `adapters`, `scripts`, `contracts`;
- full `docs/` tree (skeletons + templates + kit docs);
- PR template and kit CI workflow;
- `docs/kit-version.md` stamp.

## Updating a live project

| Safe to refresh from kit | Merge carefully |
| --- | --- |
| `.agents/skills/**` | Project-filled `docs/product|features|…` |
| `profiles/**`, `adapters/**` | Customized `AGENTS.md` (`Project-specific`) |
| `scripts/*` entrypoints + lib | App `project-verify` / CI |
| templates under `docs/**/_templates/` | Instance runbooks with real commands |

Record `kit_version` in `docs/kit-version.md` / project status after upgrades.

## When to bump VERSION

| Bump | When |
| --- | --- |
| patch (0.3.x) | skeletons, docs, bootstrap, check-docs fixes |
| minor (0.x.0) | new skills, script contracts, profile changes |
| major | breaking catalog/path/authority changes |
