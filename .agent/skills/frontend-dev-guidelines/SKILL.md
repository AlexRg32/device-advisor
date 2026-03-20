---
name: frontend-dev-guidelines
description: Opinionated native UI standards for macOS applications. Covers SwiftUI architecture, menu bar UX, settings windows, accessibility, state handling, and AppKit interop discipline.
---

# Native UI Development Guidelines

Use this skill when working on the app shell, menu bar UI, settings, or presentation logic.

## Core Rules

1. SwiftUI first.
2. AppKit only when a system API or window behavior requires it.
3. Desktop-first UX. Do not design like a mobile or web app.
4. Views stay focused and small.
5. Platform services never live inside views.

## Architecture

- Keep view state explicit.
- Move business logic into view models or domain services.
- Inject services through protocols where practical.
- Prefer feature-oriented folders over giant shared dumping grounds.

## Menu Bar UX

- Optimize for glanceability.
- Primary states must be visible in seconds:
  - device connected
  - battery known
  - battery unknown
  - unsupported or unavailable
- Do not overload the menu bar dropdown with heavy settings.

## Settings Window

The first version should comfortably support:

- low-battery threshold
- launch at login
- notification behavior if implemented
- device list with clear battery availability state

## Copy & Trust

- Use precise language.
- Never imply that every connected device exposes a readable battery.
- Explain unknown states calmly instead of hiding them.

## Accessibility

- Support keyboard navigation where reasonable.
- Respect reduced motion.
- Use clear labels and strong contrast.
- Avoid relying only on color to communicate battery state.

## Anti-Patterns

- giant SwiftUI views with networking or Bluetooth logic inside
- magical state derived in multiple places
- web-style loading spinners everywhere
- hiding unsupported device states to make the UI look cleaner
