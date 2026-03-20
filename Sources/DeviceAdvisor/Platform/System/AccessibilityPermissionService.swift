import ApplicationServices
import AppKit
import Foundation

@MainActor
protocol AccessibilityPermissionServicing {
    var isTrusted: Bool { get }
    func requestAccessPrompt()
    func openAccessibilitySettings()
}

@MainActor
struct DefaultAccessibilityPermissionService: AccessibilityPermissionServicing {
    var isTrusted: Bool {
        AXIsProcessTrusted()
    }

    func requestAccessPrompt() {
        let options = [
            "AXTrustedCheckOptionPrompt": true,
        ] as CFDictionary
        _ = AXIsProcessTrustedWithOptions(options)
    }

    func openAccessibilitySettings() {
        guard let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility") else {
            return
        }

        NSWorkspace.shared.open(url)
    }
}
