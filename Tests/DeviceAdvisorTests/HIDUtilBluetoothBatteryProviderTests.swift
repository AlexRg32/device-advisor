import Testing
@testable import DeviceAdvisor

struct HIDUtilBluetoothBatteryProviderTests {
    @Test
    func parsesKnownBatteryPercentage() {
        let output = """
        RegistryID  Key                   Value
        100002cb8   BatteryPercent        45
        """

        #expect(HIDUtilBluetoothBatteryProvider.parseBatteryState(from: output) == .known(45))
    }

    @Test
    func parsesUnavailableBatteryWhenPropertyIsNull() {
        let output = """
        RegistryID  Key                   Value
        100002cb8   BatteryPercent   (null)
        """

        #expect(HIDUtilBluetoothBatteryProvider.parseBatteryState(from: output) == .unavailable)
    }

    @Test
    func returnsUnknownWhenTheCommandReturnsNothing() {
        #expect(HIDUtilBluetoothBatteryProvider.parseBatteryState(from: "") == .unknown)
    }
}
