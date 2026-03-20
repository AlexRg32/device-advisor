# Design: Ajustes del umbral de bateria

## Goal

Permitir editar el umbral global de bateria baja desde la ventana de ajustes.

## UX

- Mostrar el porcentaje actual con prominencia.
- Permitir incrementarlo y reducirlo con un control nativo simple.
- Explicar que ese valor se usara para las futuras notificaciones de bateria baja.

## State Flow

1. `SettingsViewModel` carga el valor desde `AppSettingsStore`.
2. El usuario cambia el valor en la UI.
3. El view model acota el valor a un rango valido.
4. El view model persiste inmediatamente el nuevo valor.
5. La UI se actualiza sin pasos extra.

## Range

- Rango propuesto: `1...100`
- Motivo: es simple, claro y no nos obliga todavia a imponer una politica mas restrictiva.

## Testing Strategy

- test de carga inicial desde store
- test de persistencia al actualizar el valor
- test de acotado por debajo y por encima del rango
