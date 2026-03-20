---
name: premium-animations
description: Motion guidelines for native macOS apps. Covers subtle SwiftUI transitions, purposeful feedback, and reduced-motion-friendly interaction design.
---

# Native Motion Guidelines

## Principles

1. Motion must communicate state, not decorate emptiness.
2. Keep menu bar interactions quick and restrained.
3. Prefer opacity, scale, and small movement over theatrical transitions.
4. Respect reduced motion.

## Good Uses

- row updates when battery changes
- subtle emphasis when a device crosses the threshold
- smooth presentation of settings sections

## Avoid

- oversized spring animations in compact menu bar UIs
- long entrance sequences before core information is visible
- motion that makes unsupported states feel like errors
