import Foundation
import Testing
@testable import DeviceAdvisor

@MainActor
struct SettingsViewModelTests {
    @Test
    func loadsInitialThresholdFromStore() {
        let store = FakeAppSettingsStore(initialThreshold: 33)

        let viewModel = SettingsViewModel(settingsStore: store)

        #expect(viewModel.lowBatteryThreshold == 33)
    }

    @Test
    func persistsUpdatedThreshold() {
        let store = FakeAppSettingsStore(initialThreshold: 20)
        let viewModel = SettingsViewModel(settingsStore: store)

        viewModel.updateLowBatteryThreshold(27)

        #expect(viewModel.lowBatteryThreshold == 27)
        #expect(store.savedValues == [27])
        #expect(store.storedThreshold == 27)
    }

    @Test
    func clampsThresholdBelowRange() {
        let store = FakeAppSettingsStore(initialThreshold: 20)
        let viewModel = SettingsViewModel(settingsStore: store)

        viewModel.updateLowBatteryThreshold(-4)

        #expect(viewModel.lowBatteryThreshold == 1)
        #expect(store.savedValues == [1])
    }

    @Test
    func clampsThresholdAboveRange() {
        let store = FakeAppSettingsStore(initialThreshold: 20)
        let viewModel = SettingsViewModel(settingsStore: store)

        viewModel.updateLowBatteryThreshold(101)

        #expect(viewModel.lowBatteryThreshold == 100)
        #expect(store.savedValues == [100])
    }
}

private final class FakeAppSettingsStore: AppSettingsStore {
    var storedThreshold: Int
    var savedValues: [Int] = []

    init(initialThreshold: Int) {
        self.storedThreshold = initialThreshold
    }

    func loadLowBatteryThreshold() -> Int {
        storedThreshold
    }

    func saveLowBatteryThreshold(_ threshold: Int) {
        storedThreshold = threshold
        savedValues.append(threshold)
    }
}
