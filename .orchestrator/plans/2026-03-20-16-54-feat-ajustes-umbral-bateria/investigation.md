# Investigation: Ajustes del umbral de bateria

## Summary

La app ya tiene un `UserDefaultsSettingsStore` y una ventana de ajustes placeholder, pero el umbral de bateria baja no es editable desde la UI. La siguiente feature pequena y util es conectar la ventana de ajustes con ese store para que el usuario pueda cambiar el umbral global y verlo persistido.

## Current State

- El store ya soporta:
  - `loadLowBatteryThreshold()`
  - `saveLowBatteryThreshold(_:)`
- `SettingsViewModel` solo carga el valor inicial.
- `SettingsView` solo lo muestra como texto.
- No hay validacion ni tests del view model.

## Affected Files

- `Sources/DeviceAdvisor/UI/Settings/SettingsView.swift`
- `Sources/DeviceAdvisor/UI/Settings/SettingsViewModel.swift`
- `Tests/DeviceAdvisorTests/`
- `README.md`

## Risks

| Risk | Impact | Mitigation |
|---|---|---|
| Guardar valores fuera de rango | Medium | Limitar el valor en el view model |
| Mezclar persistencia con la vista | Medium | Mantener el guardado en el view model |
| UI demasiado compleja para una feature pequena | Low | Usar controles nativos simples |

## Recommendation

Implementar una UI nativa minima con `Stepper` y valor visible, guardado inmediato a `UserDefaults`, y tests del `SettingsViewModel` para asegurar carga, guardado y acotado del valor.
