import Foundation
import AppKit
import SwiftUI
import TextendCore
import TextendUI

@main
struct TextendCLI {
    static func main() async throws {
        var arguments = Array(CommandLine.arguments.dropFirst())
        guard let command = arguments.first else {
            printUsage()
            return
        }

        arguments.removeFirst()

        switch command {
        case "styles":
            try printStyles()
        case "snapshot":
            try printSnapshot(arguments: arguments)
        case "render-preview":
            try await renderPreview(arguments: arguments)
        default:
            printUsage()
            throw ExitCode.failure
        }
    }

    private static func printStyles() throws {
        let payload = TextendStyle.allCases.map(\.rawValue)
        try writeJSON(payload)
    }

    private static func printSnapshot(arguments: [String]) throws {
        var text = ""
        var style = TextendStyle.signal
        var index = 0

        while index < arguments.count {
            let argument = arguments[index]
            switch argument {
            case "--text":
                index += 1
                guard index < arguments.count else { throw ExitCode.failure }
                text = arguments[index]
            case "--style":
                index += 1
                guard index < arguments.count,
                      let parsedStyle = TextendStyle(rawValue: arguments[index]) else {
                    throw ExitCode.failure
                }
                style = parsedStyle
            default:
                throw ExitCode.failure
            }
            index += 1
        }

        try writeJSON(TextendComposer.snapshot(text: text, style: style))
    }

    private static func renderPreview(arguments: [String]) async throws {
        var text = "TEXTEND"
        var style = TextendStyle.signal
        var outputPath: String?
        var index = 0

        while index < arguments.count {
            let argument = arguments[index]
            switch argument {
            case "--text":
                index += 1
                guard index < arguments.count else { throw ExitCode.failure }
                text = arguments[index]
            case "--style":
                index += 1
                guard index < arguments.count,
                      let parsedStyle = TextendStyle(rawValue: arguments[index]) else {
                    throw ExitCode.failure
                }
                style = parsedStyle
            case "--output":
                index += 1
                guard index < arguments.count else { throw ExitCode.failure }
                outputPath = arguments[index]
            default:
                throw ExitCode.failure
            }
            index += 1
        }

        guard let outputPath else { throw ExitCode.failure }

        let cgImage = try await MainActor.run { () throws -> CGImage in
            let view = TextendComposerScreen(initialText: text, initialStyle: style) { _, _ in }
                .frame(width: 402, height: 874)
            let renderer = ImageRenderer(content: view)
            renderer.scale = 2

            guard let cgImage = renderer.cgImage else { throw ExitCode.failure }
            return cgImage
        }
        let representation = NSBitmapImageRep(cgImage: cgImage)
        guard let data = representation.representation(using: .png, properties: [:]) else {
            throw ExitCode.failure
        }

        let url = URL(fileURLWithPath: outputPath)
        try FileManager.default.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
        try data.write(to: url)

        print(url.path)
    }

    private static func writeJSON<T: Encodable>(_ value: T) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(value)
        guard let string = String(data: data, encoding: .utf8) else {
            throw ExitCode.failure
        }
        print(string)
    }

    private static func printUsage() {
        let usage = """
        Usage:
          textend-cli styles
          textend-cli snapshot --text "hello world" [--style signal|midnight|sunrise]
          textend-cli render-preview --text "hello world" [--style signal|midnight|sunrise] --output /tmp/textend-preview.png
        """
        print(usage)
    }
}

private enum ExitCode: Error {
    case failure
}
