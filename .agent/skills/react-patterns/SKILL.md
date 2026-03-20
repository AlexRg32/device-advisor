---
name: react-patterns
description: Historical skill name kept for compatibility. Use for SwiftUI view composition, state ownership, and native UI structuring patterns.
allowed-tools: Read, Write, Edit, Glob, Grep
---

# Native View Composition Patterns

## Core Patterns

- Small views with one responsibility
- Explicit state ownership
- Derived view data kept close to the presenter or view model
- Composition over giant container views

## State Placement

| Scope | Preferred Tool |
|------|-----------------|
| Single view | `@State` |
| Owned reference state | `@StateObject` |
| Injected observable model | `@ObservedObject` or new observation model |
| App-wide environment | `@Environment` sparingly |

## Extraction Rules

Extract a helper type or view model when:

- a view exceeds a comfortable reading size
- async work clouds rendering logic
- battery and notification rules start leaking into the UI

## Error Handling

- Surface clear, calm error or unavailable states.
- Prefer dedicated empty or unsupported views over generic alerts.

## Anti-Patterns

- view files that own Bluetooth scanning directly
- hidden side effects inside `body`
- overusing global state for local presentation concerns
