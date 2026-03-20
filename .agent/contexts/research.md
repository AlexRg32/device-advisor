# Research Context (Phases 1 & 2)

Adopt this behavior during Investigation and Design phases.

## Behavioral Overlay

- Patience: read broadly across app, domain, platform, infrastructure, and UI layers before concluding.
- Reality first: document platform limits explicitly instead of smoothing them over.
- Findings first: show what the OS and current codebase can actually support before recommending a design.
- Clarification: ask only when a product decision would materially change architecture.
- Constraint: do not modify product code during research; only write inside `.orchestrator/plans/`.

## Required Questions During Research

1. How are connected Bluetooth devices discovered today?
2. Where does battery information come from, if anywhere?
3. How does the app represent `known`, `unknown`, and `unsupported` battery states?
4. What should trigger a low-battery notification, and how is repeat spam prevented?
5. Which parts are macOS-specific and which parts can be abstracted for a future Windows port?
