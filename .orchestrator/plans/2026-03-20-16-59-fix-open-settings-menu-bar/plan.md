# Plan: fix-open-settings-menu-bar

## Core

- [x] **Task 1: Extender el servicio de activacion** — `Sources/DeviceAdvisor/Platform/System/AppActivationService.swift`
  - What: anadir una API para abrir ajustes y activar la app.
  - Verify: `swift test`

- [x] **Task 2: Conectar el view model del menu bar** — `Sources/DeviceAdvisor/UI/MenuBar/MenuBarViewModel.swift`
  - What: exponer una accion `openSettings()`.
  - Verify: `swift test`

- [x] **Task 3: Sustituir el uso de environment en la vista** — `Sources/DeviceAdvisor/UI/MenuBar/MenuBarRootView.swift`
  - What: dejar de depender de `openSettings` y delegar en el view model.
  - Verify: `swift test` y comprobacion manual
