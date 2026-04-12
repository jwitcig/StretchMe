import SwiftUI
#if SWIFT_PACKAGE
import TextendCore
#endif

public struct TextendPalette {
    public let backgroundGradient: [Color]
    public let cardGradient: [Color]
    public let primaryText: Color
    public let secondaryText: Color
    public let inputFill: Color
    public let inputStroke: Color
    public let buttonFill: Color
    public let buttonText: Color
    public let buttonStroke: Color
    public let shadow: Color

    public static func forStyle(_ style: TextendStyle) -> TextendPalette {
        switch style {
        case .signal:
            TextendPalette(
                backgroundGradient: [Color(red: 0.97, green: 0.98, blue: 1), Color(red: 0.85, green: 0.95, blue: 0.99)],
                cardGradient: [Color.white, Color(red: 0.75, green: 0.92, blue: 1)],
                primaryText: Color.black,
                secondaryText: Color.black.opacity(0.65),
                inputFill: Color.white.opacity(0.85),
                inputStroke: Color.black.opacity(0.08),
                buttonFill: Color.black,
                buttonText: Color.white,
                buttonStroke: Color.clear,
                shadow: Color.black.opacity(0.12)
            )
        case .midnight:
            TextendPalette(
                backgroundGradient: [Color(red: 0.06, green: 0.08, blue: 0.17), Color(red: 0.16, green: 0.20, blue: 0.35)],
                cardGradient: [Color(red: 0.17, green: 0.20, blue: 0.36), Color(red: 0.05, green: 0.06, blue: 0.12)],
                primaryText: Color.white,
                secondaryText: Color.white.opacity(0.7),
                inputFill: Color.white.opacity(0.08),
                inputStroke: Color.white.opacity(0.16),
                buttonFill: Color.white,
                buttonText: Color.black,
                buttonStroke: Color.white.opacity(0.2),
                shadow: Color.black.opacity(0.32)
            )
        case .sunrise:
            TextendPalette(
                backgroundGradient: [Color(red: 1, green: 0.96, blue: 0.84), Color(red: 1, green: 0.78, blue: 0.62)],
                cardGradient: [Color(red: 1, green: 0.96, blue: 0.83), Color(red: 1, green: 0.63, blue: 0.41)],
                primaryText: Color(red: 0.25, green: 0.10, blue: 0.06),
                secondaryText: Color(red: 0.33, green: 0.17, blue: 0.11).opacity(0.7),
                inputFill: Color.white.opacity(0.6),
                inputStroke: Color(red: 0.31, green: 0.15, blue: 0.10).opacity(0.12),
                buttonFill: Color(red: 0.25, green: 0.10, blue: 0.06),
                buttonText: Color.white,
                buttonStroke: Color.clear,
                shadow: Color(red: 0.35, green: 0.12, blue: 0.08).opacity(0.18)
            )
        }
    }
}
