# General Project Development Rules

Global constraints for all agents working on this project.

## 1. Project Domain

Read `contexts/project-domain.md` first.
Never assume Bluetooth support, battery availability, or product rules without checking the project context.

## 2. Project Management

- MANDATORY: create a directory in `.orchestrator/plans/YYYY-MM-DD-hh-mm-slug/` for any substantial task.
- MANDATORY: follow the 4-phase lifecycle: Investigation, Design, Plan, Implement.
- AUTOPILOT: proceed through the lifecycle unless a real blocker appears.
- MANDATORY: document platform limitations and unsupported states in plan artifacts.
- MANDATORY: update relevant docs after implementation.
- LOGGING: major decisions must be written down.

## 3. Git

- Use Conventional Commits.
- No automatic commits or pushes in implementation workflows.
- Only `/ship` and `/pr` are allowed to touch commit or push flows.

## 4. Technology Stack

- PLATFORM: `macOS 14+`
- LANGUAGE: `Swift`
- UI: `SwiftUI`, with `AppKit` only when needed
- SYSTEM INTEGRATIONS: Bluetooth, notifications, login item, local persistence
- STORAGE: `UserDefaults` by default
- TESTS: `XCTest` or `Swift Testing`

## 5. Architecture

- Separate `UI`, `Domain`, `Platform`, and `Infrastructure`.
- Keep OS-specific integrations behind protocols or adapter types.
- Do not couple battery parsing logic to views.
- No remote backend is assumed.
- Preserve seams for a future Windows implementation without distorting the macOS-first design.

## 6. Product Truthfulness

- Never claim support for every Bluetooth device.
- Never invent battery values.
- `unknown`, `unavailable`, and `unsupported` are distinct states and must remain distinct in code and UI.
- Notifications must be deduplicated or rate-limited by policy.

## 7. User Experience

- The primary experience is the menu bar.
- A settings window is part of the core product, not an afterthought.
- Design for desktop glanceability, not mobile-first layouts.
- Destructive actions still require confirmation.
