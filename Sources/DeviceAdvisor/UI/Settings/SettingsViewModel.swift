import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published private(set) var lowBatteryThreshold: Int

    private let settingsStore: any AppSettingsStore

    init(settingsStore: any AppSettingsStore) {
        self.settingsStore = settingsStore
        self.lowBatteryThreshold = settingsStore.loadLowBatteryThreshold()
    }
}
