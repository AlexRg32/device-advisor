# Device Advisor

App nativa para macOS 14+ construida con SwiftUI para detectar dispositivos Bluetooth conectados y vigilar su bateria.

## Objetivo de esta primera feature

- crear el cascaron de menu bar
- crear una ventana de ajustes real, aunque todavia minima
- fijar la arquitectura base del proyecto
- dejar preparada la persistencia local inicial
- permitir editar el umbral global desde ajustes
- listar dispositivos Bluetooth conectados detectados por el sistema
- intentar resolver bateria con varias rutas publicas y best effort

## Arquitectura inicial

- `UI`: vistas y view models de presentacion
- `Domain`: modelos y contratos puros
- `Platform`: integraciones con APIs del sistema
- `Infrastructure`: implementaciones concretas como `UserDefaults`

## Lo que aun no entra

- notificaciones
- login at startup

## Verificacion

```bash
swift test
xcodebuild -project DeviceAdvisor.xcodeproj -scheme DeviceAdvisor -destination 'platform=macOS' test
```

## Abrir la app real en Xcode

Genera el proyecto Xcode con:

```bash
ruby scripts/generate_xcodeproj.rb
open DeviceAdvisor.xcodeproj
```

El proyecto Xcode genera una `.app` real, que es la base necesaria para permisos como Accesibilidad, notificaciones y login item.

`Package.swift` se mantiene para conservar `swift test` como validacion rapida y ligera.

Si anades o mueves archivos fuente, vuelve a ejecutar `ruby scripts/generate_xcodeproj.rb` para regenerar el proyecto.
