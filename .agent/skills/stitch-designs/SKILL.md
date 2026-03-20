---
name: stitch-designs
description: Expert guidance on generating native desktop UI concepts and translating them into SwiftUI-first macOS screens.
---

# Native Desktop Design Expert

Use this skill during the design phase when exploring menu bar and settings UI directions.

## Prompting Principles

- Always describe the app as a native macOS utility.
- Specify whether the target is:
  - menu bar dropdown
  - settings window
  - onboarding or permissions prompt
- Include the key truth of the product: some devices may not expose battery.

## Visual Goals

- Calm, trustworthy, utility-first
- Fast to scan
- Clear state labels over decorative noise
- Native-feeling spacing and hierarchy

## Handoff Rule

Generated layouts are references. The final implementation must be translated into small SwiftUI views, with AppKit only where needed.

## Anti-Patterns

- web-dashboard layouts for a menu bar utility
- giant card grids when the user only needs a quick device status glance
- copy that implies guaranteed support for every Bluetooth device
