# Plan: control-center-battery-scraping

1. Confirmar el flujo Accessibility para abrir el detalle Bluetooth del `ControlCenter`.
2. Implementar un provider que extraiga las filas `bluetooth-device-<MAC>`.
3. Parsear porcentajes y mapearlos a `BatteryState`.
4. Integrarlo en la cadena de providers y validar con tests.
