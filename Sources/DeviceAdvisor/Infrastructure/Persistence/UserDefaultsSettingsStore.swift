import Foundation

final class UserDefaultsSettingsStore: AppSettingsStore {
    private enum Keys {
        static let lowBatteryThreshold = "settings.lowBatteryThreshold"
        static let defaultThreshold = 20
    }

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func loadLowBatteryThreshold() -> Int {
        let storedValue = userDefaults.object(forKey: Keys.lowBatteryThreshold) as? Int
        return storedValue ?? Keys.defaultThreshold
    }

    func saveLowBatteryThreshold(_ threshold: Int) {
        userDefaults.set(threshold, forKey: Keys.lowBatteryThreshold)
    }
}
