# Investigation: apertura de ajustes desde menu bar

## Summary

El boton `Abrir ajustes` no hace nada desde el `MenuBarExtra`. La implementacion actual usa `@Environment(\.openSettings)`, que aparentemente no esta resolviendo bien en este contexto.

## Current State

- `MenuBarRootView` llama a `openSettings()`
- `MenuBarViewModel` no participa en la apertura de ajustes
- ya existe un `AppActivationService` en `Platform`

## Recommendation

Mover la apertura de ajustes al servicio de plataforma y usar una llamada explicita de `AppKit` para mostrar la ventana de settings. Esto evita depender de que el environment de SwiftUI este disponible dentro del menu bar.
