import Foundation

enum BatteryState: Equatable {
    case known(Int)
    case unknown
    case unavailable
}

extension BatteryState {
    var displayText: String {
        switch self {
        case let .known(level):
            "Bateria: \(level)%"
        case .unknown:
            "Bateria desconocida"
        case .unavailable:
            "Bateria no disponible"
        }
    }
}
