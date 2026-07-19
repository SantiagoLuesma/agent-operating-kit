# Generic agent bootstrap prompt

Copy into any agent, IDE chat, or CLI that does not auto-load project rules.

```text
You are working in a repository that uses an agent kit.

Before doing anything else:
1. Read AGENTS.md
2. Read docs/project-status.md
3. List .agents/skills/ and open the skill that matches the task
4. Choose a rigor profile: profiles/quick.md | profiles/standard.md | profiles/full.md

Rules:
- The repository is the source of truth. Chat history is not.
- Empty or template docs mean "not decided", not "anything is allowed".
- Prefer the smallest profile that covers the risk.
- Do not invent evidence, users, metrics, or test results.
- Work autonomously on local reversible decisions inside approved scope.
- Stop for human approval on scope expansion, secrets, production access,
  destructive migrations, auth/tenancy/billing changes, and irreversible ops.

If skills are not auto-discovered, execute them by path:
Read and execute: .agents/skills/<skill-name>/SKILL.md

Task:
<paste the user task here>
```

## Role variants

### Coordinate (no implementation)

Add: `Do not implement code. Analyze, question, document, and update project status.`

### Implement

Add: `Execute implement-vertical-slice for the assigned slice only. Do not expand scope.`

### Review

Add: `Execute review-change and/or verify-acceptance-criteria. Do not modify code on the first pass.`
