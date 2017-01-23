//
//  DesignsStyleKit.swift
//  StretchMe
//
//  Created by KtJW on 1/23/17.
//  Copyright © 2017 KTJW. All rights reserved.
//
//  Generated by PaintCode
//  http://www.paintcodeapp.com
//



import UIKit

public class DesignsStyleKit : NSObject {

    //// Drawing Methods

    public dynamic class func drawGenerateButton(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 170, height: 63), resizing: ResizingBehavior = .aspectFit, buttonFill: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 170, height: 63), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 170, y: resizedFrame.height / 63)


        //// Symbol Drawing
        let symbolRect = CGRect(x: 0, y: -0, width: 170, height: 63)
        context.saveGState()
        context.clip(to: symbolRect)
        context.translateBy(x: symbolRect.minX, y: symbolRect.minY)

        DesignsStyleKit.drawShapeSymbol(frame: CGRect(origin: .zero, size: symbolRect.size), resizing: .stretch, buttonFill: buttonFill, buttonText: "Generate New")
        context.restoreGState()
        
        context.restoreGState()

    }

    public dynamic class func drawInsertButton(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 170, height: 63), resizing: ResizingBehavior = .aspectFit, buttonFill: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 170, height: 63), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 170, y: resizedFrame.height / 63)


        //// Symbol Drawing
        let symbolRect = CGRect(x: 0, y: 0, width: 170, height: 63)
        context.saveGState()
        context.clip(to: symbolRect)
        context.translateBy(x: symbolRect.minX, y: symbolRect.minY)

        DesignsStyleKit.drawShapeSymbol(frame: CGRect(origin: .zero, size: symbolRect.size), resizing: .stretch, buttonFill: buttonFill, buttonText: "Insert Image")
        context.restoreGState()
        
        context.restoreGState()

    }

    public dynamic class func drawShapeSymbol(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 173, height: 66), resizing: ResizingBehavior = .aspectFit, buttonFill: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000), buttonText: String = "Button Text") {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 173, height: 66), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 173, y: resizedFrame.height / 66)
        let resizedShadowScale: CGFloat = min(resizedFrame.width / 173, resizedFrame.height / 66)


        //// Color Declarations
        var buttonFillHueComponent: CGFloat = 1
        var buttonFillSaturationComponent: CGFloat = 1
        var buttonFillBrightnessComponent: CGFloat = 1
        buttonFill.getHue(&buttonFillHueComponent, saturation: &buttonFillSaturationComponent, brightness: &buttonFillBrightnessComponent, alpha: nil)

        let color4 = UIColor(hue: buttonFillHueComponent, saturation: buttonFillSaturationComponent, brightness: 0.8, alpha: buttonFill.cgColor.alpha)
        let bottomGradientColor = UIColor(red: 0.714, green: 0.714, blue: 0.714, alpha: 1.000)
        let color = UIColor(red: 0.333, green: 0.333, blue: 0.333, alpha: 1.000)
        let gradientColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.000)

        //// Gradient Declarations
        let buttonFillGradient = CGGradient(colorsSpace: nil, colors: [buttonFill.cgColor, color4.cgColor] as CFArray, locations: [0, 1])!
        let bottomGradient = CGGradient(colorsSpace: nil, colors: [bottomGradientColor.cgColor, UIColor.white.cgColor] as CFArray, locations: [0, 1])!
        let gradient = CGGradient(colorsSpace: nil, colors: [gradientColor.cgColor, UIColor.white.cgColor] as CFArray, locations: [0, 1])!

        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black
        shadow.shadowOffset = CGSize(width: 0, height: 0)
        shadow.shadowBlurRadius = 1

        //// Rectangle Drawing
        context.saveGState()
        context.setAlpha(0.8)
        context.setBlendMode(.multiply)
        context.beginTransparencyLayer(auxiliaryInfo: nil)

        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 1.5, y: 1, width: 170, height: 63), cornerRadius: 31.5)
        context.saveGState()
        rectanglePath.addClip()
        context.drawLinearGradient(bottomGradient, start: CGPoint(x: 86.5, y: 1), end: CGPoint(x: 86.5, y: 64), options: [])
        context.restoreGState()

        ////// Rectangle Inner Shadow
        context.saveGState()
        context.clip(to: rectanglePath.bounds)
        context.setShadow(offset: CGSize.zero, blur: 0)
        context.setAlpha((shadow.shadowColor as! UIColor).cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let rectangleOpaqueShadow = (shadow.shadowColor as! UIColor).withAlphaComponent(1)
        context.setShadow(offset: CGSize(width: shadow.shadowOffset.width * resizedShadowScale, height: shadow.shadowOffset.height * resizedShadowScale), blur: shadow.shadowBlurRadius * resizedShadowScale, color: rectangleOpaqueShadow.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)

        rectangleOpaqueShadow.setFill()
        rectanglePath.fill()

        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()


        context.endTransparencyLayer()
        context.restoreGState()


        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(roundedRect: CGRect(x: 12.5, y: 9, width: 148.5, height: 47), cornerRadius: 23.5)
        context.saveGState()
        rectangle2Path.addClip()
        context.drawLinearGradient(buttonFillGradient, start: CGPoint(x: 86.75, y: 9), end: CGPoint(x: 86.75, y: 56), options: [])
        context.restoreGState()
        color.setStroke()
        rectangle2Path.lineWidth = 2.5
        rectangle2Path.lineCapStyle = .round
        rectangle2Path.lineJoinStyle = .round
        rectangle2Path.stroke()


        //// Text Drawing
        let textRect = CGRect(x: 12, y: 12, width: 148, height: 42)
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        let textFontAttributes = [NSFontAttributeName: UIFont(name: "SignPainter-HouseScript", size: 30)!, NSForegroundColorAttributeName: UIColor.darkGray, NSParagraphStyleAttributeName: textStyle]

        let textTextHeight: CGFloat = buttonText.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: textRect)
        buttonText.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight), withAttributes: textFontAttributes)
        context.restoreGState()


        //// Bezier Drawing
        context.saveGState()
        context.setAlpha(0.5)

        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 146.74, y: 10.24))
        bezierPath.addLine(to: CGPoint(x: 147.65, y: 10.46))
        bezierPath.addCurve(to: CGPoint(x: 159.6, y: 20.6), controlPoint1: CGPoint(x: 152.88, y: 12.33), controlPoint2: CGPoint(x: 157.07, y: 16))
        bezierPath.addCurve(to: CGPoint(x: 83.53, y: 30.7), controlPoint1: CGPoint(x: 147.6, y: 26.52), controlPoint2: CGPoint(x: 118.06, y: 30.7))
        bezierPath.addCurve(to: CGPoint(x: 13, y: 22.81), controlPoint1: CGPoint(x: 53.49, y: 30.7), controlPoint2: CGPoint(x: 27.22, y: 27.53))
        bezierPath.addCurve(to: CGPoint(x: 26.01, y: 10.46), controlPoint1: CGPoint(x: 15.32, y: 17.18), controlPoint2: CGPoint(x: 19.97, y: 12.62))
        bezierPath.addCurve(to: CGPoint(x: 42.71, y: 8.71), controlPoint1: CGPoint(x: 30.75, y: 8.99), controlPoint2: CGPoint(x: 35.21, y: 8.75))
        bezierPath.addCurve(to: CGPoint(x: 47.43, y: 8.7), controlPoint1: CGPoint(x: 44.17, y: 8.7), controlPoint2: CGPoint(x: 45.73, y: 8.7))
        bezierPath.addLine(to: CGPoint(x: 93.93, y: 8.7))
        bezierPath.addCurve(to: CGPoint(x: 146.74, y: 10.24), controlPoint1: CGPoint(x: 136.74, y: 8.7), controlPoint2: CGPoint(x: 142, y: 8.7))
        bezierPath.close()
        context.saveGState()
        bezierPath.addClip()
        context.drawLinearGradient(gradient,
            start: CGPoint(x: 82.52, y: 10.02),
            end: CGPoint(x: 82.4, y: 20.73),
            options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        context.restoreGState()

        context.restoreGState()
        
        context.restoreGState()

    }

    public dynamic class func drawGenerateButtonDepressed(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 170, height: 63), resizing: ResizingBehavior = .aspectFit, buttonFill: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 170, height: 63), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 170, y: resizedFrame.height / 63)


        //// Color Declarations
        var buttonFillHueComponent: CGFloat = 1
        var buttonFillSaturationComponent: CGFloat = 1
        var buttonFillBrightnessComponent: CGFloat = 1
        buttonFill.getHue(&buttonFillHueComponent, saturation: &buttonFillSaturationComponent, brightness: &buttonFillBrightnessComponent, alpha: nil)

        let color4 = UIColor(hue: buttonFillHueComponent, saturation: buttonFillSaturationComponent, brightness: 0.8, alpha: buttonFill.cgColor.alpha)

        //// Symbol Drawing
        let symbolRect = CGRect(x: 0, y: 0, width: 170, height: 63)
        context.saveGState()
        context.clip(to: symbolRect)
        context.translateBy(x: symbolRect.minX, y: symbolRect.minY)

        DesignsStyleKit.drawGenerateButton(frame: CGRect(origin: .zero, size: symbolRect.size), resizing: .stretch, buttonFill: color4)
        context.restoreGState()
        
        context.restoreGState()

    }

    public dynamic class func drawInsertButtonDepressed(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 170, height: 63), resizing: ResizingBehavior = .aspectFit, buttonFill: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 170, height: 63), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 170, y: resizedFrame.height / 63)


        //// Color Declarations
        var buttonFillHueComponent: CGFloat = 1
        var buttonFillSaturationComponent: CGFloat = 1
        var buttonFillBrightnessComponent: CGFloat = 1
        buttonFill.getHue(&buttonFillHueComponent, saturation: &buttonFillSaturationComponent, brightness: &buttonFillBrightnessComponent, alpha: nil)

        let color4 = UIColor(hue: buttonFillHueComponent, saturation: buttonFillSaturationComponent, brightness: 0.8, alpha: buttonFill.cgColor.alpha)

        //// Symbol Drawing
        let symbolRect = CGRect(x: 0, y: 0, width: 170, height: 63)
        context.saveGState()
        context.clip(to: symbolRect)
        context.translateBy(x: symbolRect.minX, y: symbolRect.minY)

        DesignsStyleKit.drawShapeSymbol(frame: CGRect(origin: .zero, size: symbolRect.size), resizing: .stretch, buttonFill: color4, buttonText: "Insert Image")
        context.restoreGState()
        
        context.restoreGState()

    }

    public dynamic class func drawMainScreenBackground(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 319, height: 250), resizing: ResizingBehavior = .aspectFit, background: UIColor = UIColor(red: 0.357, green: 0.804, blue: 0.455, alpha: 1.000)) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 319, height: 250), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 319, y: resizedFrame.height / 250)



        //// Gradient Declarations
        let backgroundGradient = CGGradient(colorsSpace: nil, colors: [background.cgColor, UIColor.black.cgColor] as CFArray, locations: [0, 1])!

        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 320, height: 250))
        context.saveGState()
        rectanglePath.addClip()
        context.drawRadialGradient(backgroundGradient,
            startCenter: CGPoint(x: 160, y: 125), startRadius: 4.86,
            endCenter: CGPoint(x: 160, y: 125), endRadius: 332.24,
            options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        context.restoreGState()
        
        context.restoreGState()

    }

    public dynamic class func drawCanvas1(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 7, height: 291), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 7, height: 291), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 7, y: resizedFrame.height / 291)


        //// Color Declarations
        let thinLine = UIColor(red: 0.400, green: 0.400, blue: 0.400, alpha: 1.000)

        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 7, height: 291))
        thinLine.setFill()
        rectangle2Path.fill()
        
        context.restoreGState()

    }

    public dynamic class func drawPatternJawnPreview(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 319, height: 250), resizing: ResizingBehavior = .aspectFit, buttonFill: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000), background: UIColor = UIColor(red: 0.357, green: 0.804, blue: 0.455, alpha: 1.000)) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 319, height: 250), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 319, y: resizedFrame.height / 250)


        //// Symbol 2 Drawing
        let symbol2Rect = CGRect(x: -1, y: 0, width: 320, height: 250)
        context.saveGState()
        context.clip(to: symbol2Rect)
        context.translateBy(x: symbol2Rect.minX, y: symbol2Rect.minY)

        DesignsStyleKit.drawMainScreenBackground(frame: CGRect(origin: .zero, size: symbol2Rect.size), resizing: .stretch, background: background)
        context.restoreGState()


        //// Symbol Drawing
        let symbolRect = CGRect(x: 74, y: 93, width: 170, height: 63)
        context.saveGState()
        context.clip(to: symbolRect)
        context.translateBy(x: symbolRect.minX, y: symbolRect.minY)

        DesignsStyleKit.drawGenerateButton(frame: CGRect(origin: .zero, size: symbolRect.size), resizing: .stretch, buttonFill: buttonFill)
        context.restoreGState()
        
        context.restoreGState()

    }

    public dynamic class func drawInsertImageBackground(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 319, height: 250), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 319, height: 250), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 319, y: resizedFrame.height / 250)


        //// Color Declarations
        let color3 = UIColor(red: 0.317, green: 0.658, blue: 0.873, alpha: 1.000)

        //// Symbol 2 Drawing
        let symbol2Rect = CGRect(x: 15, y: 0, width: 1, height: 250)
        context.saveGState()
        context.clip(to: symbol2Rect)
        context.translateBy(x: symbol2Rect.minX, y: symbol2Rect.minY)

        DesignsStyleKit.drawCanvas1(frame: CGRect(origin: .zero, size: symbol2Rect.size), resizing: .stretch)
        context.restoreGState()


        //// Symbol 3 Drawing
        let symbol3Rect = CGRect(x: 305, y: 0, width: 1, height: 250)
        context.saveGState()
        context.clip(to: symbol3Rect)
        context.translateBy(x: symbol3Rect.minX, y: symbol3Rect.minY)

        DesignsStyleKit.drawCanvas1(frame: CGRect(origin: .zero, size: symbol3Rect.size), resizing: .stretch)
        context.restoreGState()


        //// Symbol Drawing
        let symbolRect = CGRect(x: 0, y: 15, width: 320, height: 1)
        context.saveGState()
        context.clip(to: symbolRect)
        context.translateBy(x: symbolRect.minX, y: symbolRect.minY)

        DesignsStyleKit.drawCanvas1(frame: CGRect(origin: .zero, size: symbolRect.size), resizing: .stretch)
        context.restoreGState()


        //// Symbol 4 Drawing
        let symbol4Rect = CGRect(x: 0, y: 235, width: 320, height: 1)
        context.saveGState()
        context.clip(to: symbol4Rect)
        context.translateBy(x: symbol4Rect.minX, y: symbol4Rect.minY)

        DesignsStyleKit.drawCanvas1(frame: CGRect(origin: .zero, size: symbol4Rect.size), resizing: .stretch)
        context.restoreGState()


        //// Symbol 5 Drawing
        let symbol5Rect = CGRect(x: 0, y: 0, width: 320, height: 250)
        context.saveGState()
        context.clip(to: symbol5Rect)
        context.translateBy(x: symbol5Rect.minX, y: symbol5Rect.minY)

        DesignsStyleKit.drawMainScreenBackground(frame: CGRect(origin: .zero, size: symbol5Rect.size), resizing: .stretch, background: color3)
        context.restoreGState()
        
        context.restoreGState()

    }

    public dynamic class func drawPatternJawn2Preview(frame: CGRect = CGRect(x: 0, y: 0, width: 320, height: 250), buttonFill: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!

        //// Symbol 6 Drawing
        let symbol6Rect = CGRect(x: frame.minX, y: frame.minY, width: 320, height: 250)
        context.saveGState()
        context.clip(to: symbol6Rect)
        context.translateBy(x: symbol6Rect.minX, y: symbol6Rect.minY)

        DesignsStyleKit.drawInsertImageBackground(frame: CGRect(origin: .zero, size: symbol6Rect.size), resizing: .stretch)
        context.restoreGState()


        //// Symbol 5 Drawing
        let symbol5Rect = CGRect(x: frame.minX + 75, y: frame.minY + 93, width: 170, height: 63)
        context.saveGState()
        context.clip(to: symbol5Rect)
        context.translateBy(x: symbol5Rect.minX, y: symbol5Rect.minY)

        DesignsStyleKit.drawInsertButton(frame: CGRect(origin: .zero, size: symbol5Rect.size), resizing: .stretch, buttonFill: buttonFill)
        context.restoreGState()
    }




    @objc public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.

        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }

            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)

            switch self {
                case .aspectFit:
                    scales.width = min(scales.width, scales.height)
                    scales.height = scales.width
                case .aspectFill:
                    scales.width = max(scales.width, scales.height)
                    scales.height = scales.width
                case .stretch:
                    break
                case .center:
                    scales.width = 1
                    scales.height = 1
            }

            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}