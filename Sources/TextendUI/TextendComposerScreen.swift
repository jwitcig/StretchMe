import SwiftUI
#if SWIFT_PACKAGE
import TextendCore
#endif

public struct TextendComposerScreen: View {
    @StateObject private var viewModel: TextendComposerViewModel

    let onInsert: (String, TextendStyle) -> Void

    public init(
        initialText: String = "",
        initialStyle: TextendStyle = .signal,
        onInsert: @escaping (String, TextendStyle) -> Void
    ) {
        _viewModel = StateObject(wrappedValue: TextendComposerViewModel(text: initialText, selectedStyle: initialStyle))
        self.onInsert = onInsert
    }

    public var body: some View {
        GeometryReader { proxy in
            let compactLayout = proxy.size.height < 360

            ZStack {
                LinearGradient(
                    colors: viewModel.palette.backgroundGradient,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: compactLayout ? 18 : 24) {
                        TextendHeaderView()

                        TextendPreviewCard(
                            text: viewModel.previewText,
                            palette: viewModel.palette
                        )

                        TextendInputCard(
                            text: $viewModel.text,
                            remainingCharacters: viewModel.remainingCharacterCount,
                            palette: viewModel.palette
                        )

                        TextendStylePicker(
                            selectedStyle: $viewModel.selectedStyle
                        )

                        Button {
                            onInsert(viewModel.text, viewModel.selectedStyle)
                        } label: {
                            Label("Insert into Message", systemImage: "arrow.up.circle.fill")
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                        }
                        .buttonStyle(TextendPrimaryButtonStyle(palette: viewModel.palette))
                        .disabled(!viewModel.canInsert)
                        .opacity(viewModel.canInsert ? 1 : 0.55)
                    }
                    .padding(.horizontal, compactLayout ? 16 : 22)
                    .padding(.vertical, compactLayout ? 16 : 20)
                }
            }
        }
    }
}

private struct TextendHeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Textend")
                .font(.system(size: 34, weight: .black, design: .rounded))

            Text("Turn a short phrase into a loud card for the conversation.")
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct TextendPreviewCard: View {
    let text: String
    let palette: TextendPalette

    var body: some View {
        RoundedRectangle(cornerRadius: 28, style: .continuous)
            .fill(
                LinearGradient(
                    colors: palette.cardGradient,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay(alignment: .topLeading) {
                Text("LIVE PREVIEW")
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .tracking(1.4)
                    .foregroundStyle(palette.secondaryText)
                    .padding(18)
            }
            .overlay {
                Text(text)
                    .font(.system(size: 40, weight: .black, design: .rounded))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.55)
                    .foregroundStyle(palette.primaryText)
                    .padding(28)
            }
            .frame(height: 210)
            .shadow(color: palette.shadow, radius: 20, y: 14)
    }
}

private struct TextendInputCard: View {
    @Binding var text: String
    let remainingCharacters: Int
    let palette: TextendPalette
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Message")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                Spacer()
                Text("\(remainingCharacters) left")
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundStyle(palette.secondaryText)
            }

            TextField("TYPE HERE", text: $text, axis: .vertical)
                .focused($isFocused)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundStyle(palette.primaryText)
                .padding(18)
                .background(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(palette.inputFill)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(palette.inputStroke, lineWidth: 1)
                )
        }
        .padding(18)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                isFocused = true
            }
        }
        .modifier(TextInputPlatformBehavior())
    }
}

private struct TextInputPlatformBehavior: ViewModifier {
    func body(content: Content) -> some View {
        #if os(iOS)
        content
            .textInputAutocapitalization(.characters)
            .autocorrectionDisabled(true)
        #else
        content
        #endif
    }
}

private struct TextendStylePicker: View {
    @Binding var selectedStyle: TextendStyle

    var body: some View {
        HStack(spacing: 10) {
            ForEach(TextendStyle.allCases, id: \.self) { style in
                Button {
                    selectedStyle = style
                } label: {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(style.displayName)
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                        Text(styleDescription(for: style))
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundStyle(style == .midnight ? Color.white.opacity(0.78) : .secondary)
                            .lineLimit(2)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(14)
                    .background(background(for: style), in: RoundedRectangle(cornerRadius: 22, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .stroke(selectedStyle == style ? Color.primary : Color.primary.opacity(0.12), lineWidth: selectedStyle == style ? 2 : 1)
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func styleDescription(for style: TextendStyle) -> String {
        switch style {
        case .signal:
            "Bright and punchy"
        case .midnight:
            "High-contrast night mode"
        case .sunrise:
            "Warm poster energy"
        }
    }

    private func background(for style: TextendStyle) -> LinearGradient {
        switch style {
        case .signal:
            LinearGradient(colors: [.white.opacity(0.9), Color(red: 0.82, green: 0.95, blue: 1)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .midnight:
            LinearGradient(colors: [Color(red: 0.18, green: 0.21, blue: 0.34), Color(red: 0.04, green: 0.06, blue: 0.13)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .sunrise:
            LinearGradient(colors: [Color(red: 1, green: 0.91, blue: 0.68), Color(red: 1, green: 0.73, blue: 0.52)], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}

private struct TextendPrimaryButtonStyle: ButtonStyle {
    let palette: TextendPalette

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(palette.buttonText)
            .background(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(palette.buttonFill)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .stroke(palette.buttonStroke, lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut(duration: 0.14), value: configuration.isPressed)
    }
}
