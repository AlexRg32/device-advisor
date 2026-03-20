import Foundation

enum AppShellState: Equatable {
    case bootstrapping
    case idle
}

extension AppShellState {
    var description: String {
        switch self {
        case .bootstrapping:
            "Preparando el shell de la app."
        case .idle:
            "Sin monitorizacion activa aun."
        }
    }
}
