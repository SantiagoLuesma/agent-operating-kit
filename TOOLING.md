# Tooling: baseline vs enhancers

This kit is **agent- and model-agnostic**. Workflow truth lives in the
repository, not in a vendor feature.

## Layers

| Layer | Responsibility |
| --- | --- |
| Model | Reasoning and generation (GPT, Claude, Grok, Kimi, DeepSeek, …) |
| Agent / client | Permissions, tools, how instructions load |
| Repository kit | `AGENTS.md`, skills, docs, scripts, profiles |
| Human | Irreversible decisions and final approvals |

Configure the workflow for the **repository**. Choose the model inside the agent.

## Baseline (must work everywhere)

Any client that can read (and preferably edit) files:

1. `AGENTS.md`
2. `.agents/skills/*/SKILL.md` via explicit path if needed
3. `docs/**` as source of truth
4. `profiles/*` for rigor
5. Git + PR for multi-session continuity
6. `scripts/verify` / `scripts/test` / `scripts/check-docs` when present

Fallback invocation:

```text
Read AGENTS.md and docs/project-status.md.
Read and execute: .agents/skills/<skill-name>/SKILL.md
```

## Enhancers (optional)

Use when available; never require them for correctness:

| Capability | Examples | Fallback |
| --- | --- | --- |
| Auto-load `AGENTS.md` | Codex, OpenCode | Prompt: read AGENTS.md first |
| Skill discovery | Agent Skills-compatible clients | Explicit path |
| Subagents | Parallel implement/review | Separate sessions or models |
| Managed worktrees | App-native worktrees | `git worktree` |
| MCP / browsers | Issue trackers, web | CLI + docs |
| Fine-grained permissions | Command allowlists | AGENTS gates + human |

## Adapters

| File | Role |
| --- | --- |
| `AGENTS.md` | Canonical rules (all agents) |
| `CLAUDE.md` | Thin Claude Code adapter |
| `adapters/generic-prompt.md` | Universal bootstrap prompt |

Do **not** maintain parallel rule files per model.

## Scripts

| Script | Meaning |
| --- | --- |
| `scripts/check-docs` | Kit/doc structural checks |
| `scripts/verify` | Project health entrypoint (delegates when stack exists) |
| `scripts/test` | Test entrypoint |

If a script reports `NOT CONFIGURED`, configure it for the project stack; do
not invent a green result.

## Recommended agent matrix (illustrative)

| Role | Preference |
| --- | --- |
| Coordinate / design | Strongest available reasoning |
| Implement | Full filesystem + terminal + Git |
| Review | Different model/session from implementer when possible |
| Verify | Scripts first, then agent interpretation |
| Human | Scope, irreversible ops, merge, production |
