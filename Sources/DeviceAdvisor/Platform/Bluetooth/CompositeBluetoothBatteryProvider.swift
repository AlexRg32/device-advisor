import Foundation

struct CompositeBluetoothBatteryProvider: BluetoothBatteryProviding {
    let providers: [any BluetoothBatteryProviding]

    func batteryStates(for devices: [ConnectedBluetoothDevice]) -> [String: BatteryState] {
        var merged = Dictionary(uniqueKeysWithValues: devices.map { ($0.id, BatteryState.unknown) })

        for provider in providers {
            let nextValues = provider.batteryStates(for: devices)

            for (deviceID, nextState) in nextValues {
                let currentState = merged[deviceID] ?? .unknown
                merged[deviceID] = merge(current: currentState, next: nextState)
            }
        }

        return merged
    }

    private func merge(current: BatteryState, next: BatteryState) -> BatteryState {
        switch (current, next) {
        case (.known, _):
            return current
        case (_, .known):
            return next
        case (.unavailable, .unknown):
            return current
        case (.unknown, .unavailable):
            return next
        default:
            return current
        }
    }
}
