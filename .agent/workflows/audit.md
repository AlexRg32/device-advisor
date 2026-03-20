---
description: Read-only audit for native desktop architecture, platform realism, permissions, and quality risks.
---

# Audit Workflow

## Goal

Scan the project for technical debt, architecture drift, and misleading assumptions about Bluetooth battery support.

## Phase 0: Setup Audit Workspace

1. Create a timestamped directory in `.orchestrator/audits/`.
2. Create `status.md` with:
   - guidelines check
   - platform realism
   - architecture scan
   - final report

## Phase 1: Guidelines Compliance

Use:

- `frontend-dev-guidelines`
- `backend-dev-guidelines`
- `clean-code`

Check whether the project:

- separates UI from platform logic
- models unknown battery states correctly
- keeps menu bar UX lightweight and clear
- avoids misleading copy or fake fallback values

Write `1-guidelines-findings.md`.

## Phase 2: Platform Realism & Permissions

Inspect:

- entitlements
- notification setup
- login item setup
- Bluetooth access assumptions
- any hardcoded claims about supported devices

Write `2-platform-findings.md`.

## Phase 3: Architecture & Performance

Review:

- module boundaries
- adapter seams
- persistence choices
- notification deduplication
- repeated scans, timers, or state churn that could waste resources

Write `3-architecture-findings.md`.

## Phase 4: Final Report

Create `audit-report.md` with:

- executive summary
- prioritized findings
- recommended next steps

## Rules

- strictly read-only, except `.orchestrator/audits/`
- no git mutations
- findings must point to concrete files and risks
