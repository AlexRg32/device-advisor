---
name: writing-plans
description: Use when you have requirements for a native app task before touching code. Produces atomic, testable implementation plans.
---

# Writing Implementation Plans

## Rules

1. Tasks must be 5-15 minutes when possible.
2. Foundation first, UI integration second, polish last.
3. Every task needs a verification step.
4. Note docs updates whenever behavior or architecture changes.

## Standard Loop

1. Write or identify the failing test or verification.
2. Implement the smallest useful change.
3. Run the verification command.
4. Mark the task complete.

## Plan Template

```markdown
# [Feature]
> Goal: [value]
> Architecture: [pattern]

### Task N: [Name]
1. Add failing test or define manual verification.
2. Implement in the target file(s).
3. Run `swift test` or `xcodebuild test -scheme <Scheme> -destination 'platform=macOS'`.
4. Update docs if needed.
5. Mark task as done in `plan.md`.
```
