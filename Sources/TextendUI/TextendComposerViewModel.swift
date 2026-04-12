import SwiftUI
#if SWIFT_PACKAGE
import TextendCore
#endif

@MainActor
public final class TextendComposerViewModel: ObservableObject {
    @Published public var text: String {
        didSet {
            let normalized = TextendComposer.normalize(text)
            if normalized != text {
                text = normalized
            }
        }
    }

    @Published public var selectedStyle: TextendStyle

    public init(text: String = "", selectedStyle: TextendStyle = .light) {
        self.text = TextendComposer.normalize(text)
        self.selectedStyle = selectedStyle
    }

    public var canInsert: Bool {
        !text.isEmpty
    }

    public var remainingCharacterCount: Int {
        TextendComposer.maximumCharacterCount - text.count
    }

    public var previewText: String {
        text.isEmpty ? "TYPE HERE" : text
    }

    public var snapshot: TextendSnapshot {
        TextendComposer.snapshot(text: text, style: selectedStyle)
    }

    public var palette: TextendPalette {
        TextendPalette.forStyle(selectedStyle)
    }
}
