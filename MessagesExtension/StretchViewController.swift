//
//  StretchViewController.swift
//  Stretcher
//
//  Created by Developer on 1/23/17.
//  Copyright © 2017 JwitApps. All rights reserved.
//

import UIKit

import FirebaseAnalytics

class StretchViewController: UIViewController, UITextFieldDelegate {

    var messageSender: MessagesViewController!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var stretchButton: UIButton!
    
    var imageView: UIImageView?
    
    var text: String {
        get { return textField.text ?? "" }
        set { textField.text = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.addTarget(self, action: #selector(StretchViewController.textChanged(textField:)), for: .editingChanged)
    }
    
    @objc func textChanged(textField: UITextField) {
        stretchButton.isEnabled = text.count > 0
        
        text = text.uppercased()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let delay = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: delay) { 
            self.textField.becomeFirstResponder()
        }
    }
    
    @IBAction func stretchPressed(sender: Any) {
        textField.resignFirstResponder()

        let image = StretchStyleKit.imageOfStretch2(stretchText: text)

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
                    self.messageSender.dismissStretchController()
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

class StretchView: UIView {
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
        StretchStyleKit.drawStretch(frame: rect, resizing: .stretch, stretchText: text)
    }
}
