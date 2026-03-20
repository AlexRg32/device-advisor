# Investigation: control-center-battery-scraping

- `system_profiler`, `CoreBluetooth`, `hidutil` y `IOBluetoothHandsFreeDevice` no devolvian porcentaje utilizable para los 3 dispositivos conectados.
- El proceso `ControlCenter` si expone su UI por Accessibility en esta maquina.
- Dentro del panel principal, el modulo Bluetooth tiene identificador `controlcenter-bluetooth`.
- La accion personalizada `mostrar detalles` abre una vista con filas `bluetooth-device-<MAC>`.
- En esa vista, los dispositivos conectados exponen el porcentaje como texto accesible (`84 %`, `45 %`, `40 %`).
