import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published private(set) var lowBatteryThreshold: Int
    let thresholdRange = 1...100

    private let settingsStore: any AppSettingsStore

    init(settingsStore: any AppSettingsStore) {
        self.settingsStore = settingsStore
        self.lowBatteryThreshold = thresholdRange.clamp(settingsStore.loadLowBatteryThreshold())
    }

    func updateLowBatteryThreshold(_ threshold: Int) {
        let sanitizedThreshold = thresholdRange.clamp(threshold)
        lowBatteryThreshold = sanitizedThreshold
        settingsStore.saveLowBatteryThreshold(sanitizedThreshold)
    }
}

private extension ClosedRange where Bound == Int {
    func clamp(_ value: Int) -> Int {
        Swift.min(Swift.max(value, lowerBound), upperBound)
    }
}
