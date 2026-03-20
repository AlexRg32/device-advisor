# Design: apertura de ajustes desde menu bar

## Approach

- extender `AppActivationServicing` con `openSettings()`
- implementar la apertura via `NSApp.sendAction`
- exponer `openSettings()` en `MenuBarViewModel`
- hacer que `MenuBarRootView` delegue en el view model

## Verification

- `swift test`
- comprobacion manual: el boton `Abrir ajustes` abre la ventana de ajustes desde el menu bar
