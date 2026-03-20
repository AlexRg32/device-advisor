# Investigation: Shell minimo de Device Advisor

## Summary

La primera feature debe crear la base nativa del producto: una menu bar app para macOS 14+ con SwiftUI, una ventana de ajustes vacia y una estructura de modulos preparada para crecer sin mezclar UI con integraciones de sistema. El repositorio no contiene todavia una app, asi que esta tarea define el esqueleto tecnico inicial.

## Current State

- Tech stack detectado: no existe aun app ni proyecto Xcode.
- Archivos relevantes hoy:
  - `.agent/contexts/project-domain.md`
  - `.agent/workflows/think.md`
  - `.agents`
- Arquitectura actual: inexistente a nivel de aplicacion; solo hay sistema de orquestacion y planificacion.
- Documentacion previa: no existe carpeta `docs/`.

## Request

Crear el diseño de la primera feature para:

- menu bar app nativa en macOS 14+
- SwiftUI
- ventana de ajustes vacia
- estructura base de modulos:
  - `UI`
  - `Domain`
  - `Platform`
  - `Infrastructure`
- sin Bluetooth todavia

## Capability Matrix

| Capability | Current state | Notes |
|---|---|---|
| App shell | Missing | No app target yet |
| Menu bar entry | Missing | To be introduced in V1 shell |
| Settings window | Missing | Empty placeholder is enough for first step |
| Domain module | Missing | Should define app-level seams early |
| Platform module | Missing | Must exist before Bluetooth work starts |
| Infrastructure module | Missing | Minimal local utilities only |
| Bluetooth detection | Out of scope for this feature | Explicitly deferred |
| Battery logic | Out of scope for this feature | Explicitly deferred |
| Notifications | Out of scope for this feature | Explicitly deferred |

## Affected Areas

Because no app exists yet, this feature affects foundational decisions:

- project shape
- app lifecycle
- folder and target organization
- navigation entry points
- settings presentation
- dependency boundaries

## Risks

| Risk | Impact | Mitigation |
|---|---|---|
| Starting with an ad-hoc folder layout | Medium | Define module boundaries before adding behavior |
| Building the shell too tightly around current macOS-only needs | Medium | Keep clear protocol seams for future Windows port, without multi-platform implementation now |
| Overengineering before first feature works | Medium | Keep first shell minimal: app, menu bar entry, settings scene, placeholders |
| Accidentally introducing Bluetooth assumptions into the shell | Low | Keep `Platform` present but empty or protocol-first |

## Recommendation

Create a minimal Xcode-based macOS app with a menu bar-first entry point, a placeholder settings scene, and a folder structure aligned with `UI`, `Domain`, `Platform`, and `Infrastructure`. Keep the first pass intentionally small so the next feature can focus on one real behavior at a time: likely persisted settings or local notifications before Bluetooth.

