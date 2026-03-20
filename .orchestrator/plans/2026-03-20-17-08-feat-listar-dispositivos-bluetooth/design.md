# Design: listar dispositivos Bluetooth conectados

## Goal

Mostrar en el menu bar los dispositivos Bluetooth conectados detectados por el sistema, sin bateria ni notificaciones todavia.

## Architecture

- `Domain/Models/ConnectedBluetoothDevice.swift`
- `Platform/Bluetooth/ConnectedBluetoothDevicesProviding.swift`
- `Platform/Bluetooth/IOBluetoothConnectedDevicesProvider.swift`
- `UI/MenuBar/MenuBarViewModel.swift`
- `UI/MenuBar/MenuBarRootView.swift`

## UI Behavior

- al abrir el menu, cargar o refrescar la lista
- si hay dispositivos:
  - mostrar cada uno por nombre
  - mostrar direccion si hace falta para distinguir
- si no hay dispositivos:
  - mostrar estado vacio claro
- incluir boton `Actualizar`

## Testing Strategy

- test del view model con provider fake
- mantener `swift test` en verde
