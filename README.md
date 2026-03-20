# Device Advisor

Shell minimo de una app nativa para macOS 14+ construida con SwiftUI.

## Objetivo de esta primera feature

- crear el cascaron de menu bar
- crear una ventana de ajustes real, aunque todavia minima
- fijar la arquitectura base del proyecto
- dejar preparada la persistencia local inicial
- permitir editar el umbral global desde ajustes

## Arquitectura inicial

- `UI`: vistas y view models de presentacion
- `Domain`: modelos y contratos puros
- `Platform`: integraciones con APIs del sistema
- `Infrastructure`: implementaciones concretas como `UserDefaults`

## Lo que aun no entra

- Bluetooth
- bateria
- notificaciones
- login at startup

## Verificacion

```bash
swift test
```

Xcode puede abrir el paquete directamente para iterar sobre la app nativa mientras el proyecto sigue siendo ligero.
