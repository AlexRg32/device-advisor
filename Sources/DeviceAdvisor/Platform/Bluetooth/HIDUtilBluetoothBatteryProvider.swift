import Foundation

struct HIDUtilBluetoothBatteryProvider: BluetoothBatteryProviding {
    private let commandRunner: (_ productName: String, _ key: String) throws -> String
    private let candidateKeys = [
        "BatteryPercent",
        "BatteryLevel",
        "PercentRemaining",
        "BatteryPercentSingle",
    ]

    init(commandRunner: @escaping (_ productName: String, _ key: String) throws -> String = Self.runBatteryQuery) {
        self.commandRunner = commandRunner
    }

    func batteryStates(for devices: [ConnectedBluetoothDevice]) -> [String: BatteryState] {
        var statesByDeviceID: [String: BatteryState] = [:]

        for device in devices {
            statesByDeviceID[device.id] = batteryState(for: device)
        }

        return statesByDeviceID
    }

    private func batteryState(for device: ConnectedBluetoothDevice) -> BatteryState {
        var sawBatteryProperty = false

        for key in candidateKeys {
            guard
                let output = try? commandRunner(device.name, key),
                !output.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            else {
                continue
            }

            let parsedState = Self.parseBatteryState(from: output)

            switch parsedState {
            case .known:
                return parsedState
            case .unavailable:
                sawBatteryProperty = true
            case .unknown:
                break
            }
        }

        return sawBatteryProperty ? .unavailable : .unknown
    }

    private static func runBatteryQuery(productName: String, key: String) throws -> String {
        let process = Process()
        let outputPipe = Pipe()

        process.executableURL = URL(fileURLWithPath: "/usr/bin/hidutil")
        process.arguments = [
            "property",
            "--matching",
            #"{"Product":"\#(escaped(productName))","Transport":"Bluetooth Low Energy"}"#,
            "--get",
            key,
        ]
        process.standardOutput = outputPipe
        process.standardError = Pipe()

        try process.run()
        process.waitUntilExit()

        guard process.terminationStatus == 0 else {
            throw NSError(domain: "HIDUtilBluetoothBatteryProvider", code: Int(process.terminationStatus))
        }

        let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
        return String(decoding: outputData, as: UTF8.self)
    }

    static func parseBatteryState(from output: String) -> BatteryState {
        let trimmed = output.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmed.isEmpty else {
            return .unknown
        }

        if trimmed.contains("(null)") {
            return .unavailable
        }

        let lines = trimmed.split(whereSeparator: \.isNewline)
        for line in lines.reversed() {
            let columns = line.split(whereSeparator: \.isWhitespace)
            guard let lastColumn = columns.last else {
                continue
            }

            if let value = Int(lastColumn), (0...100).contains(value) {
                return .known(value)
            }
        }

        return trimmed.contains("RegistryID") ? .unavailable : .unknown
    }

    private static func escaped(_ value: String) -> String {
        value
            .replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "\"", with: "\\\"")
    }
}
