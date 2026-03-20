---
name: testing-patterns
description: Testing patterns for Swift native apps. Covers XCTest or Swift Testing, fake adapters, domain-rule verification, and TDD workflow.
---

# Testing Patterns

## Philosophy

- Write the failing test first when practical.
- Test behavior, not implementation trivia.
- Prioritize domain rules over framework glue.

## What To Test First

1. Battery state mapping
2. Threshold crossing behavior
3. Notification deduplication
4. Settings persistence behavior
5. UI rendering of `known`, `unknown`, and `unsupported` states

## Preferred Test Structure

- Pure domain tests first
- Service tests with fake adapters second
- UI tests only for important user-visible flows

## Fake Pattern

Use lightweight fakes for:

- Bluetooth discovery
- battery readers
- notification centers
- settings stores

Example shape:

```swift
protocol BatteryProviding {
    func batteryLevel(for deviceID: String) async -> BatteryState
}

final class FakeBatteryProvider: BatteryProviding {
    var values: [String: BatteryState] = [:]

    func batteryLevel(for deviceID: String) async -> BatteryState {
        values[deviceID] ?? .unknown
    }
}
```

## Test Naming

- `test_notifiesWhenBatteryDropsBelowThreshold`
- `test_doesNotNotifyWhenBatteryIsUnknown`
- `test_keepsConnectedDeviceVisibleWhenBatteryIsUnavailable`

## Verification Commands

```bash
# Swift package
swift test

# Xcode project
xcodebuild test -scheme <Scheme> -destination 'platform=macOS'
```

## Anti-Patterns

- asserting framework internals instead of behavior
- using real Bluetooth hardware as the default test path
- tests that treat unknown battery as a failure unless the spec says so
