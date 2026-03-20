import Foundation

protocol BluetoothBatteryProviding {
    func batteryStates(for devices: [ConnectedBluetoothDevice]) -> [String: BatteryState]
}
