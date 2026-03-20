import Foundation

protocol AppSettingsStore {
    func loadLowBatteryThreshold() -> Int
    func saveLowBatteryThreshold(_ threshold: Int)
}
