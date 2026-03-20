# Implementation Log: hidutil-battery-provider

Started: 2026-03-20T17:31:00+01:00

## Task Progress

- `HIDUtilBluetoothBatteryProvider` anadido para consultar propiedades publicas de bateria de dispositivos BLE con `hidutil`.
- Reglas de parseo:
  - porcentaje `0...100` -> `known`
  - propiedad presente con `(null)` -> `unavailable`
  - sin salida util -> `unknown`
- Provider integrado en la cadena de bateria de la app.
- Tests del provider anadidos.

## Verification

- `swift test` ✅

## Summary

- Completed: 4 tasks
- Build/Test: PASS
- Finished: 2026-03-20T17:31:00+01:00
