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
                Text("Umbral preparado")
                    .font(.headline)

                Text("\(viewModel.lowBatteryThreshold)%")
                    .font(.system(size: 28, weight: .bold, design: .rounded))

                Text("Todavia no hay UI editable para este valor. En esta primera feature solo dejamos el shell y la persistencia base listos.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()
        }
        .padding(AppTheme.spacingXLarge)
    }
}
