# Script contracts

Deterministic entrypoints for agents and CI. Prefer these over inventing
commands per session.

## Exit codes

| Code | Meaning |
| ---: | --- |
| 0 | Success |
| 1 | Check failed |
| 2 | Not configured (only when `STRICT=1` requires configuration) |

Never treat a missing test suite as a silent pass in production projects when
`STRICT=1` is set in CI.

## scripts/check-docs

Structural integrity of the kit / project layout:

- required docs, profiles, adapters, templates;
- `VERSION` semver;
- every skill has YAML frontmatter `name` + `description`;
- skill directory name matches frontmatter `name`;
- `AGENTS.md` catalog table entries exist on disk;
- scripts exist and are executable;
- no obvious secret/TODO markers in core kit files.

```bash
./scripts/check-docs
```

## scripts/verify

Project health:

1. runs `check-docs` (unless `SKIP_DOCS=1`);
2. runs `scripts/project-verify` if executable;
3. else runs executable hooks in `scripts/verify.d/` (sorted);
4. else kit-only mode, or warns if stack manifests exist without hooks.

```bash
./scripts/verify
STRICT=1 ./scripts/verify   # fail if app stack has no hooks
```

Wire app checks:

```bash
cp scripts/project-verify.example scripts/project-verify
chmod +x scripts/project-verify
# edit to call lint/typecheck/build/tests
```

## scripts/test

Test entrypoint:

1. `scripts/project-test` if present;
2. else common stack detectors (`npm test`, `pytest`, `go test`, `cargo test`, …);
3. else `NOT CONFIGURED` (exit 0 unless `STRICT=1`).

```bash
./scripts/test
STRICT=1 ./scripts/test
```

## scripts/list-skills

```bash
./scripts/list-skills
./scripts/list-skills --paths
```

## scripts/bootstrap-project

Copy the kit into another repository:

```bash
./scripts/bootstrap-project /path/to/project
./scripts/bootstrap-project /path/to/project --force
```

Writes `docs/kit-version.md` with the kit version stamp. Installs
`docs/project-status.md` from the **template** (does not copy the kit repo’s
own status). Does not invent product scope. Skips existing files unless
`--force` (except instance status template install rules above).

## scripts/smoke-level-b

Level B dry-run harness:

```bash
./scripts/smoke-level-b
./scripts/smoke-level-b /tmp/smoke-parent
```

Bootstraps a temp app, runs structural checks, exercises **quick** and
**standard** documentation/implementation smoke paths with `STRICT=1` hooks,
and writes `docs/kit/level-b-report.md` when run from the kit repo.

## Agent rules

- Run `./scripts/verify` before claiming a change is healthy when scripts exist.
- Record command, exit code, and revision in plans/handoffs.
- Do not claim tests passed when the output is `NOT CONFIGURED`.
