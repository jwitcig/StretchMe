import SwiftUI
#if SWIFT_PACKAGE
import TextendCore
#endif

public struct TextendPalette {
    public let background: Color
    public let foreground: Color
    public let secondaryForeground: Color
    public let chromeFill: Color
    public let chromeStroke: Color
    public let buttonFill: Color
    public let buttonText: Color
    public let buttonStroke: Color
    public let previewBackdrop: Color
    public let shadow: Color

    public static func forStyle(_ style: TextendStyle) -> TextendPalette {
        switch style {
        case .light:
            TextendPalette(
                background: .white,
                foreground: .black,
                secondaryForeground: Color.black.opacity(0.62),
                chromeFill: Color.black.opacity(0.04),
                chromeStroke: Color.black.opacity(0.10),
                buttonFill: .black,
                buttonText: .white,
                buttonStroke: .clear,
                previewBackdrop: Color.black.opacity(0.035),
                shadow: Color.black.opacity(0.08)
            )
        case .dark:
            TextendPalette(
                background: .black,
                foreground: .white,
                secondaryForeground: Color.white.opacity(0.70),
                chromeFill: Color.white.opacity(0.08),
                chromeStroke: Color.white.opacity(0.14),
                buttonFill: .white,
                buttonText: .black,
                buttonStroke: .clear,
                previewBackdrop: Color.white.opacity(0.08),
                shadow: Color.black.opacity(0.28)
            )
        }
    }
}
