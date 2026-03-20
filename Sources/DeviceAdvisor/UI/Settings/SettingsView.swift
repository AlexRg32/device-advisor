import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.spacingLarge) {
            VStack(alignment: .leading, spacing: AppTheme.spacingSmall) {
                Text("Ajustes")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("Esta es la ventana base de ajustes. Aqui viviran el umbral global, el arranque al iniciar sesion y las preferencias de notificaciones.")
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Divider()

            VStack(alignment: .leading, spacing: AppTheme.spacingSmall) {
                Text("Umbral de bateria baja")
                    .font(.headline)

                Text("\(viewModel.lowBatteryThreshold)%")
                    .font(.system(size: 28, weight: .bold, design: .rounded))

                Stepper(
                    value: Binding(
                        get: { viewModel.lowBatteryThreshold },
                        set: { viewModel.updateLowBatteryThreshold($0) }
                    ),
                    in: viewModel.thresholdRange,
                    step: 1
                ) {
                    Text("Ajustar umbral")
                }

                Text("Cuando el monitor de bateria este conectado, este porcentaje marcara el punto en el que la app debera avisarte.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                Text("Rango permitido: \(viewModel.thresholdRange.lowerBound)% - \(viewModel.thresholdRange.upperBound)%")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()
        }
        .padding(AppTheme.spacingXLarge)
    }
}
