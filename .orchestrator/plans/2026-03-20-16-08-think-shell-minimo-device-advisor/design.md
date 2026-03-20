# Design: Shell minimo de Device Advisor

## Architecture Overview

La aplicacion debe arrancar como utilidad nativa de macOS con foco en barra de menu. Esta primera feature no implementa comportamiento de negocio real; solo define el cascaron estable sobre el que luego colgaremos ajustes, notificaciones y Bluetooth.

Arquitectura objetivo:

- `UI`: escenas, vistas, view models de presentacion
- `Domain`: modelos y contratos de negocio puros
- `Platform`: adaptadores a APIs del sistema
- `Infrastructure`: persistencia ligera y utilidades

## Project Shape

Recomendacion:

- Proyecto Xcode nativo para macOS 14+
- App principal en SwiftUI
- Un target de app es suficiente en esta fase
- Test target desde el inicio aunque tenga cobertura minima

## Proposed File Structure

```text
DeviceAdvisor/
├── DeviceAdvisorApp.swift
├── UI/
│   ├── MenuBar/
│   │   ├── MenuBarRootView.swift
│   │   └── MenuBarViewModel.swift
│   ├── Settings/
│   │   ├── SettingsView.swift
│   │   └── SettingsViewModel.swift
│   └── Shared/
│       └── AppTheme.swift
├── Domain/
│   ├── Models/
│   │   └── AppShellState.swift
│   └── Contracts/
│       └── AppSettingsStore.swift
├── Platform/
│   └── System/
│       └── AppActivationService.swift
├── Infrastructure/
│   └── Persistence/
│       └── UserDefaultsSettingsStore.swift
└── Tests/
    └── DeviceAdvisorTests/
```

## Scene Design

### Menu Bar Scene

- Debe ser la entrada principal.
- En esta primera version solo necesita:
  - nombre de la app
  - estado placeholder como "Sin monitorizacion activa aun"
  - accion para abrir ajustes
  - accion para salir

### Settings Scene

- Ventana vacia pero real.
- Debe incluir:
  - titulo de ajustes
  - texto placeholder explicando que aqui iran umbral, inicio de sesion y preferencias

## Domain Design

Aunque aun no exista logica real, conviene definir un estado de shell simple:

- `AppShellState`
  - `idle`
  - `bootstrapping`

Y un contrato inicial:

- `AppSettingsStore`
  - interfaz vacia o con una operacion minima de carga de preferencias

Esto prepara la inyeccion de dependencias sin meter Bluetooth demasiado pronto.

## Platform Layer

En esta fase `Platform` no debe escanear nada. Solo puede incluir utilidades del ciclo de vida o activacion de app si hacen falta para el menu bar o la ventana de ajustes.

## Infrastructure Layer

`Infrastructure` debe contener la implementacion concreta de persistencia ligera. Aunque la ventana de ajustes este vacia, dejar `UserDefaultsSettingsStore` preparado evita meter `UserDefaults` directamente en la UI despues.

## UX Notes

- Desktop-first y compacta.
- Nada de layouts tipo dashboard web.
- El menu de barra debe sentirse instantaneo y limpio.
- La ventana de ajustes puede ser minima, pero debe existir ya como escena real.

## Out of Scope

- Bluetooth
- bateria
- notificaciones
- login at startup
- permisos
- historico

## Testing Strategy

- test de arranque minimo del shell si el proyecto lo permite
- test unitario simple del settings store o del view model de ajustes
- validacion principal en esta fase: el proyecto compila y abre menu bar + settings

