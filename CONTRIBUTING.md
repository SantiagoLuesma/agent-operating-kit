# Contributing to the kit

## Branches

- Do not commit on `version-original` (archive).
- Prefer feature branches; integrate via review to `main`.
- Keep commits focused.

## Changing skills

1. Edit `.agents/skills/<name>/SKILL.md`.
2. Ensure YAML frontmatter has `name` and `description`.
3. Update the catalog table in `AGENTS.md` and `README.md` when adding skills.
4. Run `./scripts/check-docs`.

## Changing AGENTS.md

- Keep security and approval gates strong.
- Put instance-only rules under `## Project-specific` in project copies.
- Do not add model-specific parallel rule files.

## Validation

```bash
./scripts/check-docs
./scripts/verify
```

## Pull requests

Use `.github/pull_request_template.md`. State profile, skills used, and evidence.
