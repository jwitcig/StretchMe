import Foundation

public struct TextendSnapshot: Codable, Equatable, Sendable {
    public let rawText: String
    public let normalizedText: String
    public let style: TextendStyle
    public let maximumCharacterCount: Int
    public let canInsert: Bool
    public let remainingCharacterCount: Int

    public init(
        rawText: String,
        normalizedText: String,
        style: TextendStyle,
        maximumCharacterCount: Int
    ) {
        self.rawText = rawText
        self.normalizedText = normalizedText
        self.style = style
        self.maximumCharacterCount = maximumCharacterCount
        self.canInsert = !normalizedText.isEmpty
        self.remainingCharacterCount = max(0, maximumCharacterCount - normalizedText.count)
    }
}
