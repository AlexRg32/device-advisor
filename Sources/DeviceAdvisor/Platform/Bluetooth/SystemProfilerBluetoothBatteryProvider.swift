import Foundation

struct SystemProfilerBluetoothBatteryProvider: BluetoothBatteryProviding {
    private let reportLoader: () throws -> Data

    init(reportLoader: @escaping () throws -> Data = Self.loadBluetoothReport) {
        self.reportLoader = reportLoader
    }

    func batteryStates(for devices: [ConnectedBluetoothDevice]) -> [String: BatteryState] {
        let fallbackStates = Dictionary(uniqueKeysWithValues: devices.map { ($0.id, BatteryState.unknown) })

        guard let reportData = try? reportLoader() else {
            return fallbackStates
        }

        let parsedStates = Self.parseBatteryStates(from: reportData)
        return fallbackStates.merging(parsedStates) { _, parsedValue in
            parsedValue
        }
    }

    private static func loadBluetoothReport() throws -> Data {
        let process = Process()
        let outputPipe = Pipe()

        process.executableURL = URL(fileURLWithPath: "/usr/sbin/system_profiler")
        process.arguments = ["SPBluetoothDataType", "-json"]
        process.standardOutput = outputPipe
        process.standardError = Pipe()

        try process.run()
        process.waitUntilExit()

        guard process.terminationStatus == 0 else {
            throw NSError(domain: "SystemProfilerBluetoothBatteryProvider", code: Int(process.terminationStatus))
        }

        return outputPipe.fileHandleForReading.readDataToEndOfFile()
    }

    static func parseBatteryStates(from reportData: Data) -> [String: BatteryState] {
        guard
            let jsonObject = try? JSONSerialization.jsonObject(with: reportData),
            let root = jsonObject as? [String: Any],
            let bluetoothEntries = root["SPBluetoothDataType"] as? [[String: Any]]
        else {
            return [:]
        }

        var statesByAddress: [String: BatteryState] = [:]

        for entry in bluetoothEntries {
            guard let connectedDevices = entry["device_connected"] as? [[String: Any]] else {
                continue
            }

            for wrappedDevice in connectedDevices {
                for (_, rawDeviceValue) in wrappedDevice {
                    guard
                        let deviceInfo = rawDeviceValue as? [String: Any],
                        let address = deviceInfo["device_address"] as? String
                    else {
                        continue
                    }

                    statesByAddress[address] = parseBatteryState(from: deviceInfo)
                }
            }
        }

        return statesByAddress
    }

    private static func parseBatteryState(from deviceInfo: [String: Any]) -> BatteryState {
        let batteryLikeEntries = deviceInfo.filter { key, _ in
            let lowercasedKey = key.lowercased()
            return lowercasedKey.contains("battery") || lowercasedKey.contains("charge")
        }

        guard !batteryLikeEntries.isEmpty else {
            return .unknown
        }

        var percentageCandidates: Set<Int> = []

        for (key, value) in batteryLikeEntries {
            let lowercasedKey = key.lowercased()

            switch value {
            case let number as NSNumber:
                let intValue = number.intValue
                if intValue >= 0 && intValue <= 100 && intValue > 5 {
                    percentageCandidates.insert(intValue)
                } else if lowercasedKey.contains("percent"), intValue >= 0 && intValue <= 100 {
                    percentageCandidates.insert(intValue)
                }

            case let string as String:
                if let parsed = parsePercentage(from: string, key: lowercasedKey) {
                    percentageCandidates.insert(parsed)
                }

            default:
                break
            }
        }

        if percentageCandidates.count == 1, let percentage = percentageCandidates.first {
            return .known(percentage)
        }

        if percentageCandidates.isEmpty {
            return .unavailable
        }

        return .unknown
    }

    private static func parsePercentage(from string: String, key: String) -> Int? {
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmed.contains("%") {
            let digits = trimmed.filter(\.isNumber)
            if let value = Int(digits), value >= 0 && value <= 100 {
                return value
            }
        }

        if key.contains("percent"), let value = Int(trimmed), value >= 0 && value <= 100 {
            return value
        }

        return nil
    }
}
