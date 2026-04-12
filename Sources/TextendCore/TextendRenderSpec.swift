import Foundation

public struct TextendRenderSpec: Codable, Equatable, Sendable {
    public let canvasWidth: Double
    public let canvasHeight: Double
    public let textBoxWidth: Double
    public let textBoxHeight: Double
    public let horizontalScale: Double
    public let verticalScale: Double
    public let usesDarkAppearance: Bool

    public init(
        canvasWidth: Double,
        canvasHeight: Double,
        textBoxWidth: Double,
        textBoxHeight: Double,
        horizontalScale: Double,
        verticalScale: Double,
        usesDarkAppearance: Bool
    ) {
        self.canvasWidth = canvasWidth
        self.canvasHeight = canvasHeight
        self.textBoxWidth = textBoxWidth
        self.textBoxHeight = textBoxHeight
        self.horizontalScale = horizontalScale
        self.verticalScale = verticalScale
        self.usesDarkAppearance = usesDarkAppearance
    }
}
