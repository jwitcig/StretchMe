import Foundation

public enum TextendStyle: String, CaseIterable, Codable, Sendable {
    case light
    case dark

    public var displayName: String {
        switch self {
        case .light:
            "Light"
        case .dark:
            "Dark"
        }
    }
}
