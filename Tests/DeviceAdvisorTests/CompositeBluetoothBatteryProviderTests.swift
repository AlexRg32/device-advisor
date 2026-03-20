import Testing
@testable import DeviceAdvisor

struct CompositeBluetoothBatteryProviderTests {
    @Test
    func prefersKnownBatteryOverUnknown() {
        let devices = [
            ConnectedBluetoothDevice(id: "1", name: "Mouse", address: "1"),
        ]
        let provider = CompositeBluetoothBatteryProvider(
            providers: [
                StubBluetoothBatteryProvider(values: ["1": .unknown]),
                StubBluetoothBatteryProvider(values: ["1": .known(55)]),
            ]
        )

        let states = provider.batteryStates(for: devices)

        #expect(states["1"] == .known(55))
    }

    @Test
    func keepsUnavailableWhenNoKnownValueAppears() {
        let devices = [
            ConnectedBluetoothDevice(id: "1", name: "Mouse", address: "1"),
        ]
        let provider = CompositeBluetoothBatteryProvider(
            providers: [
                StubBluetoothBatteryProvider(values: ["1": .unknown]),
                StubBluetoothBatteryProvider(values: ["1": .unavailable]),
                StubBluetoothBatteryProvider(values: ["1": .unknown]),
            ]
        )

        let states = provider.batteryStates(for: devices)

        #expect(states["1"] == .unavailable)
    }
}

private struct StubBluetoothBatteryProvider: BluetoothBatteryProviding {
    let values: [String: BatteryState]

    func batteryStates(for devices: [ConnectedBluetoothDevice]) -> [String: BatteryState] {
        values
    }
}
