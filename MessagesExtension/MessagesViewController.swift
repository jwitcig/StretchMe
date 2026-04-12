import Messages
import SwiftUI

final class MessagesViewController: MSMessagesAppViewController {
    private var hostingController: UIHostingController<TextendComposerScreen>?

    override func viewDidLoad() {
        super.viewDidLoad()
        embedRootView()
    }

    private func embedRootView() {
        let rootView = TextendComposerScreen { [weak self] text, style in
            self?.insertAttachment(text: text, style: style)
        }

        let host = UIHostingController(rootView: rootView)
        addChild(host)
        host.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(host.view)

        NSLayoutConstraint.activate([
            host.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            host.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            host.view.topAnchor.constraint(equalTo: view.topAnchor),
            host.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        host.didMove(toParent: self)
        hostingController = host
    }

    private func insertAttachment(text: String, style: TextendStyle) {
        let normalizedText = TextendComposer.normalize(text)
        guard !normalizedText.isEmpty else { return }

        let image = TextendRenderer.render(text: normalizedText, style: style)
        let fileURL = FileManager.default.temporaryDirectory
            .appendingPathComponent("textend-\(UUID().uuidString)")
            .appendingPathExtension("png")

        do {
            guard let data = image.pngData() else { return }
            try data.write(to: fileURL, options: .atomic)
        } catch {
            return
        }

        activeConversation?.insertAttachment(fileURL, withAlternateFilename: "textend.png") { [weak self] error in
            guard error == nil, let self else { return }
            DispatchQueue.main.async {
                self.requestPresentationStyle(.compact)
            }
        }
    }
}
