# Project Domain Context

## Project Name

Device Advisor

## Product Summary

Aplicacion nativa para macOS que monitoriza dispositivos Bluetooth conectados, intenta obtener su nivel de bateria y envia notificaciones locales cuando bajan de un umbral configurable.

## Current Product Decisions

- Plataforma inicial: `macOS 14+`
- Vision futura: `Windows`, sin implementacion inicial
- Distribucion: uso personal, fuera de App Store
- App shell: `menu bar app`
- Ventanas: `settings window` minima
- Arranque: login at startup
- Persistencia: `UserDefaults`

## Core Capabilities

1. Detectar dispositivos Bluetooth conectados.
2. Intentar leer su bateria por las vias que la plataforma permita.
3. Mostrar estados claros:
   - bateria conocida
   - bateria desconocida
   - dispositivo conectado pero sin soporte de bateria visible
4. Lanzar notificaciones locales cuando el nivel baje del umbral global.
5. Permitir configuracion simple desde ajustes.

## Product Constraint That Must Never Be Hidden

No todos los dispositivos Bluetooth exponen bateria de forma accesible o estandar. El producto debe intentar detectar todos los dispositivos conectados, pero nunca inventar porcentajes ni prometer cobertura universal.

## Target Device Scope

- Objetivo UX: todos los dispositivos Bluetooth conectados que el sistema pueda observar
- Objetivo tecnico: combinar rutas estandar y adaptadores por proveedor o tipo de dispositivo cuando merezca la pena
- Fuera de alcance por ahora:
  - dispositivos no conectados
  - historico complejo
  - sincronizacion en la nube
  - cuenta de usuario

## Main User Flows

1. El usuario abre la app desde la barra de menu.
2. Ve la lista de dispositivos detectados y el estado de bateria o disponibilidad.
3. Ajusta el umbral global de bateria baja.
4. Activa arranque al iniciar sesion.
5. Recibe una notificacion local cuando un dispositivo conectado baja del umbral.

## Key Business Rules

1. Nunca enviar una notificacion basada en un valor de bateria inventado.
2. Nunca tratar `unknown battery` como `0%`.
3. No notificar repetidamente sin una politica clara de deduplicacion o enfriamiento.
4. Los dispositivos conectados deben seguir visibles aunque la bateria no sea legible.
5. La UI debe explicar claramente cuando el sistema no puede leer la bateria de un dispositivo.

## Key Technical Decisions

- UI principal en `SwiftUI`
- Interoperabilidad con `AppKit` si alguna API o flujo del sistema lo necesita
- Integraciones de sistema aisladas detras de protocolos y adaptadores
- Persistencia ligera en `UserDefaults`
- Notificaciones locales del sistema

## Planned Architecture Direction

- `App/UI`: menu bar, settings, presentacion
- `Domain`: modelos de dispositivo, estado de bateria, reglas de notificacion
- `Platform`: Bluetooth, observacion del sistema, login item, notificaciones
- `Infrastructure`: almacenamiento local y utilidades

## Risks To Keep Visible

- Cobertura irregular entre marcas y tipos de dispositivo
- Diferencias entre bateria real, cacheada o no disponible
- Dependencia de APIs de sistema y posibles limitaciones no documentadas
- Riesgo de ruido si la politica de notificaciones no tiene cooldown
