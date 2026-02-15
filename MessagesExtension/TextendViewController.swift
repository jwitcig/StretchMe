//
//  TextendViewController.swift
//  Textend
//
//  Created by Developer on 1/23/17.
//  Copyright © 2017 JwitApps. All rights reserved.
//

import UIKit
import SwiftUI

import FirebaseAnalytics

class TextendViewController: UIViewController, UITextFieldDelegate {

    var messageSender: MessagesViewController!

    @IBOutlet weak var textField: UITextField?
    @IBOutlet weak var textendButton: UIButton?

    private var hostingController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 15.0, *) {
            textField?.isHidden = true
            textendButton?.isHidden = true
            embedSwiftUIComposer()
            return
        }

        textField?.addTarget(self, action: #selector(TextendViewController.textChanged(textField:)), for: .editingChanged)
    }
    
    @objc func textChanged(textField: UITextField) {
        let uppercased = (textField.text ?? "").uppercased()
        let trimmed = String(uppercased.prefix(29))
        textField.text = trimmed
        textendButton?.isEnabled = !trimmed.isEmpty
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard hostingController == nil else { return }

        let delay = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: delay) { 
            self.textField?.becomeFirstResponder()
        }
    }
    
    @IBAction func textendPressed(sender: Any) {
        insertAttachment(with: (textField?.text ?? "").uppercased())
    }

    private func insertAttachment(with rawText: String) {
        let text = String(rawText.prefix(29))
        guard !text.isEmpty else { return }

        view.endEditing(true)

        let image = TextendStyleKit.imageOfTextend2(textendText: text)

        do {
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsURL.appendingPathComponent("image.png")
           
            if let data = image.pngData() {
                try data.write(to: fileURL, options: .atomic)
            }
        
            messageSender.activeConversation?.insertAttachment(fileURL, withAlternateFilename: nil) { error in
                
                guard error == nil else {
                    print("error inserting attachment: \(error!)")
                    return
                }
                
                DispatchQueue.main.sync {
                    self.messageSender.requestPresentationStyle(.compact)
                    self.messageSender.dismissTextendController()
                }
            }
            
        } catch { }
        
        let params: [String: Any] = [
            AnalyticsParameterValue: text.count
        ]
        Analytics.logEvent("InsertPressed", parameters: params)
    }

    @available(iOS 15.0, *)
    private func embedSwiftUIComposer() {
        let rootView = TextendComposerView { [weak self] text in
            self?.insertAttachment(with: text)
        }

        let host = UIHostingController(rootView: rootView)
        host.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(host)
        view.addSubview(host.view)
        NSLayoutConstraint.activate([
            host.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            host.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            host.view.topAnchor.constraint(equalTo: view.topAnchor),
            host.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        host.didMove(toParent: self)
        hostingController = host
    }
    
    func renderImage(from view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        view.layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let current = textField.text ?? ""
        return (current as NSString).replacingCharacters(in: range, with: string).count < 30
    }
}

@available(iOS 15.0, *)
private struct TextendComposerView: View {
    private enum ThemeMode: String, CaseIterable, Identifiable {
        case light = "Light"
        case dark = "Dark"

        var id: String { rawValue }
        var colorScheme: ColorScheme {
            switch self {
            case .light: return .light
            case .dark: return .dark
            }
        }
        var background: Color {
            switch self {
            case .light: return .white
            case .dark: return .black
            }
        }
        var foreground: Color {
            switch self {
            case .light: return .black
            case .dark: return .white
            }
        }
    }

    @State private var text = ""
    @State private var theme: ThemeMode = .light
    @FocusState private var focused: Bool

    let onInsert: (String) -> Void

    private var textBinding: Binding<String> {
        Binding(
            get: { text },
            set: { newValue in
                text = String(newValue.uppercased().prefix(29))
            }
        )
    }

    private var canInsert: Bool {
        !text.isEmpty
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                theme.background
                    .ignoresSafeArea()

                VStack {
                    HStack {
                        Spacer()
                        Picker("Theme", selection: $theme) {
                            ForEach(ThemeMode.allCases) { mode in
                                Text(mode.rawValue).tag(mode)
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 170)
                    }
                    .padding(.top, 18)
                    .padding(.horizontal, 16)
                    Spacer()
                }

                VStack(spacing: 16) {
                    TextField("TYPE HERE", text: textBinding)
                        .focused($focused)
                        .textInputAutocapitalization(.characters)
                        .disableAutocorrection(true)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 34, weight: .semibold, design: .rounded))
                        .foregroundStyle(theme.foreground)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 20)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 22, style: .continuous)
                                .stroke(theme.foreground.opacity(0.25), lineWidth: 1)
                        )
                        .padding(.horizontal, 16)
                }
                .frame(width: geometry.size.width)
                .position(x: geometry.size.width / 2, y: geometry.size.height * 0.5)

                Button {
                    onInsert(text)
                } label: {
                    Label("Insert", systemImage: "paperplane.fill")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                }
                .buttonStyle(.plain)
                .foregroundStyle(theme.foreground)
                .background(.ultraThinMaterial, in: Capsule())
                .overlay(
                    Capsule()
                        .stroke(theme.foreground.opacity(0.25), lineWidth: 1)
                )
                .shadow(color: .black.opacity(theme == .dark ? 0.35 : 0.12), radius: 16, y: 10)
                .opacity(canInsert ? 1 : 0.55)
                .disabled(!canInsert)
                .frame(width: min(280, geometry.size.width - 32))
                .position(x: geometry.size.width / 2, y: geometry.size.height * 0.75)
            }
        }
        .preferredColorScheme(theme.colorScheme)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                focused = true
            }
        }
    }
}

class TextendView: UIView {
    let text: String
    
    init(frame: CGRect, text: String) {
        self.text = text
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        TextendStyleKit.drawTextend(frame: rect, resizing: .stretch, textendText: text)
    }
}
