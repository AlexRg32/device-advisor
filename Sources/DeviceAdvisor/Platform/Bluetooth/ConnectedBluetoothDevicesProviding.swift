import Foundation

protocol ConnectedBluetoothDevicesProviding {
    func fetchConnectedDevices() -> [ConnectedBluetoothDevice]
}
