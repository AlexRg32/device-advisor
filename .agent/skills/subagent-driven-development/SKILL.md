---
name: subagent-driven-development
description: Use when executing implementation plans. Dispatches fresh subagents per task with spec and quality reviews suited to native desktop work.
---

# Subagent-Driven Development

## Workflow

1. Dispatch one fresh subagent per task from `plan.md`.
2. Review 1: `@architect` validates scope and platform realism.
3. Review 2: `@backend`, `@frontend`, or `@doc-planner` validates quality depending on the change.
4. Update docs when behavior or architecture changes.
5. Mark task completion in plan artifacts.

## Laws

- One subagent, one task.
- Pass the exact task text, not only a file path.
- Re-review fixes with the same persona that requested them.
- Reviews must check for user-facing clarity around unknown or unsupported battery states.
