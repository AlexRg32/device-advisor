import SwiftUI

struct MenuBarRootView: View {
    @ObservedObject var viewModel: MenuBarViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.spacingMedium) {
            VStack(alignment: .leading, spacing: AppTheme.spacingSmall) {
                Text(viewModel.title)
                    .font(.headline)

                Text(viewModel.statusMessage)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text("El shell nativo ya esta listo. Bluetooth llegara en la siguiente feature.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Divider()

            SettingsLink {
                Label("Abrir ajustes", systemImage: "gearshape")
            }

            Button {
                viewModel.quitApplication()
            } label: {
                Label("Salir", systemImage: "power")
            }
        }
        .padding(AppTheme.spacingLarge)
        .frame(width: 320)
    }
}
