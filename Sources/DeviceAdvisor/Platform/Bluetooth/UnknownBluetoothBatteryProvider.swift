import Foundation

struct UnknownBluetoothBatteryProvider: BluetoothBatteryProviding {
    func batteryStates(for devices: [ConnectedBluetoothDevice]) -> [String: BatteryState] {
        Dictionary(uniqueKeysWithValues: devices.map { ($0.id, .unknown) })
    }
}
