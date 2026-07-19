# Changelog

All notable changes to the **agent operating kit** are documented here.

## [0.3.1] — 2026-07-19

### Added

- Skeleton forms for all product, UX, architecture, and runbook docs (no more zero-byte files).
- `SECURITY.md` baseline policy for the kit and instances.
- Skill-aligned templates: feature review, architecture review, experiments, validation summary.
- `docs/kit/completeness.md` (definition of done for the kit).
- `docs/features/README.md` (how to create a feature pack from templates).
- Bootstrap parity: copies full `docs/`, `SECURITY.md`, `CHANGELOG.md`, kit CI, contracts.

### Changed

- `scripts/bootstrap-project` materializes a `check-docs`-capable project tree.
- `scripts/check-docs` verifies non-empty skeletons and additional templates.
- Kit language documented as English for kit artifacts.

### Removed

- `docs/features/example-feature-1/` placeholders (use `_templates/` only).
- `.commandcode/` tool-specific noise from the kit surface.

## [0.3.0] — 2026-07-19

### Added

- Pipeline skills: `design-information-architecture`, `design-architecture`,
  `build-walking-skeleton`, `prepare-release`.
- Expanded `validate-assumptions` to full skill standard.
- Catalog and profile updates for full lifecycle through release prep.

## [0.2.0] — 2026-07-19

### Added

- Script contracts (`docs/kit/scripts.md`), `list-skills`, `bootstrap-project`.
- Project verify/test hook examples and `verify.d/`.
- GitHub Actions `kit-ci.yml`.
- Shared `scripts/lib/common.sh` and exit-code contract.

## [0.1.0] — 2026-07-19

### Added

- Initial packaging: `AGENTS.md`, profiles, adapters, templates, README, TOOLING.
- Skill inventory baseline; English normalization of formerly Spanish skills.
- Archive baseline on `version-original` / tag `original-baseline`.
