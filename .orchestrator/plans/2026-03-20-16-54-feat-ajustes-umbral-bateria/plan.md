# Plan: Ajustes del umbral de bateria

> Goal: hacer editable y persistente el umbral global desde ajustes
> Architecture: UI en SwiftUI, persistencia a traves de `SettingsViewModel` y `AppSettingsStore`

## Foundation

- [x] **Task 1: Extender el view model de ajustes** — `Sources/DeviceAdvisor/UI/Settings/SettingsViewModel.swift`
  - What: anadir una API para actualizar el umbral, acotarlo y guardarlo.
  - Verify: `swift test`

## Core

- [x] **Task 2: Hacer editable la UI de ajustes** — `Sources/DeviceAdvisor/UI/Settings/SettingsView.swift`
  - What: sustituir el placeholder por un control nativo simple para editar el porcentaje.
  - Verify: `swift test` y comprobacion manual de la ventana de ajustes.

- [x] **Task 3: Anadir tests del view model** — `Tests/DeviceAdvisorTests/SettingsViewModelTests.swift`
  - What: cubrir carga inicial, persistencia y acotado.
  - Verify: `swift test`

## Integration & Polish

- [x] **Task 4: Actualizar la documentacion minima** — `README.md`
  - What: reflejar que el umbral ya puede editarse desde la UI.
  - Verify: el README describe el estado actual del shell.
