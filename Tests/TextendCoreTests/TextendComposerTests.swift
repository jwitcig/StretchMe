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
        let snapshot = TextendComposer.snapshot(text: "stretch", style: .dark)
        #expect(snapshot.normalizedText == "STRETCH")
        #expect(snapshot.canInsert)
        #expect(snapshot.remainingCharacterCount == 22)
        #expect(snapshot.style == .dark)
        #expect(snapshot.renderSpec.horizontalScale == 0.38)
        #expect(snapshot.renderSpec.verticalScale == 12.6)
        #expect(snapshot.renderSpec.usesDarkAppearance)
    }

    @Test
    func emptySnapshotCannotInsert() {
        let snapshot = TextendComposer.snapshot(text: "", style: .light)
        #expect(snapshot.canInsert == false)
        #expect(snapshot.remainingCharacterCount == TextendComposer.maximumCharacterCount)
    }

    @Test
    func stylesMatchOriginalLightDarkModes() {
        #expect(TextendStyle.allCases == [.light, .dark])
        #expect(TextendComposer.renderSpec(for: .light).usesDarkAppearance == false)
    }
}
