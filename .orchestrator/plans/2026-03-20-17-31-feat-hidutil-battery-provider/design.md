# Design: hidutil-battery-provider

- Anadir un proveedor `HIDUtilBluetoothBatteryProvider` para consultar `hidutil property` en dispositivos BLE.
- Probar varias claves publicas relacionadas con bateria y priorizar un porcentaje real `0...100`.
- Si `hidutil` expone la propiedad pero devuelve `(null)`, mapear a `BatteryState.unavailable`.
- Mantener `BatteryState.unknown` solo cuando no exista ninguna senal publica utilizable.
- Integrar el provider en el combinador actual sin degradar lecturas existentes.
