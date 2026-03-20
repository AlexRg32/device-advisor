import SwiftUI

@main
struct DeviceAdvisorApp: App {
    @StateObject private var menuBarViewModel: MenuBarViewModel
    @StateObject private var settingsViewModel: SettingsViewModel

    init() {
        let settingsStore = UserDefaultsSettingsStore()
        let connectedDevicesProvider = IOBluetoothConnectedDevicesProvider()
        let accessibilityPermissionService = DefaultAccessibilityPermissionService()
        let bluetoothBatteryProvider = CompositeBluetoothBatteryProvider(
            providers: [
                ControlCenterBluetoothBatteryProvider(),
                CoreBluetoothBatteryServiceProvider(),
                HIDUtilBluetoothBatteryProvider(),
                SystemProfilerBluetoothBatteryProvider(),
                UnknownBluetoothBatteryProvider(),
            ]
        )
        let activationService = DefaultAppActivationService()

        _menuBarViewModel = StateObject(
            wrappedValue: MenuBarViewModel(
                connectedDevicesProvider: connectedDevicesProvider,
                bluetoothBatteryProvider: bluetoothBatteryProvider,
                appActivationService: activationService,
                accessibilityPermissionService: accessibilityPermissionService
            )
        )
        _settingsViewModel = StateObject(
            wrappedValue: SettingsViewModel(settingsStore: settingsStore)
        )
    }

    var body: some Scene {
        MenuBarExtra("Device Advisor", systemImage: "sensor.tag.radiowaves.forward") {
            MenuBarRootView(viewModel: menuBarViewModel)
        }
        .menuBarExtraStyle(.window)

        Settings {
            SettingsView(viewModel: settingsViewModel)
                .frame(minWidth: 420, minHeight: 220)
        }
    }
}
