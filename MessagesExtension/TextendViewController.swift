//
//  TextendViewController.swift
//  Textend
//
//  Created by Developer on 1/23/17.
//  Copyright © 2017 JwitApps. All rights reserved.
//

import UIKit

import FirebaseAnalytics

class TextendViewController: UIViewController, UITextFieldDelegate {

    var messageSender: MessagesViewController!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textendButton: UIButton!
    
    var imageView: UIImageView?
    
    var text: String {
        get { return textField.text ?? "" }
        set { textField.text = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.addTarget(self, action: #selector(TextendViewController.textChanged(textField:)), for: .editingChanged)
    }
    
    @objc func textChanged(textField: UITextField) {
        textendButton.isEnabled = text.count > 0
        
        text = text.uppercased()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let delay = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: delay) { 
            self.textField.becomeFirstResponder()
        }
    }
    
    @IBAction func textendPressed(sender: Any) {
        textField.resignFirstResponder()

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
    
    func renderImage(from view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        view.layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return (text as NSString).replacingCharacters(in: range, with: string).count < 30
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
