import SwiftUI
#if SWIFT_PACKAGE
import TextendCore
#endif

public struct TextendStretchPreview: View {
    let text: String
    let style: TextendStyle

    public init(text: String, style: TextendStyle) {
        self.text = text
        self.style = style
    }

    public var body: some View {
        #if os(iOS) && !SWIFT_PACKAGE
        let normalizedText = TextendComposer.normalize(text)
        let renderedText = normalizedText.isEmpty ? "TYPE HERE" : normalizedText

        Image(uiImage: TextendRenderer.render(text: renderedText, style: style))
            .resizable()
            .interpolation(.high)
            .scaledToFit()
        #else
        let snapshot = TextendComposer.snapshot(text: text, style: style)
        let palette = TextendPalette.forStyle(style)
        let spec = snapshot.renderSpec
        let displayText = snapshot.normalizedText.isEmpty ? "TYPE HERE" : snapshot.normalizedText

        GeometryReader { proxy in
            let canvasWidth = max(proxy.size.width, 1)
            let canvasHeight = max(proxy.size.height, 1)
            let fitScale = min(
                canvasWidth / spec.canvasWidth,
                canvasHeight / spec.canvasHeight
            )

            ZStack {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(palette.previewBackdrop)

                Text(displayText)
                    .font(.system(size: 17, weight: .regular, design: .default))
                    .foregroundStyle(snapshot.normalizedText.isEmpty ? palette.secondaryForeground : palette.foreground)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                    .frame(width: spec.textBoxWidth, height: spec.textBoxHeight)
                    .scaleEffect(
                        x: spec.horizontalScale * fitScale,
                        y: spec.verticalScale * fitScale,
                        anchor: .center
                    )
                    .frame(width: spec.canvasWidth * fitScale, height: spec.canvasHeight * fitScale)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        #endif
    }
}
