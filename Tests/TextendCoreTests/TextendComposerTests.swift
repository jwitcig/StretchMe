import Testing
@testable import TextendCore

struct TextendComposerTests {
    @Test
    func normalizesToUppercase() {
        #expect(TextendComposer.normalize("hello world") == "HELLO WORLD")
    }

    @Test
    func truncatesAtMaximumCharacterCount() {
        let normalized = TextendComposer.normalize("abcdefghijklmnopqrstuvwxyz123456789")
        #expect(normalized == "ABCDEFGHIJKLMNOPQRSTUVWXYZ123")
        #expect(normalized.count == TextendComposer.maximumCharacterCount)
    }

    @Test
    func snapshotReflectsInsertabilityAndRemainingCount() {
        let snapshot = TextendComposer.snapshot(text: "stretch", style: .midnight)
        #expect(snapshot.normalizedText == "STRETCH")
        #expect(snapshot.canInsert)
        #expect(snapshot.remainingCharacterCount == 22)
        #expect(snapshot.style == .midnight)
    }

    @Test
    func emptySnapshotCannotInsert() {
        let snapshot = TextendComposer.snapshot(text: "", style: .signal)
        #expect(snapshot.canInsert == false)
        #expect(snapshot.remainingCharacterCount == TextendComposer.maximumCharacterCount)
    }
}
