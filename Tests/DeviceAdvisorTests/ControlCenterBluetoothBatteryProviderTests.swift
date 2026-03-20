import Testing
@testable import DeviceAdvisor

struct ControlCenterBluetoothBatteryProviderTests {
    @Test
    func parsesKnownPercentagesFromScrapedEntries() {
        let entries = [
            ControlCenterBluetoothBatteryProvider.ScrapedDeviceEntry(
                identifier: "bluetooth-device-E8:46:23:05:66:39",
                text: "84 %"
            ),
            ControlCenterBluetoothBatteryProvider.ScrapedDeviceEntry(
                identifier: "bluetooth-device-D3:27:15:4E:B9:A5",
                text: "45 %"
            ),
        ]

        let states = ControlCenterBluetoothBatteryProvider.parseBatteryStates(from: entries)

        #expect(states["E8:46:23:05:66:39"] == .known(84))
        #expect(states["D3:27:15:4E:B9:A5"] == .known(45))
    }

    @Test
    func marksNamedEntriesWithoutPercentAsUnavailable() {
        let entries = [
            ControlCenterBluetoothBatteryProvider.ScrapedDeviceEntry(
                identifier: "bluetooth-device-10:18:49:E7:3A:D0",
                text: "DualSense Wireless Controller"
            ),
        ]

        let states = ControlCenterBluetoothBatteryProvider.parseBatteryStates(from: entries)

        #expect(states["10:18:49:E7:3A:D0"] == .unavailable)
    }

    @Test
    func ignoresEntriesWithoutBluetoothIdentifiers() {
        let entries = [
            ControlCenterBluetoothBatteryProvider.ScrapedDeviceEntry(
                identifier: "bluetooth-header",
                text: "Bluetooth"
            ),
        ]

        let states = ControlCenterBluetoothBatteryProvider.parseBatteryStates(from: entries)

        #expect(states.isEmpty)
    }
}
