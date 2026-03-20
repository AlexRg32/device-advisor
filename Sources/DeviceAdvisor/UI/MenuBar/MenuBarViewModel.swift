import Foundation

@MainActor
final class MenuBarViewModel: ObservableObject {
    @Published private(set) var shellState: AppShellState = .idle
    @Published private(set) var connectedDevices: [ConnectedBluetoothDevice] = []
    @Published private(set) var showsAccessibilityPermissionHelp = false

    private let connectedDevicesProvider: any ConnectedBluetoothDevicesProviding
    private let bluetoothBatteryProvider: any BluetoothBatteryProviding
    private let appActivationService: any AppActivationServicing
    private let accessibilityPermissionService: any AccessibilityPermissionServicing
    private var hasRequestedAccessibilityPrompt = false

    init(
        connectedDevicesProvider: any ConnectedBluetoothDevicesProviding,
        bluetoothBatteryProvider: any BluetoothBatteryProviding,
        appActivationService: any AppActivationServicing,
        accessibilityPermissionService: any AccessibilityPermissionServicing
    ) {
        self.connectedDevicesProvider = connectedDevicesProvider
        self.bluetoothBatteryProvider = bluetoothBatteryProvider
        self.appActivationService = appActivationService
        self.accessibilityPermissionService = accessibilityPermissionService
    }

    var title: String {
        "Device Advisor"
    }

    var statusMessage: String {
        if connectedDevices.isEmpty {
            return "No hay dispositivos Bluetooth conectados ahora mismo."
        }

        let count = connectedDevices.count
        return count == 1
            ? "1 dispositivo Bluetooth conectado."
            : "\(count) dispositivos Bluetooth conectados."
    }

    func loadConnectedDevices() {
        shellState = .bootstrapping
        let baseDevices = connectedDevicesProvider.fetchConnectedDevices()
        let batteryStates = bluetoothBatteryProvider.batteryStates(for: baseDevices)
        updateAccessibilityPermissionHelp(connectedDevices: baseDevices)

        connectedDevices = baseDevices.map { device in
            ConnectedBluetoothDevice(
                id: device.id,
                name: device.name,
                address: device.address,
                batteryState: batteryStates[device.id] ?? .unknown
            )
        }
        shellState = .idle
    }

    func quitApplication() {
        appActivationService.terminate()
    }

    func openAccessibilitySettings() {
        accessibilityPermissionService.openAccessibilitySettings()
    }

    private func updateAccessibilityPermissionHelp(connectedDevices: [ConnectedBluetoothDevice]) {
        let needsPermission = !connectedDevices.isEmpty && !accessibilityPermissionService.isTrusted
        showsAccessibilityPermissionHelp = needsPermission

        if needsPermission && !hasRequestedAccessibilityPrompt {
            hasRequestedAccessibilityPrompt = true
            accessibilityPermissionService.requestAccessPrompt()
        }
    }
}
