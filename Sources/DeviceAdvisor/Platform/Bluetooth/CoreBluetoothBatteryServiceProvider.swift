import CoreBluetooth
import Foundation

struct CoreBluetoothBatteryServiceProvider: BluetoothBatteryProviding {
    func batteryStates(for devices: [ConnectedBluetoothDevice]) -> [String: BatteryState] {
        CoreBluetoothBatteryReadSession(devices: devices).resolve(timeout: 3.0)
    }
}

private final class CoreBluetoothBatteryReadSession: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    private let devices: [ConnectedBluetoothDevice]
    private let queue = DispatchQueue(label: "device-advisor.bluetooth.battery")
    private let semaphore = DispatchSemaphore(value: 0)
    private let batteryServiceUUID = CBUUID(string: "180F")
    private let batteryLevelCharacteristicUUID = CBUUID(string: "2A19")

    private var centralManager: CBCentralManager?
    private var pendingPeripheralIdentifiers: Set<UUID> = []
    private var statesByDeviceID: [String: BatteryState] = [:]
    private var finished = false

    init(devices: [ConnectedBluetoothDevice]) {
        self.devices = devices
    }

    func resolve(timeout: TimeInterval) -> [String: BatteryState] {
        guard !devices.isEmpty else {
            return [:]
        }

        centralManager = CBCentralManager(delegate: self, queue: queue)

        _ = semaphore.wait(timeout: .now() + timeout)
        finishIfNeeded()
        return statesByDeviceID
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        guard central.state == .poweredOn else {
            finishIfNeeded()
            return
        }

        let connectedPeripherals = central.retrieveConnectedPeripherals(withServices: [batteryServiceUUID])
        let matchedPeripherals = connectedPeripherals.filter { peripheral in
            guard let peripheralName = peripheral.name else {
                return false
            }

            return devices.contains { normalized($0.name) == normalized(peripheralName) }
        }

        guard !matchedPeripherals.isEmpty else {
            finishIfNeeded()
            return
        }

        pendingPeripheralIdentifiers = Set(matchedPeripherals.map(\.identifier))

        for peripheral in matchedPeripherals {
            peripheral.delegate = self
            central.connect(peripheral, options: nil)
        }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices([batteryServiceUUID])
    }

    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        markCompleted(for: peripheral, state: .unknown)
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard
            error == nil,
            let service = peripheral.services?.first(where: { $0.uuid == batteryServiceUUID })
        else {
            markCompleted(for: peripheral, state: .unknown)
            return
        }

        peripheral.discoverCharacteristics([batteryLevelCharacteristicUUID], for: service)
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard
            error == nil,
            let characteristic = service.characteristics?.first(where: { $0.uuid == batteryLevelCharacteristicUUID })
        else {
            markCompleted(for: peripheral, state: .unavailable)
            return
        }

        peripheral.readValue(for: characteristic)
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard
            error == nil,
            let value = characteristic.value,
            let batteryLevel = value.first
        else {
            markCompleted(for: peripheral, state: .unavailable)
            return
        }

        if batteryLevel <= 100 {
            markCompleted(for: peripheral, state: .known(Int(batteryLevel)))
        } else {
            markCompleted(for: peripheral, state: .unavailable)
        }
    }

    private func markCompleted(for peripheral: CBPeripheral, state: BatteryState) {
        if let peripheralName = peripheral.name {
            let matchingDeviceIDs = devices
                .filter { normalized($0.name) == normalized(peripheralName) }
                .map(\.id)

            for deviceID in matchingDeviceIDs {
                statesByDeviceID[deviceID] = state
            }
        }

        pendingPeripheralIdentifiers.remove(peripheral.identifier)

        if let centralManager {
            centralManager.cancelPeripheralConnection(peripheral)
        }

        if pendingPeripheralIdentifiers.isEmpty {
            finishIfNeeded()
        }
    }

    private func finishIfNeeded() {
        guard !finished else {
            return
        }

        finished = true
        semaphore.signal()
    }

    private func normalized(_ value: String) -> String {
        value.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
}
