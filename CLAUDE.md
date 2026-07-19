@AGENTS.md

# Claude Code adapter

Canonical project rules live in `AGENTS.md`. Do not duplicate or weaken them here.

## Always

1. Read `AGENTS.md`.
2. Read `docs/project-status.md` before non-trivial work.
3. Prefer skills under `.agents/skills/*/SKILL.md` over improvising process.
4. Choose a rigor profile from `profiles/` (`quick` | `standard` | `full`).
5. Keep the repository as the source of truth; chat history is not authority.

## Skills

If skills are not auto-discovered, invoke explicitly:

```text
Read and execute: .agents/skills/<skill-name>/SKILL.md
```

## Safety

Stop for human approval on scope expansion, production access, secrets,
destructive migrations, auth/tenancy/billing changes, and irreversible work.
