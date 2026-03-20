import Foundation
import Testing
@testable import DeviceAdvisor

@MainActor
struct MenuBarViewModelTests {
    @Test
    func loadsConnectedDevicesFromProvider() {
        let provider = FakeConnectedBluetoothDevicesProvider(
            devices: [
                ConnectedBluetoothDevice(
                    id: "AA-BB",
                    name: "Magic Mouse",
                    address: "AA-BB"
                ),
                ConnectedBluetoothDevice(
                    id: "CC-DD",
                    name: "AirPods",
                    address: "CC-DD"
                ),
            ]
        )
        let activationService = FakeAppActivationService()
        let batteryProvider = FakeBluetoothBatteryProvider(
            values: [
                "AA-BB": .known(72),
                "CC-DD": .unknown,
            ]
        )
        let viewModel = MenuBarViewModel(
            connectedDevicesProvider: provider,
            bluetoothBatteryProvider: batteryProvider,
            appActivationService: activationService,
            accessibilityPermissionService: FakeAccessibilityPermissionService()
        )

        viewModel.loadConnectedDevices()

        #expect(viewModel.connectedDevices.count == 2)
        #expect(viewModel.statusMessage == "2 dispositivos Bluetooth conectados.")
        #expect(viewModel.connectedDevices[0].batteryState == .known(72))
        #expect(viewModel.connectedDevices[1].batteryState == .unknown)
    }

    @Test
    func showsEmptyStateWhenNoConnectedDevicesExist() {
        let provider = FakeConnectedBluetoothDevicesProvider(devices: [])
        let activationService = FakeAppActivationService()
        let batteryProvider = FakeBluetoothBatteryProvider(values: [:])
        let viewModel = MenuBarViewModel(
            connectedDevicesProvider: provider,
            bluetoothBatteryProvider: batteryProvider,
            appActivationService: activationService,
            accessibilityPermissionService: FakeAccessibilityPermissionService()
        )

        viewModel.loadConnectedDevices()

        #expect(viewModel.connectedDevices.isEmpty)
        #expect(viewModel.statusMessage == "No hay dispositivos Bluetooth conectados ahora mismo.")
    }

    @Test
    func supportsUnavailableBatteryState() {
        let provider = FakeConnectedBluetoothDevicesProvider(
            devices: [
                ConnectedBluetoothDevice(
                    id: "EE-FF",
                    name: "Headset",
                    address: "EE-FF"
                ),
            ]
        )
        let activationService = FakeAppActivationService()
        let batteryProvider = FakeBluetoothBatteryProvider(values: ["EE-FF": .unavailable])
        let viewModel = MenuBarViewModel(
            connectedDevicesProvider: provider,
            bluetoothBatteryProvider: batteryProvider,
            appActivationService: activationService,
            accessibilityPermissionService: FakeAccessibilityPermissionService()
        )

        viewModel.loadConnectedDevices()

        #expect(viewModel.connectedDevices.first?.batteryState == .unavailable)
    }

    @Test
    func showsAccessibilityHelpWhenPermissionIsMissing() {
        let provider = FakeConnectedBluetoothDevicesProvider(
            devices: [
                ConnectedBluetoothDevice(id: "AA-BB", name: "Mouse", address: "AA-BB"),
            ]
        )
        let activationService = FakeAppActivationService()
        let batteryProvider = FakeBluetoothBatteryProvider(values: ["AA-BB": .unknown])
        let accessibilityPermissionService = FakeAccessibilityPermissionService(isTrusted: false)
        let viewModel = MenuBarViewModel(
            connectedDevicesProvider: provider,
            bluetoothBatteryProvider: batteryProvider,
            appActivationService: activationService,
            accessibilityPermissionService: accessibilityPermissionService
        )

        viewModel.loadConnectedDevices()

        #expect(viewModel.showsAccessibilityPermissionHelp)
        #expect(accessibilityPermissionService.requestPromptCalls == 1)
    }
}

private struct FakeConnectedBluetoothDevicesProvider: ConnectedBluetoothDevicesProviding {
    let devices: [ConnectedBluetoothDevice]

    func fetchConnectedDevices() -> [ConnectedBluetoothDevice] {
        devices
    }
}

private struct FakeBluetoothBatteryProvider: BluetoothBatteryProviding {
    let values: [String: BatteryState]

    func batteryStates(for devices: [ConnectedBluetoothDevice]) -> [String: BatteryState] {
        Dictionary(uniqueKeysWithValues: devices.map { device in
            (device.id, values[device.id] ?? .unknown)
        })
    }
}

@MainActor
private final class FakeAppActivationService: AppActivationServicing {
    func terminate() {}
}

@MainActor
private final class FakeAccessibilityPermissionService: AccessibilityPermissionServicing {
    let isTrusted: Bool
    private(set) var requestPromptCalls = 0
    private(set) var openSettingsCalls = 0

    init(isTrusted: Bool = true) {
        self.isTrusted = isTrusted
    }

    func requestAccessPrompt() {
        requestPromptCalls += 1
    }

    func openAccessibilitySettings() {
        openSettingsCalls += 1
    }
}
