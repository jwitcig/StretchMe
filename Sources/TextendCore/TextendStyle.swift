import Foundation

public enum TextendStyle: String, CaseIterable, Codable, Sendable {
    case signal
    case midnight
    case sunrise

    public var displayName: String {
        switch self {
        case .signal:
            "Signal"
        case .midnight:
            "Midnight"
        case .sunrise:
            "Sunrise"
        }
    }
}
