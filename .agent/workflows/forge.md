---
description: Full-cycle native implementation workflow with planning artifacts, checkpoints, and build verification.
---

# Forge Workflow

## Goal

Move from request to implementation for a native macOS feature while preserving architecture, docs, and build health.

## Phase 0: Setup Workspace & Branch

### Scenario A: Execute or Resume a Plan

If the user asks to execute or resume:

1. Locate the latest plan in `.orchestrator/plans/` unless a path is provided.
2. If on `main`, create a feature branch.
3. Resume from the next incomplete task.

### Scenario B: New Feature

If the user gives a fresh request:

1. Create a feature branch if currently on `main`.
2. Create a timestamped plan directory in `.orchestrator/plans/`.
3. Create `status.md`.
4. Run Investigation, Design, and Plan before code changes.

## Phase 1: Investigation

1. Read existing docs and context files.
2. Detect project type from `xcodeproj`, `xcworkspace`, or `Package.swift`.
3. Inspect relevant code paths for Bluetooth, battery, notifications, menu bar, settings, and persistence.
4. Produce `investigation.md`.

## Phase 2: Design

Produce `design.md` with:

- module boundaries
- domain model for device and battery state
- platform adapters
- notification policy
- settings model
- UX states for known, unknown, and unsupported battery
- testing plan

## Phase 3: Plan

Produce `plan.md` with atomic tasks.

## Phase 4: Implementation

### Execution Rules

- Implement tasks in dependency order.
- Keep platform code and UI code separated.
- Update docs when architecture or behavior changes.
- Mark completed tasks in `plan.md`.
- Track progress in `implementation.md`.

### Verification

Use the native command that matches the project:

```bash
# Swift package
swift test

# Xcode project
xcodebuild test -scheme <Scheme> -destination 'platform=macOS'
```

If tests are not available yet, at minimum run a build and note the gap.

## Recovery & Resume

When resuming:

1. Read `status.md`, `plan.md`, and `implementation.md` if present.
2. Continue from the first unchecked task.
3. Re-run the most relevant build or test command before declaring progress complete.

## Global Rules

- Do not commit or push automatically.
- Never blur `unknown` and `zero battery`.
- Never implement a UI that implies universal device support without evidence in code.
