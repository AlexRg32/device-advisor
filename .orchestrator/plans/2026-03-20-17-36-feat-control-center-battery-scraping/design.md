# Design: control-center-battery-scraping

- Anadir un provider de ultimo recurso que lea porcentajes desde la UI accesible de `ControlCenter`.
- Mapear filas por `AXIdentifier` para usar la direccion Bluetooth como clave estable.
- Priorizar este provider por delante de los providers publicos ya existentes.
- Mantener el comportamiento conservador:
  - porcentaje visible -> `known`
  - fila visible sin porcentaje -> `unavailable`
  - ausencia de fila -> `unknown`
