# verify.d hooks

Optional executable hooks run by `scripts/verify` in sorted order.

## Usage

```bash
cp ../project-verify.example ./10-unit.sh   # or add any executable
chmod +x ./10-unit.sh
```

Prefer a single `scripts/project-verify` for simple projects.
Use `verify.d/*` when checks should stay split (lint, types, security, …).

Hooks must:

- be executable;
- exit non-zero on failure;
- avoid printing secrets.
