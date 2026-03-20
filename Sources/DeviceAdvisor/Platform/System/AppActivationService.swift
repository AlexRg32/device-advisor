import AppKit

@MainActor
protocol AppActivationServicing {
    func activate()
    func terminate()
}

@MainActor
struct DefaultAppActivationService: AppActivationServicing {
    func activate() {
        NSApp.activate(ignoringOtherApps: true)
    }

    func terminate() {
        NSApp.terminate(nil)
    }
}
