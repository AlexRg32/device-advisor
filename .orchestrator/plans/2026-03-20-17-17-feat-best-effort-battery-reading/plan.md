# Plan: best-effort-battery-reading

## Foundation

- [x] **Task 1: Cambiar el contrato del proveedor de bateria** — `Sources/DeviceAdvisor/Platform/Bluetooth/BluetoothBatteryProviding.swift`
  - What: resolver estados en lote para evitar una invocacion de sistema por dispositivo.
  - Verify: `swift test`

## Core

- [x] **Task 2: Implementar el provider de system_profiler** — `Sources/DeviceAdvisor/Platform/Bluetooth/SystemProfilerBluetoothBatteryProvider.swift`
  - What: cargar y parsear el JSON del sistema.
  - Verify: tests del provider

- [x] **Task 3: Adaptar el provider desconocido** — `Sources/DeviceAdvisor/Platform/Bluetooth/UnknownBluetoothBatteryProvider.swift`
  - What: actualizarlo a la nueva interfaz.
  - Verify: `swift test`

- [x] **Task 4: Adaptar MenuBarViewModel** — `Sources/DeviceAdvisor/UI/MenuBar/MenuBarViewModel.swift`
  - What: enriquecer dispositivos con estados en lote.
  - Verify: tests del view model

- [x] **Task 5: Inyectar el provider real** — `Sources/DeviceAdvisor/DeviceAdvisorApp.swift`
  - What: usar el provider de `system_profiler` por defecto.
  - Verify: `swift test`

## Integration & Polish

- [x] **Task 6: Anadir tests del provider** — `Tests/DeviceAdvisorTests/SystemProfilerBluetoothBatteryProviderTests.swift`
  - What: cubrir known, unknown y unavailable.
  - Verify: `swift test`

- [x] **Task 7: Ajustar tests del menu** — `Tests/DeviceAdvisorTests/MenuBarViewModelTests.swift`
  - What: adaptarlos al nuevo contrato en lote.
  - Verify: `swift test`
