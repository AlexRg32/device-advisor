# Design: base de estado de bateria

## Goal

Representar y mostrar bateria por dispositivo con estados honestos:

- conocida
- desconocida
- no disponible

## Architecture

- `Domain/Models/BatteryState.swift`
- `Platform/Bluetooth/BluetoothBatteryProviding.swift`
- `Platform/Bluetooth/UnknownBluetoothBatteryProvider.swift`
- `MenuBarViewModel` enriqueciendo la lista con estado de bateria
- `MenuBarRootView` mostrando el estado

## First Implementation

- proveedor por defecto devuelve `.unknown`
- no se intenta porcentaje real todavia
- la UI muestra `Bateria desconocida`

## Testing Strategy

- tests del view model con provider fake para:
  - bateria conocida
  - bateria desconocida
  - bateria no disponible
