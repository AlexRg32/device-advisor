# Manual del Sistema de IA (macOS Native Stack)

Este sistema de orquestacion funciona como un equipo tecnico para una app nativa de macOS centrada en:

- detectar dispositivos Bluetooth conectados
- leer o inferir su nivel de bateria cuando el sistema lo permita
- avisar con notificaciones cuando bajen de un umbral

La estrategia actual es `macOS first`, con una arquitectura pensada para extenderse a Windows mas adelante sin forzar hoy decisiones prematuras.

Politica operativa del proyecto:

- El archivo raiz `.agents` refuerza que este proyecto debe trabajarse siempre siguiendo los workflows definidos en `.agent`.

## 1. El Equipo

- `@architect`: diseña la arquitectura, los limites de plataforma y la estrategia de deteccion de bateria.
- `@doc-planner`: convierte ideas en planes ejecutables y mantiene la documentacion tecnica.
- `@backend`: ingeniero de integraciones de plataforma. Implementa Bluetooth, bateria, notificaciones, arranque al iniciar sesion y persistencia local.
- `@frontend`: ingeniero de interfaz nativa. Implementa menu bar app, ventana de ajustes, estados de UI y experiencia de escritorio.

Nota: se mantiene el nombre `@backend` por compatibilidad con el workflow anterior, pero en este proyecto no significa "servidor"; significa capa de plataforma e integraciones del sistema.

## 2. Workflows

### Fase 0 - Auditar: `@[/audit]`

Objetivo: revisar el proyecto sin tocar codigo.

- Comprueba si la arquitectura sigue el enfoque nativo de macOS.
- Busca riesgos reales: permisos, notificaciones, estado desconocido de bateria, mezcla excesiva de UI con logica de plataforma, dependencias innecesarias.
- Genera un informe en `.orchestrator/audits/`.

### Fase 1 - Pensar: `@[/think] [idea o feature]`

Objetivo: investigar y diseñar sin implementar.

- Analiza el proyecto y genera un plan en `.orchestrator/plans/`.
- Documenta investigacion, diseno, riesgos, estados no soportados y plan de tareas.
- Es el paso recomendado antes de tocar deteccion Bluetooth, login items o notificaciones.

### Fase 2 - Construir: `@[/forge] execute`

Objetivo: implementar el plan acordado.

- Retoma el ultimo plan o uno indicado por ruta.
- Crea rama segura si hace falta.
- Implementa tareas con foco en `@backend` y `@frontend`.
- Verifica compilacion con herramientas nativas (`xcodebuild` o `swift test`, segun el proyecto).

### Fase 3 - Entregar: `@[/ship] "mensaje breve"`

Objetivo: preparar commit profesional y push seguro cuando tu lo decidas.

- Resume cambios.
- Valida build/test antes de proponer commit.
- Formatea el mensaje con Conventional Commits.

Atajo: para cambios pequeños puedes usar `@[/forge] ajusta el umbral de notificaciones`, pero el sistema seguira intentando documentar el cambio y validar que el comportamiento quede claro.

## 3. Reglas de Oro

1. Nunca prometer soporte universal de bateria.
   Algunos dispositivos Bluetooth no exponen el dato o lo hacen fuera de rutas estandar. El sistema debe diferenciar entre `battery known`, `battery unavailable` y `device unsupported or unknown`.

2. macOS first, Windows later.
   La arquitectura debe dejar costuras claras para otra plataforma, pero el codigo actual optimiza para macOS 14+.

3. Menu bar first.
   La experiencia principal vive en la barra de menu, con una ventana minima de ajustes.

4. Connected devices only.
   La prioridad del producto es vigilar dispositivos conectados por Bluetooth. No se deben generar falsas expectativas sobre dispositivos apagados, fuera de alcance o sin telemetria de bateria.

5. Documentar limites de plataforma.
   Cada decision importante sobre deteccion, permisos, fallback o heuristicas debe quedar reflejada en `design.md`, `plan.md` o `docs/`.

6. No backend remoto por defecto.
   Este producto se diseña como app local. Si en el futuro aparece sincronizacion o nube, sera una decision explicita, no una suposicion.

## 4. Stack Objetivo

- `Swift`
- `SwiftUI`
- `AppKit` solo cuando haga falta
- `CoreBluetooth`
- APIs del sistema para notificaciones y login item
- `UserDefaults`
- `XCTest` o `Swift Testing`
- `macOS 14+`

## 5. Estado del Producto

Decisiones actuales del proyecto:

- Plataforma inicial: `macOS`
- Vision futura: `Windows`, si el producto demuestra valor
- Distribucion: uso personal, fuera de App Store
- Formato de app: `menu bar app + login at startup + settings window`
- Persistencia: `UserDefaults`
- Requisito de producto: intentar detectar bateria de todos los dispositivos Bluetooth conectados, asumiendo que no todos reportaran bateria de forma accesible

## 6. Inyeccion en Nuevos Proyectos

Esta carpeta `.agent` es agnostica al negocio, pero esta opinionada para apps nativas de escritorio centradas en integraciones del sistema.

Despues de copiarla a un nuevo proyecto:

1. Actualiza `.agent/contexts/project-domain.md`.
2. Ajusta la plataforma base si no es `macOS 14+`.
3. Deja claro si la app es `menu bar`, `windowed`, o ambas.
4. Declara desde el principio si el proyecto tiene soporte multiplataforma real o solo una aspiracion futura.
