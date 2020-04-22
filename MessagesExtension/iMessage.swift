//
//  iMessage.swift
//  MessagesExtension
//
//  Created by Developer on 4/21/20.
//  Copyright © 2020 JwitApps. All rights reserved.
//

import SnapKit
import UIKit

public extension UIViewController {
    func present(_ controller: UIViewController) {
        children.forEach {
            $0.willMove(toParent: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
    
        addChild(controller)
        
        controller.view.frame = view.bounds
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(controller.view)
        
        controller.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        controller.didMove(toParent: self)
    }
    
    func throwAway<T: UIViewController>(controller: T) {
        if controller.view.superview != nil {
            controller.view.removeFromSuperview()
        }
        if controller.parent != nil {
            removeFromParent()
        }
    }
}
