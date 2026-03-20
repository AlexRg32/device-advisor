# Plan: Shell minimo de Device Advisor

> Goal: crear la base nativa de la app con menu bar, ajustes vacios y estructura modular preparada para crecer
> Architecture: SwiftUI macOS app con capas UI, Domain, Platform e Infrastructure

## Foundation

- [x] **Task 1: Crear el proyecto base de macOS** — `Package.swift`, target de app, test target`
  - What: crear una app nativa para macOS 14+ con SwiftUI como punto de entrada.
  - Verify: `swift test`

- [x] **Task 2: Definir la estructura de carpetas base** — `UI/`, `Domain/`, `Platform/`, `Infrastructure/`
  - What: crear la estructura de modulos inicial dentro del target sin añadir todavia Bluetooth ni notificaciones.
  - Verify: `swift test`

- [x] **Task 3: Añadir el estado de shell del dominio** — `Domain/Models/AppShellState.swift`
  - What: crear un modelo minimo para representar el estado general del shell.
  - Verify: `swift test`

- [x] **Task 4: Añadir el contrato inicial de ajustes** — `Domain/Contracts/AppSettingsStore.swift`
  - What: definir el protocolo base para la futura persistencia de ajustes.
  - Verify: `swift test`

## Core

- [x] **Task 5: Implementar el store minimo de UserDefaults** — `Infrastructure/Persistence/UserDefaultsSettingsStore.swift`
  - What: crear una implementacion minima del contrato de ajustes, aunque solo exponga carga o valores placeholder.
  - Verify: `swift test`

- [x] **Task 6: Crear el menu bar shell** — `UI/MenuBar/MenuBarRootView.swift`, `DeviceAdvisorApp.swift`
  - What: configurar la app para abrirse desde la barra de menu con una vista compacta y placeholder.
  - Verify: `swift test`

- [x] **Task 7: Crear el view model del menu bar** — `UI/MenuBar/MenuBarViewModel.swift`
  - What: mover el estado de presentacion del menu bar fuera de la vista, aunque sea minimo.
  - Verify: `swift test`

- [x] **Task 8: Crear la ventana de ajustes vacia** — `UI/Settings/SettingsView.swift`
  - What: añadir una escena de ajustes real con contenido placeholder.
  - Verify: `swift test`

- [x] **Task 9: Crear el view model de ajustes** — `UI/Settings/SettingsViewModel.swift`
  - What: preparar la capa de presentacion para ajustes futuros sin meter aun preferencias complejas.
  - Verify: `swift test`

## Integration & Polish

- [x] **Task 10: Añadir utilidades de plataforma minimas** — `Platform/System/AppActivationService.swift`
  - What: crear un wrapper minimo solo si hace falta para foco, apertura o activacion de ventanas en macOS.
  - Verify: `swift test`

- [x] **Task 11: Revisar el flujo de escenas y salida** — `DeviceAdvisorApp.swift`, `UI/MenuBar/MenuBarRootView.swift`
  - What: asegurar que el menu bar ofrece al menos abrir ajustes y salir de la app.
  - Verify: `swift test`

- [x] **Task 12: Documentar la arquitectura inicial** — `README.md`
  - What: documentar por que existe la separacion `UI / Domain / Platform / Infrastructure` y que Bluetooth queda fuera de esta primera feature.
  - Verify: `README.md` describe la estructura actual y el siguiente paso natural del producto.
