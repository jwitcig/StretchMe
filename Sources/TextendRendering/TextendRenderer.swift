import SwiftUI
import UIKit

public enum TextendRenderer {
    public static func render(text: String, style: TextendStyle) -> UIImage {
        let palette = TextendPalette.forStyle(style)
        let bounds = CGRect(x: 0, y: 0, width: 1200, height: 900)
        let renderer = UIGraphicsImageRenderer(size: bounds.size)

        return renderer.image { context in
            let cgContext = context.cgContext
            let backgroundColors = palette.backgroundGradient.map { UIColor($0).cgColor }
            let cardColors = palette.cardGradient.map { UIColor($0).cgColor }

            let gradient = CGGradient(
                colorsSpace: CGColorSpaceCreateDeviceRGB(),
                colors: backgroundColors as CFArray,
                locations: [0, 1]
            )!
            cgContext.drawLinearGradient(
                gradient,
                start: CGPoint(x: 0, y: 0),
                end: CGPoint(x: bounds.width, y: bounds.height),
                options: []
            )

            let inset = bounds.insetBy(dx: 72, dy: 88)
            let cardPath = UIBezierPath(roundedRect: inset, cornerRadius: 72)
            cgContext.saveGState()
            cgContext.setShadow(offset: CGSize(width: 0, height: 28), blur: 44, color: UIColor(palette.shadow).cgColor)
            UIColor(palette.cardGradient.first ?? .white).setFill()
            cardPath.fill()
            cgContext.restoreGState()

            let cardGradient = CGGradient(
                colorsSpace: CGColorSpaceCreateDeviceRGB(),
                colors: cardColors as CFArray,
                locations: [0, 1]
            )!
            cgContext.saveGState()
            cardPath.addClip()
            cgContext.drawLinearGradient(
                cardGradient,
                start: CGPoint(x: inset.minX, y: inset.minY),
                end: CGPoint(x: inset.maxX, y: inset.maxY),
                options: []
            )
            cgContext.restoreGState()

            let labelRect = CGRect(x: inset.minX + 48, y: inset.minY + 42, width: inset.width - 96, height: 36)
            let labelAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 30, weight: .bold),
                .foregroundColor: UIColor(palette.secondaryText)
            ]
            NSString(string: style.displayName.uppercased()).draw(in: labelRect, withAttributes: labelAttributes)

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            paragraphStyle.lineBreakMode = .byWordWrapping

            let textRect = CGRect(x: inset.minX + 56, y: inset.minY + 120, width: inset.width - 112, height: inset.height - 190)
            let textAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 140, weight: .black),
                .foregroundColor: UIColor(palette.primaryText),
                .paragraphStyle: paragraphStyle
            ]

            drawCenteredText(text, in: textRect, attributes: textAttributes)
        }
    }

    private static func drawCenteredText(_ text: String, in rect: CGRect, attributes: [NSAttributedString.Key: Any]) {
        var candidateFontSize: CGFloat = 140
        let paragraphStyle = attributes[.paragraphStyle] as? NSParagraphStyle
        let color = attributes[.foregroundColor] as? UIColor ?? .black

        while candidateFontSize >= 68 {
            let candidateAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: candidateFontSize, weight: .black),
                .foregroundColor: color,
                .paragraphStyle: paragraphStyle as Any
            ]
            let boundingRect = NSString(string: text).boundingRect(
                with: CGSize(width: rect.width, height: .greatestFiniteMagnitude),
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                attributes: candidateAttributes,
                context: nil
            )

            if boundingRect.height <= rect.height {
                let centeredRect = CGRect(
                    x: rect.minX,
                    y: rect.minY + (rect.height - boundingRect.height) / 2,
                    width: rect.width,
                    height: boundingRect.height
                )
                NSString(string: text).draw(in: centeredRect, withAttributes: candidateAttributes)
                return
            }

            candidateFontSize -= 8
        }

        NSString(string: text).draw(in: rect, withAttributes: attributes)
    }
}
