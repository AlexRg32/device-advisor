---
description: Read-only planning workflow for native desktop features. Investigates platform limits, designs architecture, and writes an implementation plan without changing product code.
---

# Think Workflow

## Goal

Understand the request, inspect the current codebase, and produce a plan grounded in macOS platform reality.

## Phase 0: Setup Analysis Workspace

1. Create a timestamped directory in `.orchestrator/plans/`.
2. Create `status.md` with `Investigation`, `Design`, `Plan`, and `Implementation`.

## Phase 1: Investigation

### Mandatory Scan

1. Read `docs/` if it exists, plus `.agent/contexts/project-domain.md`.
2. Detect native project shape:
   - `*.xcodeproj`
   - `*.xcworkspace`
   - `Package.swift`
3. Map folders and current modules.
4. Identify existing code for:
   - Bluetooth discovery
   - battery state
   - menu bar shell
   - settings
   - notifications
   - persistence

### Questions To Answer

1. What is being requested?
2. What parts of the app are affected?
3. What does the current code already support?
4. Which states are uncertain or unsupported?
5. What platform or product risks exist?

### Output

Write `investigation.md` covering:

- summary
- current architecture
- relevant files
- capability matrix
- risks
- recommendation

## Phase 2: Design

Read `investigation.md` and write `design.md` with:

- architecture overview
- module boundaries
- device and battery state model
- notification policy
- persistence model
- menu bar and settings UX
- unsupported or degraded states
- testing strategy

## Phase 3: Plan

Read `design.md` and write `plan.md`.

Rules:

- tasks must be atomic
- foundation first, UI later
- every task must include a verification step
- mention docs updates when a platform decision changes

## Global Rules

- Do not edit product code during this workflow.
- Do not hide platform uncertainty.
- Prefer a clean, honest plan over an overconfident one.
