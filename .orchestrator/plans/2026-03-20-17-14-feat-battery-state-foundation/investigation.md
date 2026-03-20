# Investigation: base de estado de bateria

## Summary

La app ya lista dispositivos conectados, pero aun no representa bateria. Antes de intentar lectura real, conviene introducir el modelo de dominio y una capa de proveedor que permita mostrar estados honestos sin inventar porcentajes.

## Current State

- se listan dispositivos conectados
- no existe `BatteryState`
- no hay proveedor de bateria
- `system_profiler` e `IOBluetooth` no muestran una ruta obvia y universal de porcentaje para todos los dispositivos conectados

## Recommendation

Anadir:

- `BatteryState`
- proveedor de bateria desacoplado
- proveedor por defecto que devuelva `unknown`
- UI del menu mostrando el estado por dispositivo

Esto deja la app preparada para futuras lecturas reales sin mezclar heuristicas todavia.
