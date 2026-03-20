# Plan: battery-state-foundation

## Foundation

- [x] **Task 1: Crear BatteryState** — `Sources/DeviceAdvisor/Domain/Models/BatteryState.swift`
  - What: modelar bateria conocida, desconocida y no disponible.
  - Verify: `swift test`

- [x] **Task 2: Extender ConnectedBluetoothDevice** — `Sources/DeviceAdvisor/Domain/Models/ConnectedBluetoothDevice.swift`
  - What: asociar el estado de bateria al dispositivo.
  - Verify: `swift test`

## Core

- [x] **Task 3: Crear el contrato del proveedor de bateria** — `Sources/DeviceAdvisor/Platform/Bluetooth/BluetoothBatteryProviding.swift`
  - What: definir la interfaz para resolver bateria por dispositivo.
  - Verify: `swift test`

- [x] **Task 4: Implementar el proveedor base desconocido** — `Sources/DeviceAdvisor/Platform/Bluetooth/UnknownBluetoothBatteryProvider.swift`
  - What: devolver `.unknown` para todos los dispositivos.
  - Verify: `swift test`

- [x] **Task 5: Enriquecer el menu bar view model** — `Sources/DeviceAdvisor/UI/MenuBar/MenuBarViewModel.swift`
  - What: resolver bateria para cada dispositivo cargado.
  - Verify: tests del view model

- [x] **Task 6: Mostrar bateria en la UI** — `Sources/DeviceAdvisor/UI/MenuBar/MenuBarRootView.swift`
  - What: renderizar el estado de bateria junto al dispositivo.
  - Verify: `swift test` y comprobacion manual

- [x] **Task 7: Inyectar el proveedor en la app** — `Sources/DeviceAdvisor/DeviceAdvisorApp.swift`
  - What: conectar el provider por defecto.
  - Verify: `swift test`

## Integration & Polish

- [x] **Task 8: Actualizar tests del menu bar view model** — `Tests/DeviceAdvisorTests/MenuBarViewModelTests.swift`
  - What: cubrir estados de bateria conocidos y desconocidos.
  - Verify: `swift test`
