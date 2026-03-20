import Foundation
import Testing
@testable import DeviceAdvisor

struct UserDefaultsSettingsStoreTests {
    @Test
    func defaultsToTwentyPercentWhenNoValueExists() {
        let suiteName = "UserDefaultsSettingsStoreTests.defaults.\(UUID().uuidString)"
        let userDefaults = UserDefaults(suiteName: suiteName)!
        userDefaults.removePersistentDomain(forName: suiteName)

        let store = UserDefaultsSettingsStore(userDefaults: userDefaults)

        #expect(store.loadLowBatteryThreshold() == 20)
    }

    @Test
    func persistsTheConfiguredThreshold() {
        let suiteName = "UserDefaultsSettingsStoreTests.persist.\(UUID().uuidString)"
        let userDefaults = UserDefaults(suiteName: suiteName)!
        userDefaults.removePersistentDomain(forName: suiteName)

        let store = UserDefaultsSettingsStore(userDefaults: userDefaults)
        store.saveLowBatteryThreshold(15)

        #expect(store.loadLowBatteryThreshold() == 15)
    }
}
