import SwiftUI

@main
struct TextendHarnessApp: App {
    var body: some Scene {
        WindowGroup {
            TextendHarnessView()
        }
    }
}

private struct TextendHarnessView: View {
    @State private var insertedCards: [HarnessCard] = [
        HarnessCard(text: "ON MY WAY", style: .signal),
        HarnessCard(text: "RUNNING LATE", style: .midnight)
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(
                colors: [Color(red: 0.95, green: 0.96, blue: 0.99), Color.white],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Text("Harness")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                    Spacer()
                    Text("Tray Debugger")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 20)
                .padding(.top, 18)
                .padding(.bottom, 16)

                ScrollView {
                    VStack(spacing: 18) {
                        ForEach(insertedCards) { card in
                            VStack(alignment: .trailing, spacing: 8) {
                                Image(uiImage: TextendRenderer.render(text: card.text, style: card.style))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 230)
                                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                                    .shadow(color: .black.opacity(0.12), radius: 18, y: 10)

                                Text(card.timestamp.formatted(date: .omitted, time: .shortened))
                                    .font(.system(size: 12, weight: .medium, design: .rounded))
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 360)
                }
            }

            VStack(spacing: 0) {
                Capsule()
                    .fill(Color.secondary.opacity(0.3))
                    .frame(width: 42, height: 5)
                    .padding(.top, 10)

                TextendComposerScreen(initialText: "SEE YOU SOON", initialStyle: .sunrise) { text, style in
                    let normalized = TextendComposer.normalize(text)
                    guard !normalized.isEmpty else { return }
                    insertedCards.append(HarnessCard(text: normalized, style: style))
                }
            }
            .frame(height: 350)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 34, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 34, style: .continuous)
                    .stroke(Color.white.opacity(0.55), lineWidth: 1)
            )
            .padding(.horizontal, 12)
            .padding(.bottom, 8)
            .shadow(color: .black.opacity(0.18), radius: 24, y: 14)
        }
    }
}

private struct HarnessCard: Identifiable {
    let id = UUID()
    let text: String
    let style: TextendStyle
    let timestamp = Date()
}
