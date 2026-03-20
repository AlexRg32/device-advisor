# Design: best effort battery reading

## Architecture

- cambiar `BluetoothBatteryProviding` para resolver estados en lote
- implementar `SystemProfilerBluetoothBatteryProvider`
- parsear el JSON del sistema y asociar estados por direccion Bluetooth
- mantener el fallback a `unknown`

## Parsing Rules

- si se encuentra un porcentaje claro `0...100`, usar `.known`
- si hay claves de bateria pero sin porcentaje interpretable, usar `.unavailable`
- si no hay claves relacionadas con bateria, usar `.unknown`
- no convertir escalas `0...5` a porcentaje, porque seria inventar datos

## Testing Strategy

- test de parseo con porcentaje real
- test sin campos de bateria
- test con clave de bateria no interpretable
