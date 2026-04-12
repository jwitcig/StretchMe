import Foundation

public enum TextendComposer {
    public static let maximumCharacterCount = 29

    public static func normalize(_ text: String) -> String {
        String(text.uppercased().prefix(maximumCharacterCount))
    }

    public static func snapshot(text: String, style: TextendStyle) -> TextendSnapshot {
        let normalizedText = normalize(text)
        return TextendSnapshot(
            rawText: text,
            normalizedText: normalizedText,
            style: style,
            maximumCharacterCount: maximumCharacterCount
        )
    }
}
