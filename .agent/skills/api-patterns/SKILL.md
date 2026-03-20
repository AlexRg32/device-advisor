---
name: api-patterns
description: Historical skill name kept for compatibility. Use for designing internal service contracts, adapter boundaries, and event flows in local-first native apps.
allowed-tools: Read, Write, Edit, Glob, Grep
---

# Internal Service Contract Patterns

Use this skill when defining how modules communicate inside the app.

## Prefer

- protocol-based boundaries
- small service interfaces
- explicit domain models for device and battery state
- predictable event or async-stream flows

## Ask Before Designing

- Is this boundary platform-specific?
- Does it need to survive a future Windows implementation?
- Is a protocol actually helping, or just adding ceremony?

## Anti-Patterns

- giant god services
- leaking CoreBluetooth types into unrelated modules
- event flows with no ownership or deduplication policy
