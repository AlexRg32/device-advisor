import Foundation
import Testing
@testable import DeviceAdvisor

struct SystemProfilerBluetoothBatteryProviderTests {
    @Test
    func parsesKnownBatteryPercentageWhenPresent() throws {
        let json = """
        {
          "SPBluetoothDataType" : [
            {
              "device_connected" : [
                {
                  "Headphones" : {
                    "device_address" : "AA:BB:CC:DD:EE:FF",
                    "device_batteryPercent" : "87"
                  }
                }
              ]
            }
          ]
        }
        """

        let states = SystemProfilerBluetoothBatteryProvider.parseBatteryStates(from: Data(json.utf8))

        #expect(states["AA:BB:CC:DD:EE:FF"] == .known(87))
    }

    @Test
    func returnsUnknownWhenNoBatteryFieldsExist() throws {
        let json = """
        {
          "SPBluetoothDataType" : [
            {
              "device_connected" : [
                {
                  "Mouse" : {
                    "device_address" : "11:22:33:44:55:66",
                    "device_minorType" : "Mouse"
                  }
                }
              ]
            }
          ]
        }
        """

        let states = SystemProfilerBluetoothBatteryProvider.parseBatteryStates(from: Data(json.utf8))

        #expect(states["11:22:33:44:55:66"] == .unknown)
    }

    @Test
    func returnsUnavailableWhenBatteryFieldExistsWithoutUsablePercent() throws {
        let json = """
        {
          "SPBluetoothDataType" : [
            {
              "device_connected" : [
                {
                  "Keyboard" : {
                    "device_address" : "77:88:99:AA:BB:CC",
                    "device_batteryLevel" : "Unavailable"
                  }
                }
              ]
            }
          ]
        }
        """

        let states = SystemProfilerBluetoothBatteryProvider.parseBatteryStates(from: Data(json.utf8))

        #expect(states["77:88:99:AA:BB:CC"] == .unavailable)
    }
}
