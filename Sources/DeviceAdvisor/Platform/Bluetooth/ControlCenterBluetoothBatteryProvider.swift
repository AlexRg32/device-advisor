import ApplicationServices
import Cocoa
import Foundation

struct ControlCenterBluetoothBatteryProvider: BluetoothBatteryProviding {
    struct ScrapedDeviceEntry: Equatable {
        let identifier: String
        let text: String
    }

    private let scraper: () -> [ScrapedDeviceEntry]

    init(scraper: @escaping () -> [ScrapedDeviceEntry] = Self.scrapeControlCenterBluetoothEntries) {
        self.scraper = scraper
    }

    func batteryStates(for devices: [ConnectedBluetoothDevice]) -> [String: BatteryState] {
        let scrapedEntries = scraper()
        let statesByAddress = Self.parseBatteryStates(from: scrapedEntries)

        return Dictionary(uniqueKeysWithValues: devices.map { device in
            let normalizedAddress = Self.normalizedAddress(device.address)
            return (device.id, statesByAddress[normalizedAddress] ?? .unknown)
        })
    }

    static func parseBatteryStates(from entries: [ScrapedDeviceEntry]) -> [String: BatteryState] {
        var statesByAddress: [String: BatteryState] = [:]

        for entry in entries {
            guard let address = bluetoothAddress(from: entry.identifier) else {
                continue
            }

            let normalizedAddress = normalizedAddress(address)
            let trimmedText = entry.text.trimmingCharacters(in: .whitespacesAndNewlines)

            if let percentage = parsePercentage(from: trimmedText) {
                statesByAddress[normalizedAddress] = .known(percentage)
            } else if !trimmedText.isEmpty {
                statesByAddress[normalizedAddress] = .unavailable
            }
        }

        return statesByAddress
    }

    private static func scrapeControlCenterBluetoothEntries() -> [ScrapedDeviceEntry] {
        guard AXIsProcessTrusted() else {
            return []
        }

        guard
            let controlCenterApp = NSRunningApplication
                .runningApplications(withBundleIdentifier: "com.apple.controlcenter")
                .first
        else {
            return []
        }

        let application = AXUIElementCreateApplication(controlCenterApp.processIdentifier)

        guard
            let menuBar = findDescendant(in: children(of: application), matching: { role(of: $0) == kAXMenuBarRole as String }),
            let controlCenterItem = children(of: menuBar).first(where: {
                description(of: $0).localizedCaseInsensitiveContains("Centro de control")
                    || description(of: $0).localizedCaseInsensitiveContains("Control Center")
            })
        else {
            return []
        }

        let wasOpen = findDescendant(in: children(of: application), matching: { role(of: $0) == kAXWindowRole as String }) != nil

        if !wasOpen {
            _ = AXUIElementPerformAction(controlCenterItem, kAXPressAction as CFString)
            usleep(500_000)
        }

        defer {
            if !wasOpen {
                _ = AXUIElementPerformAction(controlCenterItem, kAXPressAction as CFString)
            }
        }

        guard
            let controlCenterWindow = findDescendant(in: children(of: application), matching: { role(of: $0) == kAXWindowRole as String }),
            let bluetoothControl = findDescendant(in: children(of: controlCenterWindow), matching: {
                identifier(of: $0) == "controlcenter-bluetooth"
                    || description(of: $0).localizedCaseInsensitiveContains("Bluetooth")
            })
        else {
            return []
        }

        openBluetoothDetails(for: bluetoothControl)
        usleep(500_000)

        guard
            let bluetoothList = findDescendant(in: children(of: application), matching: {
                identifier(of: $0) == "bluetooth-header" && role(of: $0) == kAXCheckBoxRole as String
            })
        else {
            return []
        }

        return children(of: bluetoothList).compactMap { element in
            let identifier = identifier(of: element)
            guard identifier.hasPrefix("bluetooth-device-") else {
                return nil
            }

            let text = firstMeaningfulText(for: element)
            return ScrapedDeviceEntry(identifier: identifier, text: text)
        }
    }

    private static func openBluetoothDetails(for bluetoothControl: AXUIElement) {
        var actionsRef: CFArray?
        guard AXUIElementCopyActionNames(bluetoothControl, &actionsRef) == .success else {
            return
        }

        let actions = actionsRef as? [String] ?? []

        if let detailAction = actions.first(where: { $0.contains("mostrar detalles") || $0.contains("show details") }) {
            _ = AXUIElementPerformAction(bluetoothControl, detailAction as CFString)
            return
        }

        if actions.contains(kAXShowMenuAction as String) {
            _ = AXUIElementPerformAction(bluetoothControl, kAXShowMenuAction as CFString)
        }
    }

    private static func firstMeaningfulText(for element: AXUIElement) -> String {
        let candidates = [
            description(of: element),
            title(of: element),
            value(of: element),
        ].filter { !$0.isEmpty }

        if let directMatch = candidates.first {
            return directMatch
        }

        for child in children(of: element) {
            let childCandidates = [
                description(of: child),
                title(of: child),
                value(of: child),
            ].filter { !$0.isEmpty }

            if let first = childCandidates.first {
                return first
            }
        }

        return ""
    }

    private static func parsePercentage(from text: String) -> Int? {
        let digits = text.filter(\.isNumber)
        guard text.contains("%"), let percentage = Int(digits), (0...100).contains(percentage) else {
            return nil
        }

        return percentage
    }

    private static func bluetoothAddress(from identifier: String) -> String? {
        guard identifier.hasPrefix("bluetooth-device-") else {
            return nil
        }

        return String(identifier.dropFirst("bluetooth-device-".count))
    }

    private static func normalizedAddress(_ address: String) -> String {
        address
            .replacingOccurrences(of: "-", with: ":")
            .uppercased()
    }

    private static func children(of element: AXUIElement) -> [AXUIElement] {
        var value: CFTypeRef?
        guard AXUIElementCopyAttributeValue(element, kAXChildrenAttribute as CFString, &value) == .success else {
            return []
        }

        return value as? [AXUIElement] ?? []
    }

    private static func role(of element: AXUIElement) -> String {
        stringAttribute(kAXRoleAttribute as String, on: element)
    }

    private static func description(of element: AXUIElement) -> String {
        stringAttribute(kAXDescriptionAttribute as String, on: element)
    }

    private static func title(of element: AXUIElement) -> String {
        stringAttribute(kAXTitleAttribute as String, on: element)
    }

    private static func value(of element: AXUIElement) -> String {
        stringAttribute(kAXValueAttribute as String, on: element)
    }

    private static func identifier(of element: AXUIElement) -> String {
        stringAttribute("AXIdentifier", on: element)
    }

    private static func stringAttribute(_ name: String, on element: AXUIElement) -> String {
        var value: CFTypeRef?
        guard AXUIElementCopyAttributeValue(element, name as CFString, &value) == .success else {
            return ""
        }

        return value as? String ?? ""
    }

    private static func findDescendant(
        in elements: [AXUIElement],
        matching predicate: (AXUIElement) -> Bool
    ) -> AXUIElement? {
        for element in elements {
            if predicate(element) {
                return element
            }

            if let found = findDescendant(in: children(of: element), matching: predicate) {
                return found
            }
        }

        return nil
    }
}
