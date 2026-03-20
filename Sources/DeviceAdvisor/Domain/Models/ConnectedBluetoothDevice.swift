import Foundation

struct ConnectedBluetoothDevice: Identifiable, Equatable {
    let id: String
    let name: String
    let address: String
    let batteryState: BatteryState

    init(
        id: String,
        name: String,
        address: String,
        batteryState: BatteryState = .unknown
    ) {
        self.id = id
        self.name = name
        self.address = address
        self.batteryState = batteryState
    }
}
