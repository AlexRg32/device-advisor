# Investigation: hidutil-battery-provider

- `system_profiler SPBluetoothDataType` no expone porcentajes de bateria para los 3 dispositivos conectados.
- `CoreBluetooth` Battery Service tampoco devuelve porcentaje para estos dispositivos concretos.
- `hidutil list` si reconoce los dos BLE (`AULA-F75 5.0 KB` y `MX Master 3S M`).
- `hidutil property --get BatteryPercent` devuelve una propiedad conocida pero con valor `(null)` en esos dos BLE.
- Para `WH-1000XM5`, ni `hidutil` ni una prueba directa con `IOBluetoothHandsFreeDevice` han dado un indicador utilizable.
