import UIKit

public enum TextendRenderer {
    public static func render(text: String, style: TextendStyle) -> UIImage {
        let snapshot = TextendComposer.snapshot(text: text, style: style)
        let spec = snapshot.renderSpec
        let size = CGSize(width: spec.canvasWidth, height: spec.canvasHeight)
        let renderer = UIGraphicsImageRenderer(size: size)

        return renderer.image { _ in
            let context = UIGraphicsGetCurrentContext()!
            let foregroundColor: UIColor = style == .dark ? .white : .black

            context.saveGState()
            context.scaleBy(x: spec.horizontalScale, y: spec.verticalScale)

            let textRect = CGRect(x: 0, y: 0, width: spec.textBoxWidth, height: spec.textBoxHeight)
            let textStyle = NSMutableParagraphStyle()
            textStyle.alignment = .center
            textStyle.lineBreakMode = .byClipping

            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: UIFont.systemFontSize),
                .foregroundColor: foregroundColor,
                .paragraphStyle: textStyle,
            ]

            let renderedText = snapshot.normalizedText.isEmpty ? "TYPE HERE" : snapshot.normalizedText
            let textHeight = renderedText.boundingRect(
                with: CGSize(width: textRect.width, height: .greatestFiniteMagnitude),
                options: .usesLineFragmentOrigin,
                attributes: attributes,
                context: nil
            ).height

            context.saveGState()
            context.clip(to: textRect)
            renderedText.draw(
                in: CGRect(
                    x: textRect.minX,
                    y: textRect.minY + (textRect.height - textHeight) / 2,
                    width: textRect.width,
                    height: textHeight
                ),
                withAttributes: attributes
            )
            context.restoreGState()
            context.restoreGState()
        }
    }
}
