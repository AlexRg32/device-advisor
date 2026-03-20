# Plan: listar dispositivos Bluetooth conectados

## Foundation

- [x] **Task 1: Crear el modelo de dominio** — `Sources/DeviceAdvisor/Domain/Models/ConnectedBluetoothDevice.swift`
  - What: representar un dispositivo conectado con id, nombre y direccion.
  - Verify: `swift test`

- [x] **Task 2: Crear el contrato del proveedor** — `Sources/DeviceAdvisor/Platform/Bluetooth/ConnectedBluetoothDevicesProviding.swift`
  - What: definir la interfaz para obtener los dispositivos conectados.
  - Verify: `swift test`

## Core

- [x] **Task 3: Implementar el proveedor de IOBluetooth** — `Sources/DeviceAdvisor/Platform/Bluetooth/IOBluetoothConnectedDevicesProvider.swift`
  - What: leer dispositivos emparejados y filtrar los conectados.
  - Verify: `swift test`

- [x] **Task 4: Extender el menu bar view model** — `Sources/DeviceAdvisor/UI/MenuBar/MenuBarViewModel.swift`
  - What: cargar, refrescar y exponer la lista para la UI.
  - Verify: tests del view model

- [x] **Task 5: Renderizar la lista en el menu** — `Sources/DeviceAdvisor/UI/MenuBar/MenuBarRootView.swift`
  - What: sustituir el placeholder por dispositivos o estado vacio, con boton de actualizar.
  - Verify: `swift test` y comprobacion manual

- [x] **Task 6: Inyectar el proveedor en la app** — `Sources/DeviceAdvisor/DeviceAdvisorApp.swift`
  - What: conectar el proveedor real al view model.
  - Verify: `swift test`

## Integration & Polish

- [x] **Task 7: Anadir tests del menu bar view model** — `Tests/DeviceAdvisorTests/MenuBarViewModelTests.swift`
  - What: cubrir lista cargada y estado vacio con un provider fake.
  - Verify: `swift test`

- [x] **Task 8: Actualizar README** — `README.md`
  - What: reflejar que la app ya lista dispositivos conectados.
  - Verify: la documentacion describe el estado actual del producto
