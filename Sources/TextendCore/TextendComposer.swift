import Foundation

public enum TextendComposer {
    public static let maximumCharacterCount = 29

    public static func normalize(_ text: String) -> String {
        String(text.uppercased().prefix(maximumCharacterCount))
    }

    public static func renderSpec(for style: TextendStyle) -> TextendRenderSpec {
        TextendRenderSpec(
            canvasWidth: 116,
            canvasHeight: 133,
            textBoxWidth: 305.26,
            textBoxHeight: 10.55,
            horizontalScale: 0.38,
            verticalScale: 12.6,
            usesDarkAppearance: style == .dark
        )
    }

    public static func snapshot(text: String, style: TextendStyle) -> TextendSnapshot {
        let normalizedText = normalize(text)
        return TextendSnapshot(
            rawText: text,
            normalizedText: normalizedText,
            style: style,
            maximumCharacterCount: maximumCharacterCount,
            renderSpec: renderSpec(for: style)
        )
    }
}
