# Investigation: listar dispositivos Bluetooth conectados

## Summary

La siguiente feature natural es dejar de mostrar un shell vacio y empezar a renderizar valor real del sistema: los dispositivos Bluetooth conectados en este momento, sin leer bateria todavia.

## Current State

- la app ya tiene:
  - menu bar
  - ajustes
  - persistencia simple
- la UI del menu todavia muestra texto placeholder
- no existe modelo de dispositivo conectado ni proveedor Bluetooth

## Technical Direction

- usar `IOBluetooth`
- partir de `IOBluetoothDevice.pairedDevices()`
- filtrar con `isConnected()`
- mapear a un modelo de dominio pequeño

## Risks

| Risk | Impact | Mitigation |
|---|---|---|
| `pairedDevices()` solo cubre dispositivos emparejados | Medium | comunicar claramente "conectados detectados por el sistema" y seguir ampliando despues |
| UI vacia poco clara cuando no haya dispositivos | Low | mostrar estado vacio explicito |
| mezclar framework Bluetooth con la vista | Medium | aislarlo en `Platform` |

## Recommendation

Crear un proveedor de dispositivos conectados en `Platform`, un modelo de dominio simple y un `MenuBarViewModel` que cargue y refresque la lista.
