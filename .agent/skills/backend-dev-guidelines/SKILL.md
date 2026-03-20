---
name: backend-dev-guidelines
description: Opinionated platform-integration standards for native macOS apps. Covers Bluetooth adapters, battery interpretation, notification policy, local persistence, and testable service boundaries.
---

# Platform Integration Guidelines

Use this skill when working on Bluetooth discovery, battery retrieval, notification scheduling, login item support, or persistence.

## Core Doctrine

1. Treat platform APIs as volatile boundaries.
2. Wrap OS integrations behind protocols or adapter types.
3. Keep domain rules separate from platform callbacks.
4. Unknown battery state is valid and must not be coerced.
5. Prefer local simplicity over premature abstractions for cloud or sync.

## Required Boundaries

- discovery adapter
- battery provider or interpreter
- notification policy service
- settings store
- login item integration

## Battery State Rules

Support explicit states such as:

- known percentage
- unknown
- unavailable on this device
- stale if you implement freshness tracking

Never:

- map unknown to zero
- assume every connected device is readable
- notify from stale data without a documented rule

## Persistence

- Default to `UserDefaults`.
- Store only settings and lightweight cached metadata.
- Keep persistence schemas small and reversible.

## Notifications

- Notification policy must be centralized.
- Deduplicate repeated alerts.
- Keep threshold logic deterministic and testable.

## Testing

- Prefer protocol-driven unit tests with fake adapters.
- Test threshold crossing and deduplication rules.
- Add integration tests for thin wrappers only when the platform surface is stable enough.

## Anti-Patterns

- Bluetooth code directly inside SwiftUI views
- one mega service that discovers, parses, stores, and notifies
- hidden fallbacks that make the app appear more capable than it is
- broad third-party dependencies before validating native APIs
