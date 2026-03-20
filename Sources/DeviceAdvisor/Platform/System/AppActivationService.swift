import AppKit

@MainActor
protocol AppActivationServicing {
    func terminate()
}

@MainActor
struct DefaultAppActivationService: AppActivationServicing {
    func terminate() {
        NSApp.terminate(nil)
    }
}
