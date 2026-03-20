import Foundation
import IOBluetooth

struct IOBluetoothConnectedDevicesProvider: ConnectedBluetoothDevicesProviding {
    func fetchConnectedDevices() -> [ConnectedBluetoothDevice] {
        guard let pairedDevices = IOBluetoothDevice.pairedDevices() as? [IOBluetoothDevice] else {
            return []
        }

        return pairedDevices
            .filter { $0.isConnected() }
            .map {
                ConnectedBluetoothDevice(
                    id: $0.addressString,
                    name: $0.nameOrAddress ?? $0.addressString,
                    address: $0.addressString
                )
            }
            .sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
    }
}
