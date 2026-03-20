# Investigation: best effort battery reading

## Summary

Necesitamos una primera lectura real de bateria sin inventar porcentajes. La ruta elegida es `system_profiler SPBluetoothDataType -json`, porque ya expone el arbol de dispositivos conectados del sistema y puede incluir claves de bateria en algunos casos.

## Current State

- la app ya muestra `BatteryState`
- el provider actual devuelve siempre `.unknown`
- `system_profiler` funciona en este Mac y devuelve la lista de dispositivos conectados
- en la muestra actual no aparecen campos de bateria, asi que el fallback sigue siendo importante

## Recommendation

Crear un provider de bateria basado en `system_profiler` que:

- lea el reporte una sola vez por refresco
- intente extraer porcentajes reales cuando existan
- devuelva `.unknown` si no encuentra un porcentaje fiable
- devuelva `.unavailable` si detecta una clave de bateria sin valor utilizable
