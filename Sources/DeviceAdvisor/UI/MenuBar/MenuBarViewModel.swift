import Foundation

@MainActor
final class MenuBarViewModel: ObservableObject {
    @Published private(set) var shellState: AppShellState = .idle

    private let appActivationService: any AppActivationServicing

    init(appActivationService: any AppActivationServicing) {
        self.appActivationService = appActivationService
    }

    var title: String {
        "Device Advisor"
    }

    var statusMessage: String {
        shellState.description
    }

    func quitApplication() {
        appActivationService.terminate()
    }
}
