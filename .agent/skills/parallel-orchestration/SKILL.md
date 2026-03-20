---
name: parallel-orchestration
description: Multi-agent coordination for native desktop work. Use when a task needs architecture, platform integration, UI, and documentation viewpoints.
---

# Parallel Orchestration

## Domain Teams

| Team | Agents involved | Trigger |
| :--- | :--- | :--- |
| New Feature | `@architect` -> `@doc-planner` -> `@backend` -> `@frontend` | New product capability |
| Platform Risk | `@architect` -> `@backend` | Bluetooth, permissions, login item, notifications |
| UX Refinement | `@frontend` -> `@doc-planner` | Menu bar or settings improvements |

## Rules

- Each agent must own a clear responsibility.
- Findings flow forward to the next specialist.
- Final output must reconcile product truth, platform limits, and UX.
