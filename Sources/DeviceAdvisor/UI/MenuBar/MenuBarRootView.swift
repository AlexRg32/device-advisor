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
            }

            if viewModel.connectedDevices.isEmpty {
                Text("Abre el menu cuando tengas perifericos conectados para verlos aqui.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            } else {
                Divider()

                VStack(alignment: .leading, spacing: AppTheme.spacingSmall) {
                    ForEach(viewModel.connectedDevices) { device in
                        VStack(alignment: .leading, spacing: 2) {
                            Text(device.name)
                                .font(.body)

                            Text(device.address)
                                .font(.caption)
                                .foregroundStyle(.secondary)

                            Text(device.batteryState.displayText)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }

            if viewModel.showsAccessibilityPermissionHelp {
                Divider()

                VStack(alignment: .leading, spacing: AppTheme.spacingSmall) {
                    Text("Hace falta permiso de Accesibilidad para leer la bateria desde el Bluetooth del sistema.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)

                    Button {
                        viewModel.openAccessibilitySettings()
                    } label: {
                        Label("Dar acceso", systemImage: "lock.open")
                    }
                }
            }

            Divider()

            SettingsLink {
                Label("Abrir ajustes", systemImage: "gearshape")
            }

            Button {
                viewModel.loadConnectedDevices()
            } label: {
                Label("Actualizar", systemImage: "arrow.clockwise")
            }

            Button {
                viewModel.quitApplication()
            } label: {
                Label("Salir", systemImage: "power")
            }
        }
        .padding(AppTheme.spacingLarge)
        .frame(width: 320)
        .task {
            viewModel.loadConnectedDevices()
        }
    }
}
